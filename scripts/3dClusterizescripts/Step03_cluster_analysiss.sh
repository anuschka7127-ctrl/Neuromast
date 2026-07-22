#!/bin/bash


3dclust \
-1dindex 0 \
-savemask clusters_thr.nii \
20 1.01 mask_167.nii


echo "Cluster analysis complete"