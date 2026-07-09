#!/bin/bash

# ==========================================================
# Step 2: Brain Extraction
#
# Purpose:
# Remove non-brain tissue (e.g., skull, scalp, and surrounding
# structures) from the downsampled MRI to improve the accuracy
# of tissue segmentation.
#
# Why this step?
# Tissue segmentation algorithms classify voxels into gray
# matter (GM), white matter (WM), and cerebrospinal fluid (CSF).
# Structures outside the brain can reduce segmentation accuracy,
# so we first isolate the brain.
#
# Input:
#   brain_0.5mm.nii
#
# Output:
#   brain_0.5mm_brain.nii
#
# Software:
#   FSL BET (Brain Extraction Tool)
# ==========================================================

Step 1: check fsl version: 
input: which bet 
output: /Users/anuschkabergmann/fsl/share/fsl/bin/bet

Step 2: extract brain to create much cleaner image for tissue segmentation.

input command: 
bet brain_0.5mm.nii brain_0.5mm_brain.nii-R-m
OUTPUT: brain_0.5mm_brain.nii

Alternative Step 2: using AFNI to extract the brain:

input command: 
3dcalc \
-a brain_0.5mm.nii \
-b brain_0.5mm_brain_mask.nii \
-expr 'a*b' \
-prefix brain_extracted_0.5mm.nii

Output file: brain_extracted_0.5mm.nii


