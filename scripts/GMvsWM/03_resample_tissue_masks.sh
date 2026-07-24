#!/bin/bash

# ============================================================
# Resample existing GM and WM tissue masks into 7T vessel space
#
# Purpose:
# The vessel segmentation was generated from a high-resolution
# 7T T2* image. Existing UNIT1 GM and WM masks are available
# but have a different voxel grid. These masks are resampled
# to match the vessel image space.
#
# Interpolation:
# Nearest neighbour is used because tissue masks are categorical
# labels and should not contain interpolated values.
#
# Author: Anuschka Bergmann
# ============================================================


# Input files

GM_MASK="/Neurodata/M3PI/derivatives/vessels/sub-02/ses-02/anat/sub-02_ses-02_UNIT1_GM.nii.gz"

WM_MASK="/Neurodata/M3PI/derivatives/vessels/sub-02/ses-02/anat/sub-02_ses-02_UNIT1_WM.nii.gz"

VESSEL_REFERENCE="/Neurodata/M3PI/derivatives/Anuschka/00.sub-02_ses-7T_part-mag_T2starw_imgavg_preprocessed_vessels.nii.gz"


# Output directory

OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

mkdir -p ${OUTDIR}


# Resample GM mask

flirt \
-in ${GM_MASK} \
-ref ${VESSEL_REFERENCE} \
-out ${OUTDIR}/sub-02_GM_vesselspace.nii.gz \
-applyxfm \
-usesqform \
-interp nearestneighbour


# Resample WM mask

flirt \
-in ${WM_MASK} \
-ref ${VESSEL_REFERENCE} \
-out ${OUTDIR}/sub-02_WM_vesselspace.nii.gz \
-applyxfm \
-usesqform \
-interp nearestneighbour


echo "Tissue masks successfully resampled into vessel space"