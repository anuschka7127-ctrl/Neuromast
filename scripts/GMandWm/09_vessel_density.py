#!/usr/bin/env python3

import nibabel as nib
import numpy as np

gm_skeleton_img = nib.load("gm_vessel_skeleton.nii")
gm_skeleton = gm_skeleton_img.get_fdata()

gm_vessel_voxels = np.sum(gm_skeleton > 0)

gm_mask_img = nib.load("gm_mask.nii")
gm_mask = gm_mask_img.get_fdata()

gm_tissue_voxels = np.sum(gm_mask > 0)

gm_density = gm_vessel_voxels / gm_tissue_voxels

print("GM vessel voxels:", gm_vessel_voxels)
print("GM tissue voxels:", gm_tissue_voxels)
print("GM vessel density:", gm_density)

wm_skeleton_img = nib.load("wm_vessel_skeleton.nii")
wm_skeleton = wm_skeleton_img.get_fdata()

wm_vessel_voxels = np.sum(wm_skeleton > 0)

wm_mask_img = nib.load("wm_mask.nii")
wm_mask = wm_mask_img.get_fdata()

wm_tissue_voxels = np.sum(wm_mask > 0)

wm_density = wm_vessel_voxels / wm_tissue_voxels

print("WM vessel voxels:", wm_vessel_voxels)
print("WM tissue voxels:", wm_tissue_voxels)
print("WM vessel density:", wm_density)
