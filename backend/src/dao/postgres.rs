use super::Events;
use super::Status;
use super::DAO;

use r2d2::{ManageConnection, Pool};

pub struct PostgresDAO<M>
where
    M: ManageConnection,
{
    pool: Pool<M>,
}

impl<M> PostgresDAO<M>
where
    M: ManageConnection,
{
    pub fn new(pool: Pool<M>) -> Self {
        Self { pool }
    }
}

impl<M> DAO for PostgresDAO<M>
where
    M: ManageConnection,
{
    fn save_event(&self, event: Events) -> Result<String, String> {
        let _conn = self.pool.get().unwrap();
        Err("NotImplemented".into())
    }
    fn get_status(&self) -> Result<Status, String> {
        Err("NotImplemented".into())
    }
}
