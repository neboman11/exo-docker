FROM docker.io/tensorflow/tensorflow:2.18.0

RUN apt update && apt install -y --no-install-recommends git libgl1 clang python3-clang python3-llvmlite

WORKDIR /App

RUN git clone https://github.com/exo-explore/exo.git
WORKDIR /App/exo
RUN bash -c "source install.sh"
RUN bash -c "source .venv/bin/activate && pip install tensorflow-cpu llvmlite"
RUN mkdir -pv /App/exo/data

ENV EXO_HOME=/App/exo/data

ENTRYPOINT [ "bash", "-c", "source .venv/bin/activate && exo" ]
