# model_training
docker build -t training .

enroot import --output training.sqsh  dockerd://training:latest

enroot bundle --output training_v2.run training.sqsh 

 ./training.run -m ReducedDataset/:Mask2Former/datasets -m output:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 2 SOLVER.IMS_PER_BATCH 2

sbatch sbatch.sh


Container unterstützt alle Resnet Backbone Modelle +  Swin-L, da hier die Datei mit den Gewichten gedownloadet wurde und im Container ist. 
