#!/bin/bash

# ==========================================================
# 07_create_nonaffected_mask.sh
#
# Purpose:
# Create a non-affected brain mask by removing
# Neurosynth cluster regions from the whole brain mask.
#
# Input:
#   masks/brain_mask.nii.gz
#   masks/all_affected_clusters.nii.gz
#
# Output:
#   masks/non_affected_brain_mask.nii.gz
#
# ==========================================================


echo "Creating non-affected brain mask"


3dcalc \
-a masks/brain_mask.nii.gz \
-b masks/all_affected_clusters.nii.gz \
-expr 'a*(1-b)' \
-prefix masks/non_affected_brain_mask.nii.gz \
-overwrite


echo "Done"