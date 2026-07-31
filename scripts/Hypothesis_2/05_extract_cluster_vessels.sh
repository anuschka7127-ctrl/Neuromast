#!/bin/bash

# ==========================================================
# 05_extract_cluster_vessels.sh
#
# Purpose:
# Extract vessel masks contained within each selected
# Neurosynth cluster.
#
# Method:
# Cluster vessel mask =
# cluster mask × binary vessel mask
#
# Inputs:
#   masks/individual_clusters/cluster_XX.nii.gz
#   vessels_binary.nii.gz
#
# Output:
#   vessels/cluster_XX_vessels.nii.gz
#
# Selected clusters:
#   01-07 (manually selected for downstream analysis)
#
# Author:
# Anuschka Bergmann
# ==========================================================


set -e


echo "=========================================="
echo "Extracting vessels within clusters"
echo "=========================================="


# ----------------------------------------------------------
# Inputs
# ----------------------------------------------------------

CLUSTER_DIR="masks/individual_clusters"

VESSEL_MASK="vessels_binary.nii.gz"

OUTDIR="vessels"


mkdir -p ${OUTDIR}



# ----------------------------------------------------------
# Extract vessels for each cluster
# ----------------------------------------------------------

for i in $(seq -f "%02g" 1 7)

do

    CLUSTER_MASK="${CLUSTER_DIR}/cluster_${i}.nii.gz"

    OUTPUT="${OUTDIR}/cluster_${i}_vessels.nii.gz"



    echo ""
    echo "Extracting vessels for cluster ${i}"



    3dcalc \
    -a ${CLUSTER_MASK} \
    -b ${VESSEL_MASK} \
    -expr "a*b" \
    -prefix ${OUTPUT}


done



echo ""
echo "=========================================="
echo "Cluster vessel extraction complete"
echo "=========================================="