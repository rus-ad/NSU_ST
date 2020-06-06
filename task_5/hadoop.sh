# docker run --hostname=quickstart.cloudera --privileged=true -t -i -p 8888 -v /home/lapltop/tasks/NSU_ST/task_5/:/root/hometask/ cloudera/quickstart:latest /usr/bin/docker-quickstart

hadoop fs -mkdir /user/root/MR_task/data
hadoop fs -copyFromLocal /root/hometask/dst-stu/d/mr/tf-idf/ /user/root/MR_task/data
cp -R /root/hometask /home/cloudera/
chown -R cloudera:cloudera /home/cloudera/hometask/

hadoop jar /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.6.0-mr1-cdh5.7.0.jar \
-D mapred.reduce.tasks=1 \
-input /user/root/MR_task/data/tf-idf/ \
-output /user/root/MR_task/data/out \
-mapper /home/cloudera/hometask/mapper.py \
-reducer /home/cloudera/hometask/reducer.py

hadoop fs -text /user/root/MR_task/data/out/part*
