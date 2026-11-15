FROM tomcat:9.0-jdk11

# Install Ant to build NetBeans project
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Build WAR using NetBeans build.xml
RUN ant war

# Deploy WAR as ROOT so site opens at / not /PM
RUN cp dist/*.war /usr/local/tomcat/webapps/ROOT.war && rm -rf /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
