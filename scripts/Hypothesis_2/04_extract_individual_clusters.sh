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



# ----------------------------------------------------------
# Extract each cluster
#
# seq generates zero-padded cluster numbers:
# 01 02 03 ... 07
#
# This removes the need for:
#   CLUSTERS=(1 2 3 4 5 6 7)
#   printf "%02d"
# ----------------------------------------------------------

for CLUSTER in $(seq -f %02g 1 7)

do

    OUTPUT="${OUTDIR}/cluster_${CLUSTER}.nii.gz"

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