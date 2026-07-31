#!/bin/bash

# 
# Step 1
# Inspect the Neurosynth statistical map
# 

INPUT="stat.nii"

echo "Checking image information..."
3dinfo ${INPUT}

echo ""
echo "Minimum statistic:"
3dinfo -min ${INPUT}

echo ""
echo "Maximum statistic:"
3dinfo -max ${INPUT}