# Subject
subject = "sub-02"

# Paths
base = "/Neurodata/M3PI/derivatives/Anuschka_derivatives/tissue_masks"

gm_file = f"{base}/{subject}_GM_vessels.nii.gz"
wm_file = f"{base}/{subject}_WM_vessels.nii.gz"


def calculate_length(input_file):

    # Load image
    img = nib.load(input_file)
    data = img.get_fdata()

    # Convert to binary
    vessel_mask = data > 0

    # Skeletonize 3D vessel mask
    skeleton = skeletonize(vessel_mask)

    # Count skeleton voxels
    skeleton_voxels = np.sum(skeleton)

    # Get voxel size
    voxel_size = img.header.get_zooms()[:3]

    # Approximate length
    voxel_length = np.mean(voxel_size)

    length_mm = skeleton_voxels * voxel_length

    return skeleton_voxels, length_mm


# GM
gm_voxels, gm_length = calculate_length(gm_file)

# WM
wm_voxels, wm_length = calculate_length(wm_file)


print("Subject:", subject)
print("-----------------------")

print(f"GM skeleton voxels: {gm_voxels}")
print(f"GM vessel length: {gm_length:.2f} mm")

print()

print(f"WM skeleton voxels: {wm_voxels}")
print(f"WM vessel length: {wm_length:.2f} mm")