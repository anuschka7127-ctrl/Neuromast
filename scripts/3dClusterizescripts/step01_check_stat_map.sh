#!/bin/bash

3dinfo stat.nii

echo "Minimum value:"
3dinfo -min stat.nii

echo "Maximum value:"
3dinfo -max stat.nii

OUTPUT min = 0
max = 11