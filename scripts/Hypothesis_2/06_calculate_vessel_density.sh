#!/bin/bash

# Calculate vessel density within each extracted cluster
# Vessel density = vessel voxels / cluster voxels

mkdir -p vessels
mkdir -p results

echo "cluster,roi_voxels,vessel_voxels,vessel_density" > results/vessel_density.csv

for i in 01 02 03 04 05 06 07
do
    echo "Processing cluster ${i}"

    cluster_mask="masks/individual_clusters/cluster_${i}.nii.gz"
    vessel_mask="vessels/cluster_${i}_vessels.nii.gz"

    # Extract vessels within cluster
    3dcalc \
    -a ${cluster_mask} \
    -b vessels_binary.nii.gz \
    -expr 'a*b' \
    -prefix ${vessel_mask} \
    -overwrite

    # Count cluster voxels
    roi_voxels=$(3dBrickStat \
    -count \
    -non-zero \
    ${cluster_mask})

    # Count vessel voxels
    vessel_voxels=$(3dBrickStat \
    -count \
    -non-zero \
    ${vessel_mask})

    # Calculate density
    density=$(python3 - <<EOF
roi=${roi_voxels}
vessel=${vessel_voxels}
print(round(vessel/roi,5))
EOF
)

    echo "cluster_${i},${roi_voxels},${vessel_voxels},${density}" >> results/vessel_density.csv

done

echo "Done!"