#!/bin/bash


INPUT="stat_thr3.nii"


3dExtrema \
-closure \
-sep_dist 12 \
-volume \
${INPUT} \
> MNI_peaks_thr3.txt


echo "Peak extraction complete"