#!/bin/bash

# ==========================================================
# 09_calculate_nonaffected_vessel_density.sh
#
# Calculates vessel density:
#
# vessel voxels / ROI voxels
#
# ==========================================================


mkdir -p results


ROI=$(3dBrickStat \
-count \
-non-zero \
masks/non_affected_brain_mask.nii.gz)


VESSELS=$(3dBrickStat \
-count \
-non-zero \
vessels/non_affected_vessels.nii.gz)


DENSITY=$(python3 - <<EOF
roi=$ROI
vessels=$VESSELS
print(round(vessels/roi,5))
EOF
)


echo "region,roi_voxels,vessel_voxels,vessel_density" \
> results/nonaffected_vessel_density.csv


echo "non_affected,$ROI,$VESSELS,$DENSITY" \
>> results/nonaffected_vessel_density.csv


echo "Done"