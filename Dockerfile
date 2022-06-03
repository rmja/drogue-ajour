FROM --platform=$BUILDPLATFORM ghcr.io/drogue-iot/builder:0.1.20 as builder

RUN mkdir /build
ADD . /build
WORKDIR /build

RUN cargo build --release

FROM registry.access.redhat.com/ubi8-minimal

LABEL org.opencontainers.image.source="https://github.com/drogue-iot/drogue-ajour"

COPY --from=builder /build/target/release/drogue-ajour /
COPY --from=builder /build/scripts/start.sh /

ENTRYPOINT [ "/start.sh" ]
