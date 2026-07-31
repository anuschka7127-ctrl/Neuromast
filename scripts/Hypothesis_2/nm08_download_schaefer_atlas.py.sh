#!/usr/bin/env python3

"""
============================================================
08_download_schaefer_atlas.py

Purpose:
Download Schaefer 2018 cortical parcellation.

Atlas:
- Schaefer 100 parcels
- 7 Yeo networks
- MNI152 2mm resolution

Output:
Schaefer atlas NIfTI file

Author:
Anuschka Bergmann
============================================================
"""


from nilearn.datasets import fetch_atlas_schaefer_2018
import os
import shutil


# Output directory

OUTDIR = "atlases"

os.makedirs(OUTDIR, exist_ok=True)


print("Downloading Schaefer atlas...")


atlas = fetch_atlas_schaefer_2018(
    n_rois=100,
    yeo_networks=7,
    resolution_mm=2
)


print("Atlas downloaded:")
print(atlas.maps)


# Copy into project folder

output = os.path.join(
    OUTDIR,
    "Schaefer100_7Networks_MNI152_2mm.nii.gz"
)


shutil.copy(
    atlas.maps,
    output
)


print("")
print("======================================")
print("Schaefer atlas saved:")
print(output)
print("======================================")