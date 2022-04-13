# model_training

build docker file with 
'''docker build -t training . '''

run docker
''' 
docker run -it --shm-size 190G --gpus all training /bin/bash 
'''



multiple gpu training:
r50
'''
python train_net.py --num-gpus 4 \
  --config-file configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml  SOLVER.IMS_PER_BATCH 12
  
python train_net_single_gpu.py   --config-file configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml   --num-machines 1 --num-gpus 2
  
'''
swin large
'''


wget https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_large_patch4_window12_384_22k.pth

sudo apt-get install nano
export TERM=xterm
edit config to pth instead of pkl


python train_net.py --num-gpus 4 \
  --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml SOLVER.IMS_PER_BATCH 4
  
  
python train_net.py --num-gpus 4 \
  --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml SOLVER.IMS_PER_BATCH 8 resume 0
'''





single gpu training:
'''
python train_net_single_gpu.py   --config-file configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml   --num-machines 1 --num-gpus 1 --dist-url 'localhost' SOLVER.IMS_PER_BATCH 2 SOLVER.BASE_LR 0.001
'''
