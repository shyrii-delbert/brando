use actix_web::{get, post, App, HttpResponse, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

#[get("/health")]
async fn health_checker() -> impl Responder {
    HttpResponse::Ok().body("Health")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(hello)
            .service(health_checker)
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}
