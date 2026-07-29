#!/bin/bash

# ============================================================
# Create GM and WM masks from UNIT1 segmentation
#
# Input:
#   UNIT1_seg.nii.gz
#
# Labels:
#   2 = GM
#   3 = WM
#
# Output:
#   Binary GM and WM masks
#
# ============================================================


SEG="/Neurodata/M3PI/derivatives/vessels/sub-02/ses-02/anat/sub-02_ses-02_UNIT1_seg.nii.gz"

OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

mkdir -p ${OUTDIR}


echo "Creating GM mask..."

fslmaths \
${SEG} \
-thr 2 \
-uthr 2 \
-bin \
${OUTDIR}/sub-02_GM_from_seg.nii.gz


echo "Creating WM mask..."

fslmaths \
${SEG} \
-thr 3 \
-uthr 3 \
-bin \
${OUTDIR}/sub-02_WM_from_seg.nii.gz


echo ""
echo "======================================"
echo "GM and WM masks created from segmentation"
echo "======================================"