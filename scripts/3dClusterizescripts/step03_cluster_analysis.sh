#!/bin/bash


3dClusterize \
-mask_from_hdr \
-inset results/mask_167.nii \
-idat 0 \
-clust_nvox 1 \
-savemask results/clusters_167.nii \
> results/clusters_167_report.txt



3dClusterize \
-mask_from_hdr \
-inset results/mask_35.nii \
-idat 0 \
-clust_nvox 1 \
-savemask results/clusters_35.nii \
> results/clusters_35_report.txt

Outputs:
clusters_167.nii
clusters_35.nii
clusters_167_report.txt
clusters_35_report.txt
