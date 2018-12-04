#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Status {
    products: Vec<Product>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Product {
    name: ProductName,
    environments: Vec<ProductEnvironment>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum ProductName {
    CancerModelsPlatform,
    Discover,
    ProvisionalName,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ProductEnvironment {
    name: ProductEnvironmentName,
    last_build: Build,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum ProductEnvironmentName {
    ReleaseCandidate,
    Production,
    Demo,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Build {
    id: String,
    ci_link: String,
    status: BuildStatus,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum BuildStatus {
    Failed,
    Success,
    OnProcess,
}
