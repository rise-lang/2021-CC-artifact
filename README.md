# 2021-CC-artifact
This repository presents the artifact to supplement the paper "Integrating a functional pattern-based IR into MLIR"
It includes the MLIR infrastructure with the \Rise dialect and corresponding passes. A dockerfile and scripts are provided to enable easy installation, execution, and plotting of results.


## Software dependencies
All requirements are specified in the dockerfile and satisfied automatically when docker is used. The main requirements are:
- Docker 
- Downloading MLIR requires git. 
- Building MLIR requires Ninja [https://ninja-build.org/](https://ninja-build.org/) and a working C++ toolchain including clang and lld.

```
# start the docker service
  systemctl start docker
# build the docker container
  make
# enter the docker container
  make run
```

If docker requires sudo privileges be sure to add your user to the docker group and log out and back in:
```
sudo groupadd docker
sudo usermod -aG docker $USER
```

## Experiment workflow
Manually run the script **run_all.sh** from the home directory of the docker container.
```
  cd home
  ./run_all.sh
```
Check the results in the **results** folder

## Evaluation and expected result
The script **run_all.sh** compiles and executes all experiments and populates the **results** folder with the results. It will contain a breakdown of compilation time and runtimes for the matrix multiplication experiment and runtimes for the convolution experiment. All experiments are conducted 100 times.

## Experiment customization
The artifact contains the MLIR infrastructure including the RISE dialect and corresponding passes. This setup can be used to compile and execute arbitrary RISE programs using our generic lowering approach. In addition to that the RISE dialect as provided can be integrated with other high level representations following our approach of integration with XLA HLO. 