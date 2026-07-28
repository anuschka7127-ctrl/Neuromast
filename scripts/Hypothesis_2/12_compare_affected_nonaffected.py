#!/usr/bin/env python3

import pandas as pd


# ==========================================================
# 12_compare_affected_nonaffected.py
#
# Purpose:
# Compare vascular properties between:
#   1. Neurosynth affected regions
#   2. Non-affected brain regions
#
# Input:
#   results/final_vascular_metrics.csv
#
# Output:
#   results/affected_vs_nonaffected.csv
#
# ==========================================================


# Load final vascular dataset

df = pd.read_csv(
    "results/final_vascular_metrics.csv"
)


# Separate affected and non-affected regions

affected = df[
    df["cluster"].str.contains("cluster")
]


non_affected = df[
    df["cluster"] == "non_affected"
]


# ==========================================================
# Vessel density
# ==========================================================


# Combine affected regions using voxel weighting

affected_roi_voxels = (
    affected["roi_voxels"].sum()
)

affected_vessel_voxels = (
    affected["vessel_voxels"].sum()
)


affected_density = (
    affected_vessel_voxels /
    affected_roi_voxels
)


# Non-affected density

non_affected_density = (
    non_affected["vessel_voxels"].iloc[0] /
    non_affected["roi_voxels"].iloc[0]
)


# ==========================================================
# Mean vessel length
# ==========================================================


affected_total_length = (
    affected["total_length_mm"].sum()
)


affected_segments = (
    affected["number_segments"].sum()
)


affected_mean_length = (
    affected_total_length /
    affected_segments
)


non_affected_mean_length = (
    non_affected["total_length_mm"].iloc[0] /
    non_affected["number_segments"].iloc[0]
)



# ==========================================================
# Create final comparison table
# ==========================================================


comparison = pd.DataFrame({

    "group": [
        "affected",
        "non_affected"
    ],

    "vessel_density": [
        affected_density,
        non_affected_density
    ],

    "mean_vessel_length_mm": [
        affected_mean_length,
        non_affected_mean_length
    ]

})


# Save results

comparison.to_csv(
    "results/affected_vs_nonaffected.csv",
    index=False
)


print("\n===================================")
print("Affected vs non-affected comparison complete")
print("Saved: results/affected_vs_nonaffected.csv")
print("===================================")