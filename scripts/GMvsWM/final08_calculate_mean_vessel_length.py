#!/usr/bin/env python3

"""
============================================================
08_calculate_mean_vessel_length.py

Purpose:
Calculate mean vessel branch length from Skan-derived
centreline vessel measurements.

Input:
- sub-02_vessel_length.txt

Output:
- sub-02_mean_vessel_length.txt

Method:
Mean branch length =
total centreline vessel length / number of branches

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
    "sub-02_mean_vessel_length.txt"
)



# ------------------------------------------------------------
# Extract measurements
# ------------------------------------------------------------

gm_length = None
wm_length = None

gm_branches = None
wm_branches = None


with open(INPUT, "r") as file:

    tissue = None

    for line in file:


        if "Grey Matter" in line:
            tissue = "GM"


        elif "White Matter" in line:
            tissue = "WM"



        if "Number of branches" in line:

            branches = int(
                line.split(":")[1]
            )

            if tissue == "GM":
                gm_branches = branches

            elif tissue == "WM":
                wm_branches = branches



        if "Centreline vessel length" in line:

            length = float(
                line.split(":")[1]
            )

            if tissue == "GM":
                gm_length = length

            elif tissue == "WM":
                wm_length = length



# ------------------------------------------------------------
# Calculate mean branch length
# ------------------------------------------------------------

if None in [
    gm_length,
    wm_length,
    gm_branches,
    wm_branches
]:

    raise ValueError(
        "Missing GM or WM measurements"
    )



gm_mean = gm_length / gm_branches

wm_mean = wm_length / wm_branches



overall_mean = (
    (gm_length + wm_length) /
    (gm_branches + wm_branches)
)



# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

with open(OUTPUT, "w") as f:

    f.write("Subject: sub-02\n\n")


    f.write(
        "Grey Matter\n"
    )

    f.write(
        "----------------\n"
    )

    f.write(
        f"Mean branch length (mm): {gm_mean}\n\n"
    )


    f.write(
        "White Matter\n"
    )

    f.write(
        "----------------\n"
    )

    f.write(
        f"Mean branch length (mm): {wm_mean}\n\n"
    )


    f.write(
        "Whole Brain\n"
    )

    f.write(
        "----------------\n"
    )

    f.write(
        f"Overall mean branch length (mm): {overall_mean}\n"
    )



print("")
print("======================================")
print("Mean vessel length calculation complete")
print("Saved:")
print(OUTPUT)
print("======================================")

print(
    f"GM mean branch length: {gm_mean:.4f} mm"
)

print(
    f"WM mean branch length: {wm_mean:.4f} mm"
)

print(
    f"Overall mean branch length: {overall_mean:.4f} mm"
)