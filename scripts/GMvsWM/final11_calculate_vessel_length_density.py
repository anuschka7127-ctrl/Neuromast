#!/usr/bin/env python3

"""
============================================================
11_calculate_vessel_length_density.py

Purpose:
Calculate tissue-normalised vessel length density.

Formula:

Vessel length density =
centreline vessel length (mm) / tissue volume (mm3)

Centreline lengths are calculated using Skan.

Outputs:
- GM vessel length density
- WM vessel length density

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
# Read Skan vessel lengths
# ------------------------------------------------------------

gm_length = None
wm_length = None


with open(LENGTH_FILE, "r") as f:

    for line in f:

        if "Centreline vessel length" in line:

            value = float(
                line.split(":")[1]
            )

            if gm_length is None:
                gm_length = value

            else:
                wm_length = value



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
# Save
# ------------------------------------------------------------

with open(OUTPUT, "w") as f:

    f.write("Subject: sub-02\n\n")

    f.write("Grey Matter\n")
    f.write("----------------\n")

    f.write(
        f"Centreline vessel length (mm): {gm_length}\n"
    )

    f.write(
        f"Tissue volume (mm3): {gm_volume}\n"
    )

    f.write(
        f"Vessel length density: {gm_length_density}\n\n"
    )


    f.write("White Matter\n")
    f.write("----------------\n")

    f.write(
        f"Centreline vessel length (mm): {wm_length}\n"
    )

    f.write(
        f"Tissue volume (mm3): {wm_volume}\n"
    )

    f.write(
        f"Vessel length density: {wm_length_density}\n"
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