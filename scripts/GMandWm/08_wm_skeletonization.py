#!/usr/bin/env python3

import nibabel as nib
import numpy as np
from skimage.morphology import skeletonize

img = nib.load("wm_vessels.nii")

data = img.get_fdata()

print(data.shape)
print(data.min())
print(data.max())
print(np.sum(data > 0))

vessel_binary = data > 0

skeleton = skeletonize(vessel_binary)

skeleton_img = nib.Nifti1Image(
    skeleton.astype(np.float32),
    img.affine,
    img.header
)

nib.save(skeleton_img, "wm_vessel_skeleton.nii")
