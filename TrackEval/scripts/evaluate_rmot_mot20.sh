#!/bin/bash -l

#SBATCH --job-name=dkgtrack_mot20_eval
#SBATCH --time=24:00:00
#SBATCH --gres=gpu:a40:1
#SBATCH --output=/home/atuin/v100dd/v100dd19/sbatch_dkgtrack/result-%x-%j.txt

#python3 run_mot_challenge.py \
###
 # @Author: hcxpami 503429928@qq.com
 # @Date: 2024-11-06 09:55:45
 # @LastEditors: hcxpami 503429928@qq.com
 # @LastEditTime: 2024-11-09 11:54:31
 # @FilePath: /TempRMOT_original/TrackEval/scripts/evaluate_rmot.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 
#--METRICS HOTA \
#--SEQMAP_FILE /data/wudongming/MOTR/seqmap_rmot_clean.txt \
#--SKIP_SPLIT_FOL True \
#--GT_FOLDER /data/Dataset/MOT17/images/train \
#--TRACKERS_FOLDER /data/wudongming/MOTR/exps/rmot_v2a/results_epoch249_ \
#--GT_LOC_FORMAT {gt_folder}{video_id}/{expression_id}/gt.txt \
#--TRACKERS_TO_EVAL /data/wudongming/MOTR/exps/rmot_v2a/results_epoch249_ \
#--USE_PARALLEL True \
#--NUM_PARALLEL_CORES 2 \
#--SKIP_SPLIT_FOL True \
#--PLOT_CURVES False
# export CUDA_VISIBLE_DEVICES='4,5,6'

python3 run_mot_challenge.py \
--METRICS HOTA \
--SEQMAP_FILE /home/hpc/v100dd/v100dd19/projects/DKGTrack_fork/datasets/data_path/seqmap_mot20.txt \
--SKIP_SPLIT_FOL True \
--GT_FOLDER /home/atuin/v100dd/v100dd19/TempRMOT/final_files/refer-mot20/MOT20/valid \
--TRACKERS_FOLDER /home/atuin/v100dd/v100dd19/dkgtrack/outputs/mot20_a40/results_epoch99 \
--GT_LOC_FORMAT {gt_folder}{video_id}/{expression_id}/gt.txt \
--TRACKERS_TO_EVAL /home/atuin/v100dd/v100dd19/dkgtrack/outputs/mot20_a40/results_epoch99 \
--USE_PARALLEL True \
--NUM_PARALLEL_CORES 2 \
--SKIP_SPLIT_FOL True \
--PLOT_CURVES False

#python3 run_mot_challenge.py \
#--METRICS HOTA \
#--SEQMAP_FILE /data/wudongming/MOTR/seqmap_kitti_clean.txt \
#--SKIP_SPLIT_FOL True \
#--GT_FOLDER /data/Dataset/KITTI/training/image_02 \
#--TRACKERS_FOLDER /data/wudongming/FairMOT/exp/fairmot_kitti_2/result_epoch100 \
#--GT_LOC_FORMAT {gt_folder}{video_id}/{expression_id}/gt.txt \
#--TRACKERS_TO_EVAL /data/wudongming/FairMOT/exp/fairmot_kitti_2/result_epoch100 \
#--USE_PARALLEL True \
#--NUM_PARALLEL_CORES 2 \
#--SKIP_SPLIT_FOL True \
#--PLOT_CURVES False
