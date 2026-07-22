import subprocess
import os

# Subject
subject = "sub-02"

# Paths
base = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

gm_vessels = f"{base}/{subject}_GM_vessels.nii.gz"
gm_mask = f"{base}/{subject}_GM_binary.nii.gz"

wm_vessels = f"{base}/{subject}_WM_vessels.nii.gz"
wm_mask = f"{base}/{subject}_WM_binary.nii.gz"


def get_volume(image):
    """
    Get voxel count from fslstats -V
    """
    result = subprocess.run(
        ["fslstats", image, "-V"],
        capture_output=True,
        text=True
    )

    voxels = int(result.stdout.split()[0])
    return voxels


# Extract volumes
gm_vessel_volume = get_volume(gm_vessels)
gm_tissue_volume = get_volume(gm_mask)

wm_vessel_volume = get_volume(wm_vessels)
wm_tissue_volume = get_volume(wm_mask)


# Calculate density
gm_density = (gm_vessel_volume / gm_tissue_volume) * 100
wm_density = (wm_vessel_volume / wm_tissue_volume) * 100


# Print results
print("Subject:", subject)
print("-----------------------")
print(f"GM vessel density: {gm_density:.2f}%")
print(f"WM vessel density: {wm_density:.2f}%")