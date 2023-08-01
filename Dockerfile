# Pull Nvidia Jetson tensor flow image
FROM nvcr.io/nvidia/l4t-tensorflow:r35.3.1-tf2.11-py3

# Install dependencies
RUN apt-get update && apt-get install -y \
    apt-utils \
    software-properties-common \
    apt-transport-https \
    curl \
    gnupg \
    sox \
    build-essential \
    openjdk-11-jdk \
    zip \
    unzip

# Install Base Bazel, Build and Install Compatible Bazel, and Remove Base Bazel
# RUN wget https://github.com/bazelbuild/bazel/releases/download/3.4.0/bazel-3.4.0-linux-arm64 && \
#     chmod +x bazel-3.4.0-linux-arm64 && \
#     mv bazel-3.4.0-linux-arm64 /usr/local/bin/bazel && \
RUN wget https://github.com/bazelbuild/bazel/archive/refs/tags/3.1.0.tar.gz && \
    tar -xvf 3.1.0.tar.gz && \
    cd bazel-3.1.0 && \
    env EXTRA_BAZEL_ARGS="--tool_java_runtime_version=local_jdk" bash ./compile.sh && \
    mv output/bazel /usr/local/bin/bazel && \
    cd .. && \
    rm -r 3.1.0.tar.gz bazel-3.1.0


# Get models
RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-models.scorer && \
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/deepspeech-0.9.3-models.tflite && \ 
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.3/audio-0.9.3.tar.gz