tag=$1
game=$2

alg=deepq
out_dir=`pwd`/train_dqn
save_path=$out_dir/$tag/model/model
step=0
set -x
python3 -m baselines.run --alg=${alg} --env=${game} --num_timesteps=${step} --load_path=$save_path --num_env=1 --play
