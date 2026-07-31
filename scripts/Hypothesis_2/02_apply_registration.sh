#!/bin/bash

# ==========================================================
# 02_apply_registration.sh
#
# Purpose:
# Transform Neurosynth cluster map from MNI space into
# subject-specific native 7T vessel reference space.
#
# Uses ANTs transforms provided by preprocessing pipeline.
#
# Author: Anuschka Bergmann
# ==========================================================


echo "========================================"
echo "Applying ANTs registration"
echo "========================================"


# -----------------------------
# Input files
# -----------------------------

INPUT_CLUSTERS="clusters_thr.nii"

REFERENCE_IMAGE="registration/sub-02_vesselref.nii.gz"


# -----------------------------
# Transform files
# -----------------------------

VESSEL_AFFINE="registration/sub-02_ses-02_UNIT12vesselref0GenericAffine.mat"

STD_AFFINE="registration/sub-02_ses-02_UNIT12std0GenericAffine.mat"

STD_WARP="registration/sub-02_ses-02_UNIT12std1InverseWarp.nii.gz"


# -----------------------------
# Output
# -----------------------------

OUTPUT="masks/clusters_native.nii.gz"


echo "Input:"
echo ${INPUT_CLUSTERS}

echo ""
echo "Reference:"
echo ${REFERENCE_IMAGE}

echo ""
echo "Output:"
echo ${OUTPUT}


# -----------------------------
# Apply transformations
# -----------------------------

antsApplyTransforms \
-d 3 \
-i ${INPUT_CLUSTERS} \
-r ${REFERENCE_IMAGE} \
-o ${OUTPUT} \
-n MultiLabel \
-t ${VESSEL_AFFINE} \
-t [${STD_AFFINE},1] \
-t ${STD_WARP}


echo ""
echo "========================================"
echo "Registration complete"
echo "========================================"