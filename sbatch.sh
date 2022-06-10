#!/bin/bash
#SBATCH -p gpu_4
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --job-name=swin_training
#SBATCH --time=24:00:00
# Further options: https://wiki.bwhpc.de/e/BwUniCluster_2.0_Slurm_common_Features


#Make output directory
FOO=swinl_run_$(date +%Y-%m-%d_%H-%M-%S)
mkdir $FOO

#Datensatz nach $TMP Kopieren
cp -r cityscapes $TMP

#single GPU
#./training.run -w -m $TMP/cityscapes:Mask2Former/datasets -m $FOO:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 8

./training.run -w -m $TMP:Mask2Former/datasets -m $FOO:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 1 SOLVER.IMS_PER_BATCH 2

