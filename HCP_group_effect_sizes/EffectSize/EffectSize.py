import pandas as pd
import os
import sys
import nibabel as nib
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats
import csv
import shutil

Paradigm = sys.argv[1]
Contrast = sys.argv[2]
ConDir = sys.argv[3]
OutDir = sys.argv[4]
FslDir = os.environ.get('FSLDIR')

# read cope + varcope
CopeFile = os.path.join(ConDir,'group.gfeat','cope1.feat','stats','cope1.nii.gz')
Cope = nib.load(CopeFile).get_data()
VarCopeFile = os.path.join(ConDir,'group.gfeat','cope1.feat','stats','varcope1.nii.gz')
VarCope = nib.load(VarCopeFile).get_data()
MaskFile = os.path.join(ConDir,'group.gfeat','cope1.feat','mask.nii.gz')
Mask = nib.load(MaskFile).get_data()
TStatFile = os.path.join(ConDir,'group.gfeat','cope1.feat','stats','tstat1.nii.gz')
TStat = nib.load(TStatFile).get_data()

# mask

indd = np.where(Mask>0)
mask_ind = pd.DataFrame()
mask_ind['x'] = indd[0]
mask_ind['y'] = indd[1]
mask_ind['z'] = indd[2]
#print(mask_ind)

# Compute Cohens D
D = TStat/np.sqrt(186)

# export values
COHENSD = np.nanmedian(D[mask_ind.x,mask_ind.y,mask_ind.z])
COHENS90 = np.nanpercentile(D[mask_ind.x,mask_ind.y,mask_ind.z],90)
COHENS95 = np.nanpercentile(D[mask_ind.x,mask_ind.y,mask_ind.z],95)
COHENS99 = np.nanpercentile(D[mask_ind.x,mask_ind.y,mask_ind.z],99)
COHENS999 = np.nanpercentile(D[mask_ind.x,mask_ind.y,mask_ind.z],99.9)


with open(os.path.join(OutDir,"es.csv"),'a') as output_file:
    dict_writer = csv.writer(output_file)
    dict_writer.writerow([Paradigm,Contrast,COHENSD,COHENS90,COHENS95,COHENS99,COHENS999])
