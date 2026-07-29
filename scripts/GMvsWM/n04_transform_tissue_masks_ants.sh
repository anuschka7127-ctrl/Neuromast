#!/bin/bash

# ============================================================
# Transform GM and WM masks into 7T vessel space using ANTs
#
# Input:
#   GM and WM masks created from UNIT1_seg
#
# Output:
#   GM and WM masks aligned to vessel image space
#
# ============================================================


GM_MASK="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_GM_from_seg.nii.gz"

WM_MASK="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks/sub-02_WM_from_seg.nii.gz"


VESSEL_REFERENCE="/Neurodata/M3PI/derivatives/vessels/sub-02/ses-7T/reg/sub-02_vesselref.nii.gz"


TRANSFORM="/Neurodata/M3PI/derivatives/vessels/sub-02/ses-7T/reg/sub-02_ses-02_UNIT12vesselref0GenericAffine.mat"


OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"


echo "Transforming GM mask..."

antsApplyTransforms \
-d 3 \
-i ${GM_MASK} \
-r ${VESSEL_REFERENCE} \
-o ${OUTDIR}/sub-02_GM_vesselspace.nii.gz \
-n NearestNeighbor \
-t ${TRANSFORM}


echo "Transforming WM mask..."

antsApplyTransforms \
-d 3 \
-i ${WM_MASK} \
-r ${VESSEL_REFERENCE} \
-o ${OUTDIR}/sub-02_WM_vesselspace.nii.gz \
-n NearestNeighbor \
-t ${TRANSFORM}


echo ""
echo "======================================"
echo "GM and WM masks transformed into vessel space"
echo "======================================"