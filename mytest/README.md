
基于openai baselines实验 

## 资源需求
+ 运行大约需要2G以上内存，1G显存，40G硬盘
+ DQN运行1e7步需要大约10个小时，测试时至少跑1e6步
+ PPO2运行1e7步需要大约2.5个小时
+ 随机性很强，多试不同seed，有的实验一直都不好, 从benchmarks_atari10M.htm也可以看出

## 训练中保存模型

save_path只在训练完了之后用于保存模型

训练过程保存模型需要：
+ deepq：设置参数--checkpoint_path，就会保存reward更高的模型 
+ ppo2: 设置参数--save_interval=20, 相当于1e5步保存一次模型 (TODO: reward增加才保存)

## 实验

将choose.list, batch_run.sh 拷贝到baselines目录
```
cp ../mytest/choose.list ../mytest/batch_run.sh .
sh batch_run.sh 
```
实验脚本: sh batch_run.sh (默认8张卡)

choose.list中7种游戏:
+ PongNoFrameskip-v4    乒乓球
+ SpaceInvadersNoFrameskip-v4
+ BreakoutNoFrameskip-v4
+ BeamRiderNoFrameskip-v4
+ SeaquestNoFrameskip-v4    飞机
+ QbertNoFrameskip-v4   台阶
+ EnduroNoFrameskip-v4  赛车

## 测试

训练好模型后测试:
```
cp mytest/play.sh .
sh play.sh
```

play.sh参数:
```
pong	PongNoFrameskip-v4
spaceinvader	SpaceInvadersNoFrameskip-v4
breakout	BreakoutNoFrameskip-v4
beamrider	BeamRiderNoFrameskip-v4
seaquest	SeaquestNoFrameskip-v4
qbert	QbertNoFrameskip-v4
enduro	EnduroNoFrameskip-v4
```

## 其他说明

1) baselines.run命令参数不全，更多的参数可以看每个算法函数learn()的参数

2) --network 参数可以指定网络结构，Atari游戏一般采用的默认的cnn网络

3) MuJoCo游戏的网络结构采用为mlp
```
python -m baselines.run --alg=ppo2 --env=Humanoid-v2 --network=mlp --num_timesteps=2e7
```
4) 运行前设置环境变量OPENAI_LOG_FORMAT

OPENAI_LOG_FORMAT environment variables are stdout, log, csv, and tensorboard (multiple values can be comma-separated).

5) 结果目录可以通过`tensorboard --logdir=.`查看训练曲线

