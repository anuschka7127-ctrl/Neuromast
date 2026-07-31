#!/usr/bin/env python3

"""
============================================================
09_calculate_total_vessel_length.py

Purpose:
Combine GM and WM Skan-derived centreline vessel lengths.

Input:
- sub-02_vessel_length.txt

Output:
- sub-02_total_vessel_length.txt

Author:
Anuschka Bergmann
============================================================
"""


INPUT = (
    "/Neurodata/M3PI/derivatives/"
    "Anuschka_derivatives/results/"
    "sub-02_vessel_length.txt"
)


OUTPUT = (
    "/Neurodata/M3PI/derivatives/"
    "Anuschka_derivatives/results/"
    "sub-02_total_vessel_length.txt"
)



# ------------------------------------------------------------
# Extract Skan centreline lengths
# ------------------------------------------------------------

gm_length = None
wm_length = None


with open(INPUT, "r") as file:

    current_tissue = None

    for line in file:

        if "Grey Matter" in line:
            current_tissue = "GM"

        elif "White Matter" in line:
            current_tissue = "WM"


        if "Centreline vessel length" in line:

            length = float(
                line.split(":")[1]
            )

            if current_tissue == "GM":
                gm_length = length

            elif current_tissue == "WM":
                wm_length = length



# ------------------------------------------------------------
# Check extraction
# ------------------------------------------------------------

if gm_length is None or wm_length is None:

    raise ValueError(
        "Could not extract GM and WM centreline vessel lengths"
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
        f"GM centreline vessel length (mm): {gm_length}\n"
    )

    f.write(
        f"WM centreline vessel length (mm): {wm_length}\n"
    )

    f.write(
        f"Total centreline vessel length (mm): {total_length}\n"
    )



print("")
print("======================================")
print("Total vessel length calculation complete")
print("Saved:")
print(OUTPUT)
print("======================================")

print(
    f"Total centreline vessel length: {total_length} mm"
)