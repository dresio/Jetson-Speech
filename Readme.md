# Jeston-Speech

## Dependencies
Requires Docker and Docker Compose  
To install docker-compose:  
```
sudo apt-get update -y
sudo apt-get install python3-pip

sudo apt-get install -y libffi-dev libssl-dev python-openssl

sudo pip3 install --upgrade pip
sudo pip3 install docker-compose
```

## Setup
To setup the project, run the following commands:  
```
docker build -t jetson-speech:0.1 .

# Before running the docker-compose, initialize the tensorflow submodule
cd DeepSpeech
git submodule sync tensorflow
git submodule update --init tensorflow

# Run the docker-compose and enter the image
docker-compose up --detach
docker exec -it jetson-speech_jetson-speech bash

# Build and install compatible bazel
cd bazel/src
bazel build //src:bazel-dev

# Configure the build
cd DeepSpeech/tensorflow
./configure

# Compile DeepSpeech
ln -s ../native_client #already is linked but just in case
bazel build --workspace_status_command="bash native_client/bazel_workspace_status_cmd.sh" --config=monolithic -c opt --copt=-O3 --copt="-D_GLIBCXX_USE_CXX11_ABI=0" --copt=-fvisibility=hidden //native_client:libdeepspeech.so

```