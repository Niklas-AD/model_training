#!/bin/bash
#SBATCH -p gpu_8
#SBATCH --gres=gpu:8
#SBATCH --nodes=1
#SBATCH --job-name=R50_training
#SBATCH --time=32:00:00
# Further options: https://wiki.bwhpc.de/e/BwUniCluster_2.0_Slurm_common_Features


#Make output directory
FOO=R50_run_$(date +%Y-%m-%d_%H-%M-%S)
mkdir $FOO

#Datensatz nach $TMP Kopieren
cp -r cityscapes $TMP

#Training
./training.run -w -m $TMP:Mask2Former/datasets -m $FOO:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/maskformer2_R50_bs16_90k.yaml --num-machines 1 --num-gpus 8
