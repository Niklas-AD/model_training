import os
from cityscapesscripts.download import downloader
from cityscapesscripts.preparation import createTrainIdLabelImgs
from cityscapesscripts.preparation import createPanopticImgs

session = downloader.login()

downloader.download_packages(session=session, package_names = ['gtFine_trainvaltest.zip'],  destination_path = '/home/appuser')
downloader.download_packages(session=session, package_names = ['leftImg8bit_trainvaltest.zip'],  destination_path = '/home/appuser')

