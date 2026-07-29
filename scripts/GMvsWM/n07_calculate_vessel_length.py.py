#!/usr/bin/env python3

"""
============================================================
07_calculate_vessel_length.py

Purpose:
Calculate total vessel length within grey and white matter.

Method:
1. Load GM and WM vessel masks
2. Skeletonise vessels
3. Count skeleton voxels
4. Convert skeleton voxels into physical length (mm)

Voxel size is read directly from the NIfTI header.

Author:
Anuschka Bergmann
============================================================
"""


import os
import nibabel as nib
import numpy as np
from skimage.morphology import skeletonize


# ------------------------------------------------------------
# Paths
# ------------------------------------------------------------

TISSUE_DIR = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

OUTDIR = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/results"

os.makedirs(OUTDIR, exist_ok=True)


GM_FILE = os.path.join(
    TISSUE_DIR,
    "sub-02_GM_vessels.nii.gz"
)

WM_FILE = os.path.join(
    TISSUE_DIR,
    "sub-02_WM_vessels.nii.gz"
)


# ------------------------------------------------------------
# Function
# ------------------------------------------------------------

def calculate_length(image_path):

    img = nib.load(image_path)

    data = img.get_fdata()

    voxel_size = img.header.get_zooms()[:3]

    print("Voxel size:", voxel_size)

    # binary mask
    mask = data > 0

    # skeletonise
    skeleton = skeletonize(mask)

    skeleton_voxels = np.sum(skeleton)

    # approximate length
    voxel_length = np.mean(voxel_size)

    vessel_length_mm = skeleton_voxels * voxel_length

    return skeleton_voxels, vessel_length_mm



# ------------------------------------------------------------
# Calculate GM
# ------------------------------------------------------------

print("Calculating GM vessel length...")

gm_voxels, gm_length = calculate_length(GM_FILE)



# ------------------------------------------------------------
# Calculate WM
# ------------------------------------------------------------

print("Calculating WM vessel length...")

wm_voxels, wm_length = calculate_length(WM_FILE)



# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

output = os.path.join(
    OUTDIR,
    "sub-02_vessel_length.txt"
)


with open(output, "w") as f:

    f.write("Subject: sub-02\n\n")

    f.write(
        f"GM skeleton voxels: {gm_voxels}\n"
    )

    f.write(
        f"GM vessel length (mm): {gm_length}\n\n"
    )

    f.write(
        f"WM skeleton voxels: {wm_voxels}\n"
    )

    f.write(
        f"WM vessel length (mm): {wm_length}\n"
    )


print("")
print("======================================")
print("Vessel length calculation complete")
print("Saved:")
print(output)
print("======================================")