##############################################################################################
## make a shared drive for the docker
##############################################################################################
docker run --rm -v C:\temp\Docker\SQLdrive:/data alpine ls /data
docker ps -a

##############################################################################################
## SQL SERVER localhost
##############################################################################################
docker pull mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

docker run `
--name DEVSQL19 `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=!QAZ2wsx" `
-v C:\temp\Docker\SQL:/sql `
-d mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

# cleanup containers processes
# docker ps -aq
# docker rm $(docker ps -aq) #removes containers not images

# Cleanup images
# docker images
# docker rmi $(docker images -aq)
# docker rmi  b7b28af77ffe  

#running processes
# docker ps -a #ps stands for Process Start and -a will you show you all processes regardless of status

docker start DEVSQL19

#docker stop DEVSQL19

docker ps -a
docker logs 239d8e925e74

