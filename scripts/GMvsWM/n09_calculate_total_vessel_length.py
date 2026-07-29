#!/usr/bin/env python3

"""
============================================================
09_calculate_total_vessel_length.py

Purpose:
Combine GM and WM vessel lengths into a total vessel length.

Input:
- sub-02_vessel_length.txt

Output:
- sub-02_total_vessel_length.txt

Author:
Anuschka Bergmann
============================================================
"""


import os


INPUT = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/results/sub-02_vessel_length.txt"


OUTPUT = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/results/sub-02_total_vessel_length.txt"



# ------------------------------------------------------------
# Extract lengths
# ------------------------------------------------------------

gm_length = None
wm_length = None


with open(INPUT, "r") as file:

    for line in file:

        if "GM vessel length" in line:
            gm_length = float(
                line.split(":")[1]
            )

        if "WM vessel length" in line:
            wm_length = float(
                line.split(":")[1]
            )



# ------------------------------------------------------------
# Calculate total
# ------------------------------------------------------------

total_length = gm_length + wm_length



# ------------------------------------------------------------
# Save
# ------------------------------------------------------------

with open(OUTPUT, "w") as f:

    f.write("Subject: sub-02\n\n")

    f.write(
        f"GM vessel length (mm): {gm_length}\n"
    )

    f.write(
        f"WM vessel length (mm): {wm_length}\n"
    )

    f.write(
        f"Total vessel length (mm): {total_length}\n"
    )


print("")
print("======================================")
print("Total vessel length calculation complete")
print("Saved:")
print(OUTPUT)
print("======================================")

print(
    f"Total vessel length: {total_length} mm"
)