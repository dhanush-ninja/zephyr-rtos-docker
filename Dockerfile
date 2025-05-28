FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y wget gnupg software-properties-common lsb-release apt-transport-https ca-certificates

RUN add-apt-repository ppa:deadsnakes/ppa && \
    wget https://apt.kitware.com/kitware-archive.sh && \
    bash kitware-archive.sh

RUN apt update && apt install -y --no-install-recommends \
    git cmake ninja-build gperf ccache dfu-util device-tree-compiler wget \
    python3.10 python3.10-venv python3.10-dev python3.10-distutils python3-setuptools python3-wheel python3-tk \
    xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1 socat unzip curl \
    bison flex libssl-dev libyaml-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

RUN useradd -ms /bin/bash ectrons
USER ectrons
WORKDIR /home/ectrons

RUN mkdir -p /home/ectrons/zephyrproject && \
    python3 -m venv /home/ectrons/zephyrproject/.venv

SHELL ["/bin/bash", "-c"]
RUN source /home/ectrons/zephyrproject/.venv/bin/activate && \
    pip install --upgrade pip && \
    pip install west && \
    west init /home/ectrons/zephyrproject && \
    cd /home/ectrons/zephyrproject && \
    west update && \
    west zephyr-export && \
    west packages pip --install && \
    cd zephyr && \
    west sdk install

RUN echo 'source ~/zephyrproject/.venv/bin/activate' >> ~/.bashrc

WORKDIR /home/ectrons/zephyrproject

CMD ["/bin/bash"]
