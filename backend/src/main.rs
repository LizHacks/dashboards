extern crate actix;
extern crate actix_web;
extern crate config;
extern crate postgres;
extern crate serde;
#[macro_use]
extern crate serde_derive;
extern crate r2d2;
extern crate r2d2_postgres;

mod dao;
mod settings;

use actix_web::middleware::cors::Cors;
use actix_web::{fs, http, server::HttpServer, App, HttpRequest, HttpResponse};

use dao::{PostgresDAO, DAO};

use r2d2_postgres::{PostgresConnectionManager, TlsMode};
use settings::Settings;

struct AppState {
    pub settings: Settings,
    pub dao: Box<DAO>,
}

fn main() {
    let sys = actix::System::new("web");

    let http_server = HttpServer::new(|| {
        let settings = Settings::new().unwrap();
        let manager =
            PostgresConnectionManager::new(settings.database.url.clone(), TlsMode::None).unwrap();
        let connection = r2d2::Pool::new(manager).unwrap();
        let dao = Box::new(PostgresDAO::new(connection));
        App::with_state(AppState { settings, dao })
            .configure(|app| {
                Cors::for_app(app)
                    .allowed_methods(vec!["GET", "POST"])
                    .allowed_header(http::header::CONTENT_TYPE)
                    .allowed_header(http::header::ACCEPT)
                    .max_age(3600)
                    .resource("/health", |r| r.f(|_| HttpResponse::Ok().body("ok")))
                    .register()
            })
            .handler(
                "/assets",
                fs::StaticFiles::new("./static/assets")
                    .expect("Couldn't load static assets folder"),
            )
            .handler("/", |_req: &HttpRequest<AppState>| {
                HttpResponse::Ok()
                    .content_type("text/html; charset=utf-8")
                    .body(include_str!("../static/assets/index.html"))
            })
    });

    http_server
        .bind(String::from("0.0.0.0:8080"))
        .expect("Couldn't bind to http")
        .start();

    let _ = sys.run();
}
