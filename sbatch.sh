#!/bin/bash
#SBATCH -p gpu_8
#SBATCH --gres=gpu:8
#SBATCH --nodes=1
#SBATCH --job-name=gpu_test
#SBATCH --time=2:30:00
# Further options: https://wiki.bwhpc.de/e/BwUniCluster_2.0_Slurm_common_Features


#Make output directory
FOO=run_$(date +%Y-%M-%d_%H-%M-%S)
mkdir $FOO

#Datensatz nach $TMP Kopieren
cp -r ReducedDataset $TMP

./training.run -m $TMP/ReducedDataset/:Mask2Former/datasets -m $FOO:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 8


