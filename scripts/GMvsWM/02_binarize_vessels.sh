#!/bin/bash

#############################################################
# Vessel Mask Binarisation
#
# Purpose:
# The original M3PI vessel segmentation output contains values
# ranging from 0-3. These values represent vessel information,
# but do not correspond to different biological vessel classes.
#
# For quantitative vessel analysis, the image is converted into
# a binary mask:
#
#   0 = background
#   1 = vessel
#
# This ensures compatibility with downstream analyses including:
# - vessel skeletonisation
# - vessel length calculation
# - vessel density calculation
# - vessel diameter estimation
#
# Software requirement:
#   FSL (fslmaths)
#
#############################################################


INPUT="/Neurodata/M3PI/derivatives/Anuschka/00.sub-02_ses-7T_part-mag_T2starw_imgavg_preprocessed_vessels.nii.gz"

OUTPUT="/Neurodata/M3PI/derivatives/Anuschka_derivatives/vessels/vessels_binary.nii.gz"


echo "Creating binary vessel mask..."

fslmaths "$INPUT" -bin "$OUTPUT"


echo "Binary vessel mask created:"
echo "$OUTPUT"

Command:
fslstats vessels_binary.nii.gz -R
Expected output:
0.000000 1.000000
Result:
The vessel segmentation was successfully converted into a binary mask containing only background voxels (0) and vessel voxels (1).