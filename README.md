# squid_docker
Squid Proxy with option CXXFLAGS="-DMAXTCPLISTENPORTS=20000"

This image is for get more than 128 (by default ) of tcp sessions for squid server. The main option is TCPLISTENPORTS.
This option is inside of file called "rule". It used in the source code building. 

How to use:

1. Install docker on your host machine. Use that https://docs.docker.com/engine/install/ubuntu/

2. Create a folder of your project.  
           
           sudo  mkdir -p /path/to/project/<project name>
           
3. Go to new folder <project name> and clone this repo
           
           gh repo clone storm66-ag/squid_docker

4. Now you can make a build of your owned docker image based on Dockerfile from repo  storm66-ag/squid_docker 
  
           docker build --no-cache  -t <your dockerhub name/repo name:tag> .

5. Check your new docker image:
          
           docker image ls

6. To run your a docker container based on your new docker image: 

           docker run -d --name <any container name> <name of your image from item 4> 

