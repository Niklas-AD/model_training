# model_training

build docker file with build -t training .

docker run -it --shm-size 8G --gpus all training /bin/bash

python train_net.py   --config-file configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml   --num-machines 1 --num-gpus 1 --dist-url 'localhost' SOLVER.IMS_PER_BATCH 1 SOLVER.BASE_LR 0.001
