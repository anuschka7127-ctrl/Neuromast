#!/bin/bash

# ==========================================================
# 04_extract_individual_clusters.sh
#
# Purpose:
# Extract individual binary masks from the registered
# Neurosynth cluster map in native 7T vessel reference space.
#
# Input:
#   masks/clusters_native.nii.gz
#
# Output:
#   masks/individual_clusters/cluster_XX.nii.gz
#
# Clusters:
#   Largest 7 clusters selected for downstream vascular analysis
#
# Author: Anuschka Bergmann
# ==========================================================


echo "=========================================="
echo "Extracting individual cluster masks"
echo "=========================================="


# Input cluster map
CLUSTER_MAP="masks/clusters_native.nii.gz"

# Output directory
OUTDIR="masks/individual_clusters"


# Create output directory
mkdir -p ${OUTDIR}


# Selected clusters
CLUSTERS=(1 2 3 4 5 6 7)


# Extract each cluster
for CLUSTER in "${CLUSTERS[@]}"
do

    OUTPUT="${OUTDIR}/cluster_$(printf "%02d" ${CLUSTER}).nii.gz"

    echo "Extracting cluster ${CLUSTER}"

    3dcalc \
    -a ${CLUSTER_MAP} \
    -expr "equals(a,${CLUSTER})" \
    -prefix ${OUTPUT}

done


echo ""
echo "=========================================="
echo "Cluster extraction complete"
echo "=========================================="