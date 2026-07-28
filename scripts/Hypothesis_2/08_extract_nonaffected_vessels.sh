#!/bin/bash

# ==========================================================
# 08_extract_nonaffected_vessels.sh
#
# Purpose:
# Extract vessel voxels outside Neurosynth clusters.
#
# Input:
#   masks/non_affected_brain_mask.nii.gz
#   vessels_binary.nii.gz
#
# Output:
#   vessels/non_affected_vessels.nii.gz
#
# ==========================================================


echo "Extracting non-affected vessels"


mkdir -p vessels


3dcalc \
-a masks/non_affected_brain_mask.nii.gz \
-b vessels_binary.nii.gz \
-expr 'a*b' \
-prefix vessels/non_affected_vessels.nii.gz \
-overwrite


echo "Done"