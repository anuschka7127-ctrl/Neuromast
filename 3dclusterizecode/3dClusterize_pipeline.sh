# NeuroSynth Vascular Dementia Meta-Analysis Pipeline

This repository contains the full preprocessing, thresholding, and cluster analysis workflow applied to NeuroSynth-derived statistical maps using FSL and AFNI.

## Input files
- z_corr-FDR_method-indep.nii → corrected Z-score map (primary statistical image)
- brain_mask.nii → MNI-space brain mask

## Step 1: Threshold Z-map (FSL)

The corrected Z-map was thresholded at Z ≥ 1.67 (approximately p < 0.05, one-tailed). No binarization was applied in order to preserve statistical intensity information.

Command:
fslmaths z_corr-FDR_method-indep.nii -thr 1.67 z_thr167.nii

Check intensity range:
fslstats z_thr167.nii -R

Expected output:
min = 0
max ≈ 2.36 (depending on peak values)

## Step 2: Cluster analysis (AFNI 3dClusterize)

Spatial clustering was performed using AFNI with 26-neighbour connectivity (NN=3), a minimum cluster size of 10 voxels, and a one-sided positive threshold.

Command:
3dClusterize \
-inset z_thr167.nii \
-ithr 0 \
-mask brain_mask.nii \
-NN 3 \
-clust_nvox 10 \
-1sided RIGHT_TAIL 1.67 \
-overwrite \
-pref_map cluster_map_167.nii \
-pref_dat cluster_output_167.txt

## Outputs

cluster_map_167.nii
→ voxel-wise cluster labels for visualization in FSLeyes

cluster_output_167.txt
→ cluster table including:
- cluster size (voxels)
- center of mass (MNI coordinates)
- peak Z-values
- cluster extent

## Methodological notes

- Corrected Z-score map was used (not raw statistical map)
- Threshold set at Z ≥ 1.67 (one-tailed)
- No binarization was applied at any stage
- Clustering performed after thresholding in FSL
- Brain mask applied to restrict analysis to brain voxels

## Important note

Intermediate binary threshold outputs (e.g. thresh_167.nii) were not used in the final analysis.