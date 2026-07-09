#!/bin/bash

# ==========================================================
# Step 3: Tissue Segmentation
#
# Purpose:
# Segment the brain into different tissue classes:
# gray matter (GM), white matter (WM), and cerebrospinal
# fluid (CSF).
#
# Why:
# Vessel measurements need to be separated by tissue type.
# This allows comparison of vessel density and diameter
# between GM and WM.
#
# Input:
#   brain_extracted_0.5mm.nii
#
# Software:
#   FSL FAST
#
# Output:
#   brain_tissue_pve_0.nii.gz  -> CSF probability map
#   brain_tissue_pve_1.nii.gz  -> GM probability map
#   brain_tissue_pve_2.nii.gz  -> WM probability map
#   brain_tissue_seg.nii.gz    -> hard tissue segmentation
# ==========================================================


# Run FSL FAST tissue segmentation
fast \
-t 1 \
-n 3 \
-o brain_tissue \
brain_extracted_0.5mm.nii