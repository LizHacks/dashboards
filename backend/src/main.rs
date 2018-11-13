extern crate actix;
extern crate actix_web;

use actix_web::{fs, server::HttpServer, App, HttpRequest, HttpResponse};

struct AppState {}

fn main() {
    let sys = actix::System::new("web");

    let http_server = HttpServer::new(|| {
        App::with_state(AppState {})
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
