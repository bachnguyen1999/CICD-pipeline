FROM tomcat:8
# Take the war and copy to webapps of tomcat
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/tomcat/webapps

COPY ./*.war /usr/local/tomcat/webapps/docker.war
#COPY target/*.war /usr/local/tomcat/webapps/docker.war
