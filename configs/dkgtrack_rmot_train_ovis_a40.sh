#!/bin/bash -l

#SBATCH --job-name=dkgtrack_ovis
#SBATCH --time=24:00:00
#SBATCH --gres=gpu:a40:4
#SBATCH --output=/home/atuin/v100dd/v100dd19/sbatch_dkgtrack/result-%x-%j.txt

PRETRAIN=/home/atuin/v100dd/v100dd19/TempRMOT/r50_deformable_detr_plus_iterative_bbox_refinement-checkpoint.pth
EXP_DIR=saved_models_rk/motion
OUT='/home/atuin/v100dd/v100dd19/dkgtrack/outputs'
TRAIN_LOG_FILE="$OUT/${EXP_DIR}/train_log.txt"
PID_FILE="$OUT/${EXP_DIR}/train_pid.txt"

mkdir -p "$OUT/${EXP_DIR}"

> $TRAIN_LOG_FILE  # clear the log file first
echo $$ > $PID_FILE

python3  -m torch.distributed.launch --nproc_per_node=4 --master_port 29505 \
   --use_env main.py \
   --meta_arch temp_rmot \
   --use_checkpoint \
   --dataset_file e2e_rmot \
   --epoch 100 \
   --with_box_refine \
   --lr_drop 40 \
   --lr 1e-4 \
   --lr_backbone 1e-5 \
   --pretrained ${PRETRAIN}\
   --output_dir $OUT/${EXP_DIR} \
   --save_dir $OUT/${EXP_DIR} \
   --batch_size 1 \
   --sample_mode random_interval \
   --sample_interval 1 \
   --sampler_steps 60 80 90 \
   --sampler_lengths 5 5 5 5 \
   --update_query_pos \
   --merger_dropout 0 \
   --dropout 0 \
   --random_drop 0.1 \
   --fp_ratio 0.3 \
   --query_interaction_layer QIM \
   --rmot_path /home/atuin/v100dd/v100dd19/TempRMOT/final_files/refer-ovis \
   --data_txt_path_train ./datasets/data_path/refer-ovis.train \
   --hist_len 5 \
   --refer_loss_coef 2 | tee -a ${TRAIN_LOG_FILE}


