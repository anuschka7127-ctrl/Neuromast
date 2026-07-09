#!/bin/bash

# ==========================================================
# Step 6: Vessel Quantification
#
# Purpose:
# Calculate vessel volume and density within gray matter
# and white matter.
#
# Input:
#   gm_vessels.nii
#   wm_vessels.nii
#   gm_mask.nii
#   wm_mask.nii
#
# Output:
#   Vessel voxel counts
#   Tissue-specific vessel density
#
# ==========================================================

The first thing we do is count vessel voxels.

Gray matter vessel count:

input: 

3dBrickStat \
-slow \
-count \
-non-zero \
gm_vessels.nii

Output: 467430 

White matter vessel count:
3dBrickStat \
-slow \
-count \
-non-zero \
wm_vessels.nii

Output: 311043

