#!/bin/bash

# ==========================================================
# 06_calculate_vessel_density.sh
#
# Purpose:
# Calculate vessel density within each selected
# Neurosynth cluster.
#
# Formula:
#
# Vessel density =
# vessel voxels / ROI voxels
#
# Inputs:
#   masks/individual_clusters/cluster_XX.nii.gz
#   vessels/cluster_XX_vessels.nii.gz
#
# Output:
#   results/vessel_density.csv
#
# Selected clusters:
#   01-07 (manually selected for downstream analysis)
#
# Author:
# Anuschka Bergmann
# ==========================================================


set -e


echo "=========================================="
echo "Calculating cluster vessel density"
echo "=========================================="


# ----------------------------------------------------------
# Directories
# ----------------------------------------------------------

CLUSTER_DIR="masks/individual_clusters"

VESSEL_DIR="vessels"

OUTDIR="results"


mkdir -p ${OUTDIR}



# ----------------------------------------------------------
# Output CSV
# ----------------------------------------------------------

OUTPUT="${OUTDIR}/vessel_density.csv"


echo "cluster,roi_voxels,vessel_voxels,vessel_density" > ${OUTPUT}



# ----------------------------------------------------------
# Calculate density
# ----------------------------------------------------------

for i in $(seq -f "%02g" 1 7)

do

    echo ""
    echo "Processing cluster ${i}"



    ROI="${CLUSTER_DIR}/cluster_${i}.nii.gz"

    VESSEL="${VESSEL_DIR}/cluster_${i}_vessels.nii.gz"



    # ROI voxel count

    roi_voxels=$(fslstats \
    ${ROI} \
    -V | awk '{print $1}')



    # Vessel voxel count

    vessel_voxels=$(fslstats \
    ${VESSEL} \
    -V | awk '{print $1}')



    # Vessel density

    density=$(echo "${vessel_voxels}/${roi_voxels}" | bc -l)



    # Save result

    echo "${i},${roi_voxels},${vessel_voxels},${density}" >> ${OUTPUT}


done



echo ""
echo "=========================================="
echo "Vessel density calculation complete"
echo "Saved:"
echo "${OUTPUT}"
echo "=========================================="