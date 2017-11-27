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
RUN apt-get install libreadline-dev libncurses5-dev libssl1.0.0 tk8.5-dev zlib1g-dev liblzma-dev

#Install python3
WORKDIR /usr/local/
RUN wget http://www.python.org/ftp/python/3.3.5/Python-3.3.5.tar.xz
RUN tar xJf ./Python-3.3.5.tar.xz
WORKDIR Python-3.3.5/
RUN ./configure --prefix=/opt/python3.3
RUN make
RUN make install

#Fem un simbolic link per cridar python3
RUN ln -s /opt/python3.3/bin/python3.3 python

# Cleanup 
RUN rm -rf /usr/local/Python-3.3.5.tar.xz

#Instal·lem cutadapt amb pip3
RUN apt-get install python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install cutadapt

#Set wokingDir in /
WORKDIR /

