FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

#Fix Bugs due to https://developer.nvidia.com/blog/updating-the-cuda-linux-gpg-repository-key/
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install curl git python3 wget python3-pip libgl1-mesa-glx libglib2.0-0
RUN pip3 install -U torch==1.10 torchvision==0.11.1 -f https://download.pytorch.org/whl/cu111/torch_stable.html
RUN pip3 install detectron2 -f https://dl.fbaipublicfiles.com/detectron2/wheels/cu111/torch1.10/index.html
RUN pip3 install git+https://github.com/cocodataset/panopticapi.git
RUN pip3 install ninja  
RUN pip3 install git+https://github.com/mcordts/cityscapesScripts.git
ENV TORCH_CUDA_ARCH_LIST="Kepler;Kepler+Tesla;Maxwell;Maxwell+Tegra;Pascal;Volta;Turing"        
ENV FORCE_CUDA=1  
RUN git clone https://github.com/facebookresearch/Mask2Former
RUN pip3 install -U opencv-python
RUN pip3 install -r Mask2Former/requirements.txt   
RUN python3 Mask2Former/mask2former/modeling/pixel_decoder/ops/setup.py build install
RUN ln -s /usr/bin/pip3 /usr/local/bin/pip 
WORKDIR /Mask2Former
RUN wget https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_large_patch4_window12_384_22k.pth && \
    python3 tools/convert-pretrained-swin-model-to-d2.py swin_large_patch4_window12_384_22k.pth swin_large_patch4_window12_384_22k.pkl && \
    rm swin_large_patch4_window12_384_22k.pth


