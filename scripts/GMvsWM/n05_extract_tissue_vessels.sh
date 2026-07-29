#!/bin/bash

# ============================================================
# Extract vessels located within grey and white matter
#
# Purpose:
# Combines the binary vessel mask with tissue masks that have
# been transformed into 7T vessel space using ANTs.
#
# Output:
#   GM_vessels.nii.gz
#   WM_vessels.nii.gz
#
# Author:
# Anuschka Bergmann
#
# ============================================================


# -----------------------------
# Input files
# -----------------------------

VESSELS="/Neurodata/M3PI/derivatives/Anuschka_derivatives/vessels/vessels_binary.nii.gz"


GM="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_GM_vesselspace.nii.gz"

WM="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_WM_vesselspace.nii.gz"


# -----------------------------
# Output directory
# -----------------------------

OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"


echo "Extracting GM vessels..."


fslmaths \
${VESSELS} \
-mul ${GM} \
${OUTDIR}/sub-02_GM_vessels.nii.gz



echo "Extracting WM vessels..."


fslmaths \
${VESSELS} \
-mul ${WM} \
${OUTDIR}/sub-02_WM_vessels.nii.gz



echo ""
echo "======================================"
echo "GM and WM vessel extraction complete"
echo "======================================"