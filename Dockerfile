# Pull in Docker hub on Redhat 9 image download
FROM redhat/ubi9:latest

# Creater name
MAINTAINER "gauravkhandate@gmail.com"

# Update lib and apllication upgrade
RUN yum update -y && yum install fontconfig java-17-openjdk -y

# create folder create
RUN mkdir -p /opt/download/extract/tomcat
WORKDIR /opt/download

# Download minimal file of maven and java
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.88/bin/apache-tomcat-9.0.88.tar.gz .
RUN tar -zxf apache-tomcat-9.0.88.tar.gz
RUN mv -f apache-tomcat-9.0.88/* /opt/download/extract/tomcat

# Copy the war file on tomcat directory
COPY target/admission_form.war /opt/download/extract/tomcat/webapps

# port export
EXPOSE 8080/tcp

# To Start the tomcat server
CMD ["/opt/download/extract/tomcat/bin/catalina.sh", "run"]
