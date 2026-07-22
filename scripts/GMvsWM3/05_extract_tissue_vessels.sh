#!/bin/bash

# ============================================================
# Extract tissue-specific vessel masks
#
# Purpose:
# Combine the 7T vessel segmentation with tissue masks to
# identify vessels located within grey matter and white matter.
#
# Input:
#   - Binary vessel segmentation from 7T T2* image
#   - Binary GM tissue mask
#   - Binary WM tissue mask
#
# Output:
#   - GM vessel mask
#   - WM vessel mask
#
# Author: Anuschka Bergmann
# ============================================================


# Input vessel segmentation

VESSEL_MASK="/Neurodata/M3PI/derivatives/Anuschka/00.sub-02_ses-7T_part-mag_T2starw_imgavg_preprocessed_vessels.nii.gz"


# Tissue masks

GM_MASK="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_GM_binary.nii.gz"

WM_MASK="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_WM_binary.nii.gz"


# Output directory

OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

mkdir -p ${OUTDIR}


echo "Extracting grey matter vessels..."

fslmaths \
${VESSEL_MASK} \
-mul ${GM_MASK} \
${OUTDIR}/sub-02_GM_vessels.nii.gz


echo "Extracting white matter vessels..."

fslmaths \
${VESSEL_MASK} \
-mul ${WM_MASK} \
${OUTDIR}/sub-02_WM_vessels.nii.gz


echo "Tissue-specific vessel masks created."