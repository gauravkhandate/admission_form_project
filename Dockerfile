# Pull in Docker hub on ubuntu image download
FROM redhat/ubi9:latest

# Creater name 
MAINTAINER "gauravkhandate@gmail.com"

# Update lib and apllication uprade 
RUN yum update -y && yum upgrade -y && yum install vim -y
RUN yum install openssh-server -y && yum install fontconfig java-17-openjdk -y

# create folder create 
RUN mkdir -p /opt/download
RUN mkdir -p /opt/download/extract
RUN mkdir -p /opt/download/extract/java
RUN mkdir -p /opt/download/extract/maven
RUN mkdir -p /opt/download/extract/tomcat
WORKDIR /opt/download

# Download minimal file of maven and java
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.88/bin/apache-tomcat-9.0.88.tar.gz .
ADD https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz .
RUN tar -zxf apache-tomcat-9.0.88.tar.gz
RUN tar -zxf apache-maven-3.9.4-bin.tar.gz
RUN mv -f apache-tomcat-9.0.88/* /opt/download/extract/tomcat
RUN mv -f apache-maven-3.9.4/* /opt/download/extract/maven
COPY target/adminssion_form.war /opt/download/extract/tomcat/webapps

# user add & maven,java configuration of bashrc entry
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-17.0.8.0.7-2.el9.x86_64
ENV M2_HOME=/opt/download/extract/maven
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# To Start the tomcat server 
RUN ./opt/download/extract/tomcat/bin/startup.sh

