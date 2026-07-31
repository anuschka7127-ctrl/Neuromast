#!/usr/bin/env python3

import os
import pandas as pd


# ==========================================================
# 11_combine_vascular_metrics.py
#
# Purpose:
# Combine vessel density and vessel length measurements
# into a single vascular metrics table.
#
# Input:
#   results/vessel_density.csv
#   results/vessel_length.csv
#
# Output:
#   results/final_vascular_metrics.csv
#
# ==========================================================


# Input files

density_file = "results/vessel_density.csv"
length_file = "results/vessel_length.csv"


# Load datasets

density = pd.read_csv(density_file)
length = pd.read_csv(length_file)


# Rename region column so both datasets match

length = length.rename(
    columns={
        "region": "cluster"
    }
)


# Merge density and length data

combined = pd.merge(
    density,
    length,
    on="cluster",
    how="outer"
)


# Save output

output_file = (
    "results/final_vascular_metrics.csv"
)

combined.to_csv(
    output_file,
    index=False
)


print("\n===================================")
print("Vascular metrics combined")
print(f"Saved: {output_file}")
print("===================================")