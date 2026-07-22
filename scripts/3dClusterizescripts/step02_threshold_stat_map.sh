#!/bin/bash

# Threshold 1.67

3dcalc \
-a stat.nii \
-expr 'step(a-1.67)' \
-prefix results/mask_167.nii


# Threshold 3.5

3dcalc \
-a stat.nii \
-expr 'step(a-3.5)' \
-prefix results/mask_35.nii

Outputs:
mask_167.nii
mask_35.nii