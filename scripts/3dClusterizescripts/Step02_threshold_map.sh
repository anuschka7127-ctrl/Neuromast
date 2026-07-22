#!/bin/bash

INPUT="stat.nii"


# Low threshold
3dcalc \
-a ${INPUT} \
-expr 'step(a-1.67)' \
-prefix stat_thr.nii


# Create binary mask
3dcalc \
-a ${INPUT} \
-expr 'step(a-1.67)' \
-prefix mask_167.nii


# Higher threshold
3dcalc \
-a ${INPUT} \
-expr 'step(a-3.0)' \
-prefix stat_thr3.nii


echo "Thresholding complete"