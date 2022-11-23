#!/bin/bash
sudo apt update
sudo apt install -y pdsh
sudo apt install -y openjdk-8-jre-headless

wget https://dlcdn.apache.org/hadoop/common/current/hadoop-3.3.4.tar.gz
tar xvf hadoop-3.3.4.tar.gz
wget https://tumult-public.s3.amazonaws.com/library-members.csv
export PDSH_RCMD_TYPE=ssh
sed -i "55i\export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" hadoop-3.3.4/etc/hadoop/hadoop-env.sh
sed -i "19a\<property><name>fs.defaultFS</name><value>hdfs://0.0.0.0:9000</value></property>" hadoop-3.3.4/etc/hadoop/core-site.xml
sed -i "20i\<property><name>dfs.replication</name><value>1</value></property>" hadoop-3.3.4/etc/hadoop/hdfs-site.xml 
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

cd hadoop-3.3.4
bin/hdfs namenode -format
sbin/start-dfs.sh
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/cthorens
bin/hdfs dfs -put ../library-members.csv /user/cthorens
