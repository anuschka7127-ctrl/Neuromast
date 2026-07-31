#!/usr/bin/env python3

import os
import nibabel as nib
import numpy as np
import pandas as pd

from skimage.morphology import skeletonize
from skan import Skeleton


# ==========================================================
# 06_calculate_mean_vessel_length.py
#
# Purpose:
# Calculate mean vessel segment length from binary vessel masks
#
# Input:
#   vessels/*.nii.gz
#
# Output:
#   results/vessel_length.csv
#
# ==========================================================


# Input vessel masks
vessel_files = [
    "cluster_01_vessels.nii.gz",
    "cluster_02_vessels.nii.gz",
    "cluster_03_vessels.nii.gz",
    "cluster_04_vessels.nii.gz",
    "cluster_05_vessels.nii.gz",
    "cluster_06_vessels.nii.gz",
    "cluster_07_vessels.nii.gz",
    "non_affected_vessels.nii.gz"
]


input_dir = "vessels"
output_dir = "results"

os.makedirs(output_dir, exist_ok=True)


results = []


for vessel_file in vessel_files:

    print(f"Processing {vessel_file}")

    filepath = os.path.join(input_dir, vessel_file)

    # Load image
    img = nib.load(filepath)
    data = img.get_fdata()

    # Convert to binary
    binary = data > 0

    # Get voxel dimensions in mm
    voxel_size = img.header.get_zooms()

    # Skeletonize
    skeleton = skeletonize(binary)


    # Create skan skeleton object
    skel = Skeleton(
        skeleton,
        spacing=voxel_size
    )


    # Extract branch information
    branch_data = skel.path_lengths()


    # Total vessel length
    total_length = np.sum(branch_data)


    # Number of vessel segments
    n_segments = len(branch_data)


    # Mean vessel length
    if n_segments > 0:
        mean_length = total_length / n_segments
    else:
        mean_length = 0


    results.append({
        "region": vessel_file.replace("_vessels.nii.gz", ""),
        "number_segments": n_segments,
        "total_length_mm": total_length,
        "mean_length_mm": mean_length
    })


# Save results

df = pd.DataFrame(results)

output_file = os.path.join(
    output_dir,
    "vessel_length.csv"
)

df.to_csv(output_file, index=False)


print("\n===================================")
print("Vessel length calculation complete")
print(f"Saved: {output_file}")
print("===================================")