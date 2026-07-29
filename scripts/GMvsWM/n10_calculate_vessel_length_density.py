#!/usr/bin/env python3

"""
============================================================
10_calculate_vessel_length_density.py

Purpose:
Calculate tissue-normalised vessel length density.

Formula:

Vessel length density =
vessel length (mm) / tissue volume (mm3)

Outputs:
- GM vessel length density
- WM vessel length density

Author:
Anuschka Bergmann
============================================================
"""


import os


# ------------------------------------------------------------
# Input files
# ------------------------------------------------------------

LENGTH_FILE = (
    "/Neurodata/M3PI/derivatives/"
    "Anuschka_derivatives/results/"
    "sub-02_vessel_length.txt"
)


DENSITY_FILE = (
    "/Neurodata/M3PI/derivatives/"
    "Anuschka_derivatives/results/"
    "sub-02_vessel_density.txt"
)


OUTPUT = (
    "/Neurodata/M3PI/derivatives/"
    "Anuschka_derivatives/results/"
    "sub-02_vessel_length_density.txt"
)



# ------------------------------------------------------------
# Read vessel lengths
# ------------------------------------------------------------

gm_length = None
wm_length = None


with open(LENGTH_FILE, "r") as f:

    for line in f:

        if "GM vessel length" in line:
            gm_length = float(
                line.split(":")[1]
            )

        if "WM vessel length" in line:
            wm_length = float(
                line.split(":")[1]
            )



# ------------------------------------------------------------
# Read tissue volumes
# ------------------------------------------------------------

gm_volume = None
wm_volume = None


with open(DENSITY_FILE, "r") as f:

    for line in f:

        if "GM tissue volume" in line:
            gm_volume = float(
                line.split(":")[1]
            )

        if "WM tissue volume" in line:
            wm_volume = float(
                line.split(":")[1]
            )



# ------------------------------------------------------------
# Calculate length density
# ------------------------------------------------------------

gm_length_density = gm_length / gm_volume

wm_length_density = wm_length / wm_volume



# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

with open(OUTPUT, "w") as f:

    f.write("Subject: sub-02\n\n")

    f.write(
        f"GM vessel length (mm): {gm_length}\n"
    )

    f.write(
        f"GM tissue volume (mm3): {gm_volume}\n"
    )

    f.write(
        f"GM vessel length density: {gm_length_density}\n\n"
    )


    f.write(
        f"WM vessel length (mm): {wm_length}\n"
    )

    f.write(
        f"WM tissue volume (mm3): {wm_volume}\n"
    )

    f.write(
        f"WM vessel length density: {wm_length_density}\n"
    )



print("")
print("======================================")
print("Vessel length density calculation complete")
print("Saved:")
print(OUTPUT)
print("======================================")

print(
    f"GM length density: {gm_length_density}"
)

print(
    f"WM length density: {wm_length_density}"
)