# https://github.com/rapidsai/gpuci-build-environment
ARG CUDA_VER=11.0
ARG LINUX_VER=ubuntu20.04
ARG PYTHON_VER=3.7
ARG RAPIDS_VER=21.08
ARG FROM_IMAGE=rapidsai/rapidsai
ARG IMAGE_TYPE=runtime
FROM ${FROM_IMAGE}:cuda${CUDA_VER}-${IMAGE_TYPE}-${LINUX_VER}-py${PYTHON_VER}

RUN source activate rapids && pip install papermill
