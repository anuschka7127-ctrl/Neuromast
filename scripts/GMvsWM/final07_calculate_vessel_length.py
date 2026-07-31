#!/usr/bin/env python3

"""
============================================================
07_calculate_vessel_length.py

Purpose:
Calculate total vessel centreline length within grey
and white matter vessel masks.

Method:
1. Load GM and WM vessel masks
2. Skeletonise vessel masks
3. Use Skan to measure skeleton branch distances
4. Sum branch distances to obtain physical vessel length (mm)

Skan accounts for voxel spacing and branch geometry,
providing a true centreline length estimate rather than
a voxel-count approximation.

Author:
Anuschka Bergmann
============================================================
"""


import os
import nibabel as nib

from skimage.morphology import skeletonize
from skan import Skeleton, summarize



# ------------------------------------------------------------
# Paths
# ------------------------------------------------------------

TISSUE_DIR = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

OUTDIR = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/results"

os.makedirs(OUTDIR, exist_ok=True)



GM_FILE = os.path.join(
    TISSUE_DIR,
    "sub-02_GM_vessels.nii.gz"
)


WM_FILE = os.path.join(
    TISSUE_DIR,
    "sub-02_WM_vessels.nii.gz"
)



# ------------------------------------------------------------
# Function
# ------------------------------------------------------------

def calculate_vessel_length(image_path):

    print("\nLoading:")
    print(image_path)


    img = nib.load(image_path)

    data = img.get_fdata()


    # Read physical voxel dimensions from NIfTI header
    voxel_size = img.header.get_zooms()[:3]

    print("Voxel size:", voxel_size)


    # Convert vessel mask to binary
    mask = data > 0


    # Skeletonise vessel network
    print("Skeletonising vessels...")

    skeleton = skeletonize(mask)



    # --------------------------------------------------------
    # Measure centreline length using Skan
    # --------------------------------------------------------

    print("Calculating centreline length using Skan...")


    skel = Skeleton(
        skeleton,
        spacing=voxel_size
    )


    branches = summarize(skel)


    total_length_mm = (
        branches["branch-distance"]
        .sum()
    )


    number_of_branches = len(branches)


    return (
        number_of_branches,
        total_length_mm
    )



# ------------------------------------------------------------
# Grey matter
# ------------------------------------------------------------

print("======================================")
print("Calculating GM vessel length")
print("======================================")


gm_branches, gm_length = calculate_vessel_length(
    GM_FILE
)



# ------------------------------------------------------------
# White matter
# ------------------------------------------------------------

print("\n======================================")
print("Calculating WM vessel length")
print("======================================")


wm_branches, wm_length = calculate_vessel_length(
    WM_FILE
)



# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

output = os.path.join(
    OUTDIR,
    "sub-02_vessel_length.txt"
)


with open(output, "w") as f:

    f.write(
        "Subject: sub-02\n\n"
    )


    f.write(
        "Grey Matter Vessel Measurements\n"
    )

    f.write(
        "--------------------------------\n"
    )

    f.write(
        f"Number of branches: {gm_branches}\n"
    )

    f.write(
        f"Centreline vessel length (mm): {gm_length}\n\n"
    )


    f.write(
        "White Matter Vessel Measurements\n"
    )

    f.write(
        "--------------------------------\n"
    )

    f.write(
        f"Number of branches: {wm_branches}\n"
    )

    f.write(
        f"Centreline vessel length (mm): {wm_length}\n"
    )



print("\n======================================")
print("Vessel length calculation complete")
print("Saved:")
print(output)
print("======================================")