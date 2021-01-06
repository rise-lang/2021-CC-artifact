FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# install requirements
RUN \
  apt-get update && \
  apt-get install -y \
  git \
  cmake \
  ninja-build \
  llvm \
  clang \
  libxml2 \
  vim \
  r-base

# copy libs
COPY /lib /home/lib

# # init submodules
# RUN \
#   cd /home/lib/mlir && \
#   git submodule update --init

# build mlir
RUN \
  cd home/lib/mlir && \
  cmake -G Ninja llvm -DLLVM_ENABLE_PROJECTS=mlir -DLLVM_BUILD_EXAMPLES=ON -DLLVM_TARGETS_TO_BUILD="host" -DCMAKE_BUILD_TYPE=Debug && \
  ninja mlir-opt mlir-cpu-runner mlir_runner_utils mlir-translate

# # build iree
# RUN \
#   cd home/lib/iree/iree && \
#   cmake -G Ninja .. -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ && \
#   ninja iree_tools_iree-run-mlir

# build support lib
RUN \
  cd /home/lib/support_lib && \
  make

# copy computations and scripts
COPY expr /home/expr
COPY run_all.sh /home
RUN \
  chmod u+x /home/run_all.sh

RUN \
  mkdir /home/results && \
  mkdir /home/results/mm && \
  mkdir /home/results/convolution
COPY scripts/process_results.r /home/results

RUN \
  GREEN='\033[1;32m' && NC='\033[0m' && \
  RED='\033[0;31m' && \
  echo "\n${GREEN}Please install cpupower on your host system (e.g. ${RED}apt-get install -y linux-tools-$(uname -r)${GREEN} ) and run ${RED}cpupower frequency-set --governor performance${GREEN} to ensure consistent results.${NC}\n"