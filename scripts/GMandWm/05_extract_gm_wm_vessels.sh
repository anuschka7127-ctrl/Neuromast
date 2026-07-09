#!/bin/bash

# ==========================================================
# Step 5: Extract vessels within gray and white matter
#
# Purpose:
# Identify which segmented vessels are located inside
# gray matter and white matter.
#
# Input:
#   vessels_0.5mm.nii  -> binary vessel segmentation
#   gm_mask.nii        -> gray matter mask
#   wm_mask.nii        -> white matter mask
#
# Output:
#   gm_vessels.nii
#   wm_vessels.nii
#
# Method:
# Multiply vessel mask by tissue mask.
# Only overlapping voxels are retained.
# ==========================================================


# Extract vessels located in gray matter

3dcalc \
-a vessels_0.5mm.nii \
-b gm_mask.nii \
-expr 'a*b' \
-prefix gm_vessels.nii


# Extract vessels located in white matter

3dcalc \
-a vessels_0.5mm.nii \
-b wm_mask.nii \
-expr 'a*b' \
-prefix wm_vessels.nii