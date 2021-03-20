FROM rust:1.50-alpine3.13 as builder
COPY . /src/
WORKDIR /src
RUN cargo build --release --verbose

FROM alpine as runtime
COPY --from=0 /src/target/release/brando /brando/
WORKDIR /brando
ENTRYPOINT /brando/brando
VOLUME /data
