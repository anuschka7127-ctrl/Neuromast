#!/bin/bash

# ==========================================================
# Step 6: Calculate Vessel Density
#
# Purpose:
# Calculate the proportion of gray matter and white matter
# occupied by vessels.
#
# Formula:
# Vessel density = vessel voxels / tissue voxels
#
# Input:
#   gm_vessels.nii
#   wm_vessels.nii
#   gm_mask.nii
#   wm_mask.nii
#
# Output:
#   Vessel voxel counts
#   Tissue voxel counts
# ==========================================================


# Count gray matter vessel voxels

gm_vessel_voxels=$(3dBrickStat \
-slow \
-count \
-non-zero \
gm_vessels.nii)

Output: 5030665    

# Count white matter vessel voxels

wm_vessel_voxels=$(3dBrickStat \
-slow \
-count \
-non-zero \
wm_vessels.nii)

Output: 3161271


# Count total gray matter voxels

gm_voxels=$(3dBrickStat \
-slow \
-count \
-non-zero \
gm_mask.nii)


# Count total white matter voxels

wm_voxels=$(3dBrickStat \
-slow \
-count \
-non-zero \
wm_mask.nii)


echo "GM vessel voxels: $gm_vessel_voxels"
echo "WM vessel voxels: $wm_vessel_voxels"

echo "GM total voxels: $gm_voxels"
echo "WM total voxels: $wm_voxels"