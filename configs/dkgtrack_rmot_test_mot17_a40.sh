# ------------------------------------------------------------------------
# Copyright (c) 2021 megvii-model. All Rights Reserved.
# ------------------------------------------------------------------------
# Modified from Deformable DETR (https://github.com/fundamentalvision/Deformable-DETR)
# Copyright (c) 2020 SenseTime. All Rights Reserved.
# ------------------------------------------------------------------------

#!/bin/bash -l

#SBATCH --job-name=dkgtrack_mot17_test
#SBATCH --time=24:00:00
#SBATCH --gres=gpu:a40:1
#SBATCH --output=/home/atuin/v100dd/v100dd19/sbatch_dkgtrack/result-%x-%j.txt

export CUDA_VISIBLE_DEVICES='1,2,3'
python3 inference.py \
--meta_arch temp_rmot \
--dataset_file e2e_rmot \
--epoch 200 \
--with_box_refine \
--lr_drop 100 \
--lr 2e-4 \
--lr_backbone 2e-5 \
--batch_size 1 \
--sample_mode random_interval \
--sample_interval 1 \
--sampler_steps 50 90 150 \
--sampler_lengths 2 3 4 5 \
--update_query_pos \
--merger_dropout 0 \
--dropout 0 \
--random_drop 0.1 \
--fp_ratio 0.3 \
--query_interaction_layer QIM \
--extra_track_attn \
--hist_len 8 \
--rmot_path /home/atuin/v100dd/v100dd19/TempRMOT/final_files/refer-mot17 \
--resume /home/atuin/v100dd/v100dd19/dkgtrack/outputs/mot17_a40/checkpoint0099.pth \
--output_dir /home/atuin/v100dd/v100dd19/dkgtrack/outputs/mot17_a40

