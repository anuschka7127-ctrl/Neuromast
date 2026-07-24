import numpy as np
import nibabel as nib

from skimage.morphology import skeletonize
from skimage.measure import label, regionprops



# Settings


subject = "sub-02"

voxel_size = 0.1747  # mm


gm_vessels = (
    "/Neurodata/M3PI/derivatives/Anuschka_derivatives/"
    "tissue_masks/sub-02_GM_vessels.nii.gz"
)

wm_vessels = (
    "/Neurodata/M3PI/derivatives/Anuschka_derivatives/"
    "tissue_masks/sub-02_WM_vessels.nii.gz"
)


# Function to calculate lengths


def calculate_average_length(image_path):

    img = nib.load(image_path)
    data = img.get_fdata()

    # binary vessel mask
    vessel_mask = data > 0


    # skeletonize
    skeleton = skeletonize(vessel_mask)


    # label connected skeleton components
    labeled = label(skeleton)


    lengths = []


    for region in regionprops(labeled):

        # number of voxels in this vessel component
        voxel_count = region.area


        # convert to mm
        length_mm = voxel_count * voxel_size


        lengths.append(length_mm)



    lengths = np.array(lengths)


    return {
        "segments": len(lengths),
        "mean": np.mean(lengths),
        "median": np.median(lengths),
        "std": np.std(lengths),
        "total": np.sum(lengths)
    }




# Run analysis



print(f"Subject: {subject}")
print("-----------------------")


gm = calculate_average_length(gm_vessels)

print("\nGM vessels")
print(f"Number of segments: {gm['segments']}")
print(f"Mean vessel length: {gm['mean']:.2f} mm")
print(f"Median vessel length: {gm['median']:.2f} mm")
print(f"SD: {gm['std']:.2f} mm")
print(f"Total length: {gm['total']:.2f} mm")



wm = calculate_average_length(wm_vessels)

print("\nWM vessels")
print(f"Number of segments: {wm['segments']}")
print(f"Mean vessel length: {wm['mean']:.2f} mm")
print(f"Median vessel length: {wm['median']:.2f} mm")
print(f"SD: {wm['std']:.2f} mm")
print(f"Total length: {wm['total']:.2f} mm")