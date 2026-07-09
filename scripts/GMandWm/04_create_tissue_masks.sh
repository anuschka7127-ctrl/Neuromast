#!/bin/bash

# ==========================================================
# Step 4: Create GM and WM Binary Masks
#
# Purpose:
# Convert FAST probability maps into binary tissue masks.
#
# Input:
#   brain_tissue_pve_1.nii.gz  (GM probability)
#   brain_tissue_pve_2.nii.gz  (WM probability)
#
# Output:
#   gm_mask.nii
#   wm_mask.nii
#
# Threshold:
#   Voxels with tissue probability >= 0.5 are included.
# ==========================================================


# Create gray matter mask
# Converts GM probability values (0-1) into a binary mask:
# 1 = gray matter, 0 = not gray matter

3dcalc \
-a brain_tissue_pve_1.nii.gz \
-expr 'step(a-0.5)' \
-prefix gm_mask.nii


# Create white matter mask
# Converts WM probability values (0-1) into a binary mask:
# 1 = white matter, 0 = not white matter

3dcalc \
-a brain_tissue_pve_2.nii.gz \
-expr 'step(a-0.5)' \
-prefix wm_mask.nii

