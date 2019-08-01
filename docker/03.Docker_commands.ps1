##############################################################################################
## see what docker version you have... you can pick windows or linux
## why wouldn't you use linux?
##############################################################################################
docker --version # Build and Version
docker version # Build, Version, OS/Arch, Experimental Build, GitCommit

##############################################################################################
## see what docker images "Pulled"
##############################################################################################
docker images

##############################################################################################
## pull an image (this can be done before time or if you have a network)
##############################################################################################
docker pull mcr.microsoft.com/mssql/server:2017-latest
docker pull mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu

##############################################################################################
## remove an image (you will have to re-pull it)
##############################################################################################
docker rmi <image ID> # docker images #copy the image ID 
# docker rmi $(docker images) removes every image

##############################################################################################
## list of active containers
##############################################################################################
docker ps -a # ps stands for Process Started -a is for all (active or not) will give you the port

##############################################################################################
## start and stop container 
##############################################################################################
docker start <docker container id> or <docker container name> #run docker ps -a
# docker rm $(docker ps -aq) #removes all containers not images
docker start $(docker ps -aq -f status=exited) # -aq returns the container  id
docker stop $(docker ps -aq -f status=running) # -aq returns the container  id

##############################################################################################
## remove all not-running containers
## this needs to be done before you can remove the image
##############################################################################################
docker rm <container ID> or <container name> # remove one container
docker rm $(docker ps -aq -f status=exited) # remove all not running containers
docker rm $(docker ps -aq) # removes all containers (regardless of status)
 