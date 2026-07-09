#!/bin/bash

# ==========================================================
# Step 01: Inspect and downsample MRI and vessel segmentation
#
# Purpose:
# - Inspect original MRI dimensions and voxel size
# - Verify vessel segmentation matches anatomical image
# - Downsample images from 0.175 mm to 0.5 mm isotropic voxels
#
# Inputs:
#   brain.nii
#   vessels.nii
#
# Outputs:
#   brain_0.5mm.nii
#   vessels_binary.nii
#   vessels_0.5mm.nii
#
# Software:
#   AFNI
# ==========================================================


# ----------------------------------------------------------
# 1. Inspect original MRI
# ----------------------------------------------------------

3dinfo brain.nii


# ----------------------------------------------------------
# 2. Inspect vessel segmentation
#    Confirm that dimensions, orientation, and voxel size
#    match the anatomical image.
# ----------------------------------------------------------

3dinfo vessels.nii


# ----------------------------------------------------------
# 3. Downsample anatomical MRI
#
# Original resolution:
#   0.175 mm isotropic
#
# New resolution:
#   0.5 mm isotropic
#
# Linear interpolation (Li) is appropriate for continuous
# anatomical intensity data.
# ----------------------------------------------------------

3dresample \
-prefix brain_0.5mm.nii \
-input brain.nii \
-dxyz 0.5 0.5 0.5 \
-rmode Li


# ----------------------------------------------------------
# 4. Convert vessel segmentation into binary mask
#
# step(a):
#   values > 0 become 1
#   values = 0 remain 0
#
# This ensures vessels are treated as a binary object.
# ----------------------------------------------------------

3dcalc \
-a vessels.nii \
-expr 'step(a)' \
-prefix vessels_binary.nii


# Check binary values

3dBrickStat \
-slow \
-min \
-max \
vessels_binary.nii


# ----------------------------------------------------------
# 5. Downsample vessel segmentation
#
# Nearest neighbour interpolation (NN) is used because
# vessel masks are categorical/binary data.
#
# NN prevents creation of artificial intermediate values.
# ----------------------------------------------------------

3dresample \
-prefix vessels_0.5mm.nii \
-input vessels_binary.nii \
-dxyz 0.5 0.5 0.5 \
-rmode NN


# Final quality check

3dinfo brain_0.5mm.nii
3dinfo vessels_0.5mm.nii