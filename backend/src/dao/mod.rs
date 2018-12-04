mod events;
mod objects;
mod postgres;

pub use self::events::Events;
pub use self::objects::Status;
pub use self::postgres::PostgresDAO;

pub trait DAO {
    fn save_event(&self, event: Events) -> Result<String, String>;
    fn get_status(&self) -> Result<Status, String>;
}
