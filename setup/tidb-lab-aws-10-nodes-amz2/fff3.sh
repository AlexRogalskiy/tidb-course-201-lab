#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./destroy-all.sh
./01-precheck-and-fix-nodes.sh
~/.tiup/bin/tiup cluster deploy tidb-test 6.5.0 ./solution-topology-ten-nodes-fff3.yaml --yes
~/.tiup/bin/tiup cluster start tidb-test

sleep 5;

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
DROP DATABASE IF EXISTS tidb;
CREATE DATABASE tidb;
USE tidb;
CREATE TABLE `tab_tidb` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL DEFAULT '',
`age` INT(11) NOT NULL DEFAULT 0,
`version` VARCHAR(20) NOT NULL DEFAULT '',
PRIMARY KEY (`id`),
KEY `idx_age` (`age`));
INSERT INTO `tab_tidb` VALUES (1,'TiDB',6,'TiDB-v6.1.0');
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
CREATE TABLE t1 (a INT PRIMARY KEY AUTO_INCREMENT);
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
SET auto_increment_increment = 10;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
SET GLOBAL auto_increment_increment=10;
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
EOFX

