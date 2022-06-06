FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04
# use an older system (18.04) to avoid opencv incompatibility (issue#3524)

ENV DEBIAN_FRONTEND noninteractive

#Fix Bugs due to https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub


RUN apt-get update && apt-get install -y \
    python3-opencv \
    ca-certificates \
    python3-dev \
    git \
    wget \
    sudo \
    ninja-build \
    unzip

RUN wget https://bootstrap.pypa.io/pip/3.6/get-pip.py && \
	python3 get-pip.py  && \
	rm get-pip.py

# install dependencies
# See https://pytorch.org/ for other options if you use a different version of CUDA
RUN pip install tensorboard cmake   # cmake from apt-get is too old
RUN pip install torch==1.10 torchvision==0.11.1 -f https://download.pytorch.org/whl/cu111/torch_stable.html
RUN pip install 'git+https://github.com/facebookresearch/fvcore'

#install Data handeling tools
RUN pip install git+https://github.com/Niklas-AD/panopticapi.git
RUN pip install git+https://github.com/Niklas-AD/cityscapesScripts.git

# install detectron2
RUN git clone https://github.com/facebookresearch/detectron2 detectron2_repo
# set FORCE_CUDA because during `docker build` cuda is not accessible
ENV FORCE_CUDA="1"
# This will by default build detectron2 for all common cuda architectures and take a lot more time,
# because inside `docker build`, there is no way to tell which architecture will be used.
ARG TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"
# install Mask2Former
RUN pip install -e detectron2_repo
RUN git clone https://github.com/Niklas-AD/Mask2Former 
RUN pip install -U opencv-python
RUN pip install -r  Mask2Former/requirements.txt
RUN sudo -E python3 Mask2Former/mask2former/modeling/pixel_decoder/ops/setup.py build install

#Download Pretrained SWIN-L
RUN wget https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_large_patch4_window12_384_22k.pth -P /Mask2Former

#pytorch bugfix https://stackoverflow.com/questions/70520120/attributeerror-module-setuptools-distutils-has-no-attribute-version
RUN pip install setuptools==59.5.0

# Set a fixed model cache directory.
ENV FVCORE_CACHE="/tmp"

WORKDIR  /Mask2Former
