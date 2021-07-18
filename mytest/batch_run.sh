
step=1e7
#out_dir=`pwd`/train_deepq
#alg=deepq

out_dir=`pwd`/train_ppo
alg=ppo2

#export OPENAI_LOG_FORMAT=stdout,log,csv,tensorboard
export OPENAI_LOG_FORMAT=stdout,log,tensorboard

awk -F'\t' '{print NR,$1,$2}' choose.list |while read i tag game
do

echo $i,$tag,$game
export CUDA_VISIBLE_DEVICES=$i
log_dir=$out_dir/$tag/log
save_path=$out_dir/$tag/model
mkdir -p $log_dir
stdout_file=run_${alg}_${tag}.log

if [ $alg == "deepq" ];then
    python3 -m baselines.run --alg=${alg} --env=${game} --num_timesteps=${step} --log_path $log_dir --save_path $save_path --checkpoint_path=$log_dir > $stdout_file 2>&1&
else #ppo2
    python3 -m baselines.run --alg=${alg} --env=${game} --num_timesteps=${step} --log_path $log_dir --save_path $save_path --save_interval=20 > $stdout_file 2>&1&
fi

done
