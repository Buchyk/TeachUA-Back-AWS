FROM tomcat:jdk8
COPY target/TeachUA-1.0.war /usr/local/tomcat/webapps/dev.war
CMD catalina.sh run
