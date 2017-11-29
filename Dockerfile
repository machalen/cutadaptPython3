#########################################################
# Dockerfile to build Cutadapt container Based on Ubuntu
# Python-3.3.5 to use multicore
#########################################################

#Set the image based on Ubuntu
FROM ubuntu:14.04

#File Author/Maintainer
MAINTAINER Magdalena Arnal, marnal@imim.es

#Update the repository sources list and install essential libraries
RUN apt-get update && apt-get install --yes build-essential python3-dev
RUN apt-get update && apt-get install --yes wget libsqlite3-dev sqlite3 bzip2 libbz2-dev pigz
RUN apt-get install g++ zlib1g-dev ncurses-dev liblzma-dev libncurses5-dev default-jre default-jdk

#Install python 3.3.5
WORKDIR /usr/local/
RUN wget http://www.python.org/ftp/python/3.3.5/Python-3.3.5.tar.xz
RUN tar xJf ./Python-3.3.5.tar.xz
WORKDIR Python-3.3.5/
RUN ./configure --prefix=/opt/python3.3
RUN make
RUN make install

#Symbolic link to call python3
RUN ln -s /opt/python3.3/bin/python3.3 pythonv3

# Cleanup 
RUN rm -rf /usr/local/Python-3.3.5.tar.xz

#Instal·lem cutadapt with pip3
RUN apt-get install python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install cutadapt

#Set wokingDir in /
WORKDIR /

