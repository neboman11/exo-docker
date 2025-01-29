FROM docker.io/library/python:3.12 AS build

WORKDIR /App

RUN git clone https://github.com/exo-explore/exo.git
WORKDIR /App/exo
RUN bash -c "source install.sh"
RUN bash -c "source .venv/bin/activate && pip install tensorflow-cpu llvmlite"
RUN mkdir -pv /App/exo/data

FROM docker.io/tailscale/tailscale:latest
COPY --from=build /App /App

WORKDIR /App

RUN apk update && apk add python3 mesa-gl clang bash

ENV EXO_HOME=/App/exo/data

ENTRYPOINT [ "bash", "-c", "source .venv/bin/activate && exo" ]
