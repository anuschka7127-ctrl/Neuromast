#############################################
# NEUROSYNTH / META-ANALYTIC PIPELINE
# Clean AFNI + MNI + Atlas Labeling Workflow
#############################################

# ----------------------------
# 1. Go to project folder
# ----------------------------
cd ~/Desktop/Neurosynth

# ----------------------------
# 2. Ensure clean dataset
# ----------------------------
3dcopy stat.nii stat_clean.nii

# (optional but fine for AFNI compatibility)
3drefit -space MNI stat_clean.nii

# ----------------------------
# 3. CLUSTERING
# IMPORTANT:
# Your map is an intensity map (0–11 range)
# NOT a true Z/T statistical dataset
# So we use intensity thresholding
# ----------------------------
3dClusterize \
  -inset stat_clean.nii \
  -NN 2 \
  -clust_nvox 10 \
  -bisided 1.67 11 \
  > cluster_output.txt

# ----------------------------
# 4. EXTRACT MNI PEAK TABLE
# ----------------------------
python3 - << 'EOF'
import csv

input_file = "cluster_output.txt"
output_file = "MNI_peak_table.csv"

rows = []

with open(input_file, "r") as f:
    for line in f:
        parts = line.strip().split()
        if len(parts) < 6:
            continue

        try:
            cluster_size = float(parts[0])
            x = float(parts[3])
            y = float(parts[4])
            z = float(parts[5])
        except:
            continue

        rows.append([cluster_size, x, y, z])

rows.sort(key=lambda x: x[0], reverse=True)

with open(output_file, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Cluster_Size", "MNI_X", "MNI_Y", "MNI_Z"])
    writer.writerows(rows)

print("Saved:", output_file)
EOF

# ----------------------------
# 5. BRAIN REGION LABELING
# (Harvard-Oxford Atlas via FSL)
# ----------------------------
python3 - << 'EOF'
import csv
import subprocess

input_file = "MNI_peak_table.csv"
output_file = "MNI_peak_table_labeled.csv"

def get_region(x, y, z):
    cmd = f'atlasquery -a "Harvard-Oxford Cortical Structural Atlas" -c {x},{y},{z}'
    try:
        out = subprocess.check_output(cmd, shell=True).decode("utf-8").strip()
        return out if out else "Unknown"
    except:
        return "Unknown"

rows = []

with open(input_file, "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        region = get_region(row["MNI_X"], row["MNI_Y"], row["MNI_Z"])

        rows.append([
            row["Cluster_Size"],
            row["MNI_X"],
            row["MNI_Y"],
            row["MNI_Z"],
            region
        ])

with open(output_file, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Cluster_Size", "MNI_X", "MNI_Y", "MNI_Z", "Brain_Region"])
    writer.writerows(rows)

print("Saved:", output_file)
EOF

# ----------------------------
# OUTPUT FILES
# ----------------------------
# cluster_output.txt
# MNI_peak_table.csv
# MNI_peak_table_labeled.csv
#############################################