

(base) anuschkabergmann@145 ~ % cd Desktop
(base) anuschkabergmann@145 Desktop % cd Neurosynth 
(base) anuschkabergmann@145 Neurosynth % ls
brain.nii			Manual Segmentation 		stat_afni+tlrc.BRIK.gz		stat.nii			vessels.nii
clusters_table.txt		mask.nii			stat_afni+tlrc.HEAD		vessel_pipeline.py		z_corr-FDR_method-indep.nii
figures 			NSC_Results			stat_thr.nii			vessels_clean.nii


(base) anuschkabergmann@145 Neurosynth % 3dcopy stat.nii stat_afni
++ 3dcopy: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]

(base) anuschkabergmann@145 Neurosynth % 3dinfo -min stat.nii
0
(base) anuschkabergmann@145 Neurosynth % 3dinfo -max stat.nii
11

(base) anuschkabergmann@145 Neurosynth % 3dcalc \
  -a stat.nii \
  -expr 'step(a-1.67)' \
  -prefix stat_thr.nii
++ 3dcalc: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]
++ Authored by: A cast of thousands
++ Output dataset ./stat_thr.nii

(base) anuschkabergmann@145 Neurosynth % 3dinfo -min stat_thr.nii
0

(base) anuschkabergmann@145 Neurosynth % 3dinfo -max stat_thr.nii
1

(base) anuschkabergmann@145 Neurosynth % 3dBrickStat -count -non-zero stat_thr.nii
104753       


(base) anuschkabergmann@145 Neurosynth % 3dcalc \
  -a stat.nii \
  -expr 'step(a-1.67)' \
  -prefix mask_167.nii
++ 3dcalc: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]
++ Authored by: A cast of thousands
++ Output dataset ./mask_167.nii


(base) anuschkabergmann@145 Neurosynth % 3dcalc -a stat.nii -expr 'step(a-1.67)' -prefix mask_167.nii
++ 3dcalc: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]
++ Authored by: A cast of thousands
++ Output dataset ./mask_167.nii
(base) anuschkabergmann@145 Neurosynth % 3dclust \
  -1dindex 0 \
  -savemask clusters_thr.nii \
  20 1.01 mask_167.nii
++ 3dclust: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]
++ Authored by: RW Cox et alii
++ *** Consider using program 3dClusterize instead of 3dclust ***
#
#Cluster report for file mask_167.nii 
#[Connectivity radius = 20.00 mm  Volume threshold = 8.00 ]
#[Single voxel volume = 8.0 (microliters) ]
#[Voxel datum type    = float ]
#[Voxel dimensions    = 2.000 mm X 2.000 mm X 2.000 mm ]
#[Coordinates Order   = RAI ]
#Mean and SEM based on Absolute Value of voxel intensities: 
#
#Volume  CM RL  CM AP  CM IS  minRL  maxRL  minAP  maxAP  minIS  maxIS    Mean     SEM    Max Int  MI RL  MI AP  MI IS
#------  -----  -----  -----  -----  -----  -----  -----  -----  -----  -------  -------  -------  -----  -----  -----
++ Output dataset ./clusters_thr.nii
 838024   -1.5   16.9   17.5  -72.0   68.0  -70.0  106.0  -56.0   78.0        1        0        1  -22.0   76.0  -56.0 



(base) anuschkabergmann@145 Neurosynth % 3dcalc -a stat.nii -expr 'step(a-3.5)' -prefix mask_35.nii
++ 3dcalc: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]
++ Authored by: A cast of thousands
++ Output dataset ./mask_35.nii
(base) anuschkabergmann@145 Neurosynth % 3dclust -1dindex 0 20 1.01 mask_35.nii
++ 3dclust: AFNI version=AFNI_26.1.04 (Jun  7 2026) [64-bit]
++ Authored by: RW Cox et alii
++ *** Consider using program 3dClusterize instead of 3dclust ***
#
#Cluster report for file mask_35.nii 
#[Connectivity radius = 20.00 mm  Volume threshold = 8.00 ]
#[Single voxel volume = 8.0 (microliters) ]
#[Voxel datum type    = float ]
#[Voxel dimensions    = 2.000 mm X 2.000 mm X 2.000 mm ]
#[Coordinates Order   = RAI ]
#Mean and SEM based on Absolute Value of voxel intensities: 
#
#Volume  CM RL  CM AP  CM IS  minRL  maxRL  minAP  maxAP  minIS  maxIS    Mean     SEM    Max Int  MI RL  MI AP  MI IS
#------  -----  -----  -----  -----  -----  -----  -----  -----  -----  -------  -------  -------  -----  -----  -----
 204176   -0.8   20.5   21.7  -68.0   62.0  -66.0  104.0  -44.0   70.0        1        0        1   48.0   -6.0  -44.0 
(base) anuschkabergmann@145 Neurosynth % 

 


