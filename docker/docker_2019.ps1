

##############################################################################################
## SQL SERVER localhost
##############################################################################################

docker pull mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu

docker run `
--name DEVSQL19 `
-p 1433:1433 `
-e "ACCEPT_EULA=Y" `
-e "SA_PASSWORD=!QAZ2wsx" `
-v C:\temp\Docker\SQL:/sql `
-d mcr.microsoft.com/mssql/server:2019-CTP2.5-ubuntu

# cleanup 
# docker ps -aq
# docker rm $(docker ps -aq) #removes containers not images

docker ps -a #ps stands for Process Start and -a will you show you all processes regardless of status

docker start DEVSQL19

#docker stop DEVSQL19

docker logs 239d8e925e74