#!/bin/bash

# ==========================================================
# 03_validate_registration.sh
#
# Purpose:
# Validate that the transformed Neurosynth cluster map
# matches the native 7T vessel reference space.
#
# Checks:
#   1. Output exists
#   2. Geometry matches vessel reference
#   3. Cluster labels are preserved
#   4. Non-zero voxel count
#   5. Minimum and maximum values
#
# Author: Anuschka Bergmann
# ==========================================================


echo "========================================"
echo "Validating ANTs registration"
echo "========================================"


# -----------------------------
# File paths
# -----------------------------

CLUSTER_MAP="masks/clusters_native.nii.gz"

REFERENCE="registration/sub-02_vesselref.nii.gz"

REPORT="results/registration_validation.txt"


# -----------------------------
# Check files exist
# -----------------------------

echo ""
echo "Checking input files..."

if [ ! -f ${CLUSTER_MAP} ]; then
    echo "ERROR: Missing ${CLUSTER_MAP}"
    exit 1
fi

if [ ! -f ${REFERENCE} ]; then
    echo "ERROR: Missing ${REFERENCE}"
    exit 1
fi

echo "Files found."


# -----------------------------
# Start report
# -----------------------------

mkdir -p results

{
echo "========================================"
echo "Registration validation report"
echo "========================================"

echo ""
echo "Cluster map:"
echo ${CLUSTER_MAP}

echo ""
echo "Reference image:"
echo ${REFERENCE}


# -----------------------------
# Geometry check
# -----------------------------

echo ""
echo "----------------------------------------"
echo "Geometry"
echo "----------------------------------------"

echo "Cluster map geometry:"
3dinfo ${CLUSTER_MAP} | grep "Geometry String"

echo ""
echo "Reference geometry:"
3dinfo ${REFERENCE} | grep "Geometry String"


# -----------------------------
# Voxel size check
# -----------------------------

echo ""
echo "----------------------------------------"
echo "Voxel dimensions"
echo "----------------------------------------"

echo "Cluster map:"
3dinfo ${CLUSTER_MAP} | grep -E "step"

echo ""
echo "Reference:"
3dinfo ${REFERENCE} | grep -E "step"


# -----------------------------
# Cluster label check
# -----------------------------

echo ""
echo "----------------------------------------"
echo "Cluster labels"
echo "----------------------------------------"

echo "Minimum value:"
3dBrickStat \
-slow \
-min \
${CLUSTER_MAP}

echo ""

echo "Maximum value:"
3dBrickStat \
-slow \
-max \
${CLUSTER_MAP}


# -----------------------------
# Non-zero voxel count
# -----------------------------

echo ""
echo "----------------------------------------"
echo "Non-zero voxels"
echo "----------------------------------------"

3dBrickStat \
-count \
-non-zero \
${CLUSTER_MAP}


# -----------------------------
# ROI labels
# -----------------------------

echo ""
echo "----------------------------------------"
echo "ROI labels present"
echo "----------------------------------------"

3dROIstats \
-mask ${CLUSTER_MAP} \
${CLUSTER_MAP}


echo ""
echo "========================================"
echo "Validation complete"
echo "========================================"


} > ${REPORT}


echo ""
echo "Report saved:"
echo ${REPORT}