#!/bin/bash

# ==========================================================
# 05_extract_cluster_vessels.sh
#
# Purpose:
# Extract vessel masks within each individual Neurosynth
# cluster ROI in native 7T vessel reference space.
#
# Input:
#   masks/individual_clusters/cluster_XX.nii.gz
#   vessels_binary.nii.gz
#
# Output:
#   vessels/cluster_XX_vessels.nii.gz
#
# Method:
#   Binary multiplication:
#   cluster mask × binary vessel mask
#
# Author: Anuschka Bergmann
# ==========================================================


echo "=========================================="
echo "Extracting cluster-specific vessel masks"
echo "=========================================="


# Input vessel mask
VESSEL_MASK="vessels_binary.nii.gz"


# Input cluster directory
CLUSTER_DIR="masks/individual_clusters"


# Output directory
OUTDIR="vessels"


# Create output directory
mkdir -p ${OUTDIR}


# Selected clusters
CLUSTERS=(01 02 03 04 05 06 07)


# Extract vessels within each cluster
for CLUSTER in "${CLUSTERS[@]}"
do

    INPUT_CLUSTER="${CLUSTER_DIR}/cluster_${CLUSTER}.nii.gz"

    OUTPUT="${OUTDIR}/cluster_${CLUSTER}_vessels.nii.gz"


    echo "Processing cluster ${CLUSTER}"


    3dcalc \
    -a ${INPUT_CLUSTER} \
    -b ${VESSEL_MASK} \
    -expr 'a*b' \
    -prefix ${OUTPUT} \
    -overwrite


done


echo ""
echo "=========================================="
echo "Cluster vessel extraction complete"
echo "=========================================="