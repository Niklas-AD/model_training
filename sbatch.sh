#!/bin/bash
#SBATCH -p gpu_8
#SBATCH --gres=gpu:8
#SBATCH --nodes=1
#SBATCH --job-name=swin_training
#SBATCH --time=31:00:00
# Further options: https://wiki.bwhpc.de/e/BwUniCluster_2.0_Slurm_common_Features


#Make output directory
FOO=swinl_run_$(date +%Y-%m-%d_%H-%M-%S)
mkdir $FOO

#Datensatz nach $TMP Kopieren
cp -r cityscapes $TMP

#Training
#./training_v2.run -w -m $TMP:Mask2Former/datasets -m $FOO:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 8

#Testing
./training_v2.run -w -m $TMP:Mask2Former/datasets -m $FOO:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 2 SOLVER.IMS_PER_BATCH 4

