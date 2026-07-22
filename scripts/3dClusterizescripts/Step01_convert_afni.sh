#!/bin/bash

# Convert statistical map to AFNI format

INPUT="stat.nii"
OUTPUT="stat_afni"

3dcopy ${INPUT} ${OUTPUT}

echo "AFNI conversion complete"