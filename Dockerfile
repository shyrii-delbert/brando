FROM rust:1.50-alpine3.13 as builder
RUN apk add musl-dev
WORKDIR /src
COPY Cargo.lock Cargo.toml ./
RUN mkdir src
RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs
RUN cargo build --release --verbose
RUN rm -f target/release/deps/brando
COPY . .
# this is where the magic happens
# https://github.com/rust-lang/cargo/issues/7181
RUN touch src/main.rs
RUN cargo build --release --verbose

FROM alpine as runtime
COPY --from=0 /src/target/release/brando /brando/
WORKDIR /brando
ENTRYPOINT /brando/brando
VOLUME /data
