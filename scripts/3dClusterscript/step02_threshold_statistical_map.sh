#!/bin/bash

# 
# Step 2
# Threshold the statistical map
# 

INPUT="stat.nii"

THRESHOLD=1.67

echo "Applying threshold..."

3dcalc \
-a ${INPUT} \
-expr "step(a-${THRESHOLD})" \
-prefix mask_167.nii

echo ""
echo "Checking output..."

3dinfo -min mask_167.nii
3dinfo -max mask_167.nii

echo ""
echo "Number of significant voxels:"

3dBrickStat \
-count \
-non-zero \
mask_167.nii