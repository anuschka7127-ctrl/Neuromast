#!/bin/bash

# Cluster identification of thresholded Neurosynth map
# Threshold: z >= 1.67
# Connectivity: NN=1
# Minimum cluster size: 8 voxels

3dClusterize \
-inset stat.nii \
-ithr 0 \
-NN 1 \
-1sided RIGHT_TAIL 1.67 \
-clust_nvox 8 \
-pref_map clusters_thr.nii \
> cluster_report.txt