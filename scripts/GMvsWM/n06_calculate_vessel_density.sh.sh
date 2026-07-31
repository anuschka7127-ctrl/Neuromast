#!/bin/bash

# ============================================================
# 06_calculate_vessel_density.sh
#
# Purpose:
# Calculate tissue-specific vessel density.
#
# Vessel density is calculated as:
#
#       vessel volume / tissue volume
#
# Measurements are calculated separately for:
#
#   - Grey matter (GM)
#   - White matter (WM)
#
# Important:
# Tissue masks were created from the UNIT1 segmentation and
# transformed into 7T vessel space using ANTs before this step.
#
# Author:
# Anuschka Bergmann
#
# ============================================================


# -----------------------------
# Directories
# -----------------------------

TISSUE_DIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

OUTDIR="/Neurodata/M3PI/derivatives/Anuschka_derivatives/results"

mkdir -p ${OUTDIR}



# -----------------------------
# Calculate vessel volumes
# -----------------------------

echo "Calculating GM vessel volume..."

GM_VESSEL_VOL=$(fslstats \
${TISSUE_DIR}/sub-02_GM_vessels.nii.gz \
-V | awk '{print $2}')


echo "Calculating WM vessel volume..."

WM_VESSEL_VOL=$(fslstats \
${TISSUE_DIR}/sub-02_WM_vessels.nii.gz \
-V | awk '{print $2}')



# -----------------------------
# Calculate tissue volumes
#
# These masks are the ANTs-transformed
# tissue masks in vessel space.
# -----------------------------

echo "Calculating GM tissue volume..."

GM_VOL=$(fslstats \
${TISSUE_DIR}/sub-02_GM_vesselspace.nii.gz \
-V | awk '{print $2}')


echo "Calculating WM tissue volume..."

WM_VOL=$(fslstats \
${TISSUE_DIR}/sub-02_WM_vesselspace.nii.gz \
-V | awk '{print $2}')



# -----------------------------
# Check tissue volumes
# -----------------------------

if [ "$GM_VOL" == "0" ] || [ "$WM_VOL" == "0" ]; then

    echo "ERROR: Tissue volume is zero."
    echo "Check GM/WM masks."
    exit 1

fi



# -----------------------------
# Calculate vessel densities
# -----------------------------

echo "Calculating vessel densities..."

GM_DENSITY=$(echo "${GM_VESSEL_VOL}/${GM_VOL}" | bc -l)

WM_DENSITY=$(echo "${WM_VESSEL_VOL}/${WM_VOL}" | bc -l)



# -----------------------------
# Save results
# -----------------------------

OUTPUT="${OUTDIR}/sub-02_vessel_density.txt"


echo "Subject: sub-02" > ${OUTPUT}

echo "" >> ${OUTPUT}


echo "GM vessel volume (mm3): ${GM_VESSEL_VOL}" >> ${OUTPUT}

echo "GM tissue volume (mm3): ${GM_VOL}" >> ${OUTPUT}

echo "GM vessel density: ${GM_DENSITY}" >> ${OUTPUT}


echo "" >> ${OUTPUT}


echo "WM vessel volume (mm3): ${WM_VESSEL_VOL}" >> ${OUTPUT}

echo "WM tissue volume (mm3): ${WM_VOL}" >> ${OUTPUT}

echo "WM vessel density: ${WM_DENSITY}" >> ${OUTPUT}



echo ""
echo "======================================"
echo "Vessel density calculation complete"
echo "Saved:"
echo "${OUTPUT}"
echo "======================================"


cat ${OUTPUT}