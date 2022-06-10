# model_training
docker build -t training .

enroot import --output training.sqsh  dockerd://training:latest

enroot bundle --output training.run training.sqsh 

 ./training.run -m ReducedDataset/:Mask2Former/datasets -m output:Mask2Former/output python3 train_net.py --config-file configs/cityscapes/panoptic-segmentation/swin/maskformer2_swin_large_IN21k_384_bs16_90k.yaml --num-machines 1 --num-gpus 2 SOLVER.IMS_PER_BATCH 2

sbatch sbatch.sh


Container unterstützt alle Resnet Backbone Modelle +  Swin-L, da hier die Datei mit den Gewichten gedownloadet wurde und im Container ist. 

Hinweis: Eigentlich soll vor dem Training der Swin Modelle die Datei mit den Gewichten von pth in eine pkl Datei mithilfe von https://github.com/Niklas-AD/Mask2Former/tree/main/tools umgewandelt werden. Da es dann aber mit Python 3.6 Probleme gibt, ist einfach in der Konfigurationsdatei die Datei geändert worden. Das Modell trainiert dann ohne Probleme, allerdings besteht das Risiko, dass einige Gewichte falsch eingelesen wurden.
