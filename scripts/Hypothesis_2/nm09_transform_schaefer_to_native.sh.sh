#!/bin/bash

# ==========================================================
# 09_transform_schaefer_to_native.sh
#
# Purpose:
# Transform Schaefer100 atlas from MNI152 space
# into native 7T vessel reference space.
#
# Method:
# ANTs inverse nonlinear + affine transformation
#
# Interpolation:
# NearestNeighbour because atlas contains labels
#
# ==========================================================


echo "======================================"
echo "Transforming Schaefer atlas"
echo "======================================"


mkdir -p masks


antsApplyTransforms \
-d 3 \
-i atlases/Schaefer100_7Networks_MNI152_2mm.nii.gz \
-r registration/sub-02_vesselref.nii.gz \
-o masks/sub-02_Schaefer100_native.nii.gz \
-n NearestNeighbor \
-t registration/sub-02_ses-02_UNIT12std1InverseWarp.nii.gz \
-t [registration/sub-02_ses-02_UNIT12std0GenericAffine.mat,1]


echo ""
echo "======================================"
echo "Schaefer transformation complete"
echo "Output:"
echo "masks/sub-02_Schaefer100_native.nii.gz"
echo "======================================"