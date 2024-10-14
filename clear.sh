docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q)
kill -9 $(lsof -t -i :7860)
kill -9 $(lsof -t -i :11343)

