import os
from cityscapesscripts.preparation import createPanopticImgs
createPanopticImgs.convert2panoptic(cityscapesPath='/home/appuser/Mask2Former/datasets/cityscapes/gtFine')

os.environ["CITYSCAPES_DATASET"] = "/home/appuser/Mask2Former/datasets/cityscapes"
from cityscapesscripts.preparation import createTrainIdLabelImgs
createTrainIdLabelImgs.main()
