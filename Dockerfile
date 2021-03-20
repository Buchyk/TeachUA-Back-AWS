FROM tomcat:jdk8
COPY target/TeachUA-1.0.war /usr/local/tomcat/webapps/
CMD catalina.sh run
