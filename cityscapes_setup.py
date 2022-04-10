import os
from cityscapesscripts.preparation import createTrainIdInstanceImgs
from cityscapesscripts.preparation import createPanopticImgs
#createTrainIdInstanceImgs.main()
createPanopticImgs.convert2panoptic(cityscapesPath='/home/appuser/Mask2Former/datasets/cityscapes/gtFine')
