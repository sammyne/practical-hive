#!/bin/bash

name=hive4

case "$1" in
  beeline)
     docker exec -it $name beeline -u 'jdbc:hive2://localhost:10000/'
  ;;

  down)
    docker stop $name
  ;;

  up)
    version=4.0.1
    docker run -d --rm -p 10000:10000 -p 10002:10002 --env SERVICE_NAME=hiveserver2 --name $name apache/hive:$version
  ;;

  *)
    echo "未知命令 '$1' :("
    exit 1
  ;;
esac

