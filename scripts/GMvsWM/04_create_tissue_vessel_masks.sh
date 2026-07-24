#!/bin/bash

# ============================================================
# Extract vessels located within grey and white matter
#
# Purpose:
# The binary vessel segmentation is combined with tissue masks
# to determine the distribution of vessels across tissue types.
#
# Output:
# GM_vessels.nii.gz = vessels within grey matter
# WM_vessels.nii.gz = vessels within white matter
#
# Author: Anuschka Bergmann
# ============================================================


VESSELS="/Neurodata/M3PI/derivatives/Anuschka/00.sub-02_ses-7T_part-mag_T2starw_imgavg_preprocessed_vessels.nii.gz"

GM="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_GM_vesselspace.nii.gz"

WM="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_WM_vesselspace.nii.gz"


OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"


# Convert tissue masks to binary

fslmaths ${GM} \
-bin \
${OUTDIR}/sub-02_GM_binary.nii.gz


fslmaths ${WM} \
-bin \
${OUTDIR}/sub-02_WM_binary.nii.gz


# Extract GM vessels

fslmaths ${VESSELS} \
-mul ${OUTDIR}/sub-02_GM_binary.nii.gz \
${OUTDIR}/sub-02_GM_vessels.nii.gz


# Extract WM vessels

fslmaths ${VESSELS} \
-mul ${OUTDIR}/sub-02_WM_binary.nii.gz \
${OUTDIR}/sub-02_WM_vessels.nii.gz


echo "GM and WM vessel masks created"