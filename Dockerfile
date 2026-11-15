FROM tomcat:9.0-jdk11
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . /app
RUN ant clean dist
RUN cp dist/*.war /usr/local/tomcat/webapps/ROOT.war && rm -rf /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]
