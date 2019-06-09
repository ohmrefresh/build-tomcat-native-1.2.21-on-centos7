FROM centos7

#======= Install utility for compile package 
RUN yum install -y wget tar unzip bind sudo gcc make tar

#== Download tomcat-native-1.2.21-src
RUN cd /tmp && wget https://www-us.apache.org/dist/tomcat/tomcat-connectors/native/1.2.21/source/tomcat-native-1.2.21-src.tar.gz && tar -zxvf tomcat-native-1.2.21-src.tar.gz

#======== Install openjdk-devel-1.8.0.212 for OpenJDK Development Environment =========
# java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6 for OpenJDK Runtime Environment
RUN yum install -y java-1.8.0-openjdk-devel-1.8.0.212.b04-0.el7_6

RUN yum install apr-devel openssl-devel -y

RUN cd /tmp/tomcat-native-1.2.21-src/native && mkdir ../output

RUN cd /tmp/tomcat-native-1.2.21-src/native && ./configure --with-apr=/usr/bin/apr-1-config \
            --with-java-home=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64 \
            --with-ssl=yes \
            --prefix=/tmp/tomcat-native-1.2.21-src/output && make && make install
