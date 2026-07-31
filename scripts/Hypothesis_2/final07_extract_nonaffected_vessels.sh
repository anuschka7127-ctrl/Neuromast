#!/bin/bash

# ==========================================================
# 07_extract_nonaffected_vessels.sh
#
# Purpose:
# Create a non-affected brain mask by removing
# Neurosynth-identified affected regions, then extract
# vessel voxels within the remaining brain tissue.
#
# Method:
#
# Non-affected mask =
# whole brain mask - affected clusters
#
# Non-affected vessels =
# non-affected mask × vessel mask
#
#
# Inputs:
#   masks/brain_mask.nii.gz
#   masks/all_affected_clusters.nii.gz
#   vessels_binary.nii.gz
#
# Outputs:
#   masks/non_affected_brain_mask.nii.gz
#   vessels/non_affected_vessels.nii.gz
#
# Author:
# Anuschka Bergmann
# ==========================================================


set -e


echo "=========================================="
echo "Creating non-affected vessel mask"
echo "=========================================="


# ----------------------------------------------------------
# Directories
# ----------------------------------------------------------

mkdir -p vessels



# ----------------------------------------------------------
# Create non-affected brain mask
# ----------------------------------------------------------

echo ""
echo "Creating non-affected brain mask..."


3dcalc \
-a masks/brain_mask.nii.gz \
-b masks/all_affected_clusters.nii.gz \
-expr 'a*(1-b)' \
-prefix masks/non_affected_brain_mask.nii.gz \
-overwrite



# ----------------------------------------------------------
# Extract vessels within non-affected tissue
# ----------------------------------------------------------

echo ""
echo "Extracting non-affected vessels..."


3dcalc \
-a masks/non_affected_brain_mask.nii.gz \
-b vessels_binary.nii.gz \
-expr 'a*b' \
-prefix vessels/non_affected_vessels.nii.gz \
-overwrite



echo ""
echo "=========================================="
echo "Non-affected vessel extraction complete"
echo "=========================================="

echo "Created:"
echo "masks/non_affected_brain_mask.nii.gz"
echo "vessels/non_affected_vessels.nii.gz"