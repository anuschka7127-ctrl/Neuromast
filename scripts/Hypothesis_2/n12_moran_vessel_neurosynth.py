#!/usr/bin/env python3

"""
============================================================
11_calculate_schaefer_neurosynth_overlap.py

Purpose:
Calculate proportion of every Schaefer parcel that overlaps
with the significant Neurosynth clusters.

Author:
Anuschka Bergmann
============================================================
"""

import os
import nibabel as nib
import numpy as np
import pandas as pd


ATLAS = "masks/sub-02_Schaefer100_native.nii.gz"

CLUSTERS = "masks/all_affected_clusters.nii.gz"

OUTDIR = "results"

OUTPUT = os.path.join(
    OUTDIR,
    "schaefer_neurosynth_overlap.csv"
)


atlas = nib.load(ATLAS).get_fdata()

clusters = nib.load(CLUSTERS).get_fdata()


results = []


for parcel in range(1,101):

    mask = atlas == parcel

    n_voxels = np.count_nonzero(mask)

    if n_voxels == 0:
        continue

    overlap_voxels = np.count_nonzero(
        clusters[mask] > 0
    )

    overlap_fraction = overlap_voxels / n_voxels

    results.append({

        "parcel": parcel,

        "parcel_voxels": n_voxels,

        "cluster_voxels": overlap_voxels,

        "neurosynth_overlap": overlap_fraction

    })


pd.DataFrame(results).to_csv(
    OUTPUT,
    index=False
)


print("Saved:")
print(OUTPUT)