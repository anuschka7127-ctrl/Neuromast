#!/bin/bash

# ==========================================================
# 01_verify_inputs.sh
#
# Purpose:
# Verify that all required input files exist and that the
# brain and vessel images share the same geometry.
#
# Author: Anuschka Bergmann
# Project: Neurosynth Cluster Vessel Analysis
# ==========================================================

echo "========================================"
echo "Neurosynth Cluster Analysis"
echo "Step 1: Verify input files"
echo "========================================"

# -----------------------------
# Check required input files
# -----------------------------

FILES=(
    "brain.nii"
    "vessels.nii"
    "stat.nii"
    "mask_167.nii"
    "clusters_thr.nii"
    "registration/sub-02_vesselref.nii.gz"
    "registration/sub-02_ses-02_UNIT12std0GenericAffine.mat"
    "registration/sub-02_ses-02_UNIT12std1InverseWarp.nii.gz"
    "registration/sub-02_ses-02_UNIT12vesselref0GenericAffine.mat"
)

echo ""
echo "Checking required files..."

for file in "${FILES[@]}"
do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ Missing: $file"
        exit 1
    fi
done

echo ""
echo "All required files found."

# -----------------------------
# Display image information
# -----------------------------

echo ""
echo "========================================"
echo "Brain image"
echo "========================================"

3dinfo brain.nii

echo ""
echo "========================================"
echo "Vessel image"
echo "========================================"

3dinfo vessels.nii

echo ""
echo "========================================"
echo "Cluster image"
echo "========================================"

3dinfo clusters_thr.nii

# -----------------------------
# Verify brain and vessels
# -----------------------------

echo ""
echo "========================================"
echo "Checking image geometry"
echo "========================================"

3dinfo -same_grid brain.nii vessels.nii

echo ""
echo "Verification complete."