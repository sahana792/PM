FROM tomcat:9.0-jdk11
WORKDIR /app
COPY . /app
# 1. Download MySQL Connector (because lib/ is empty on GitHub)
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/* && wget -O /tmp/mysql.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar
# 2. Make folders
RUN mkdir -p /tmp/build/WEB-INF/classes /tmp/build/WEB-INF/lib
# 3. Compile with Tomcat + MySQL jar
RUN find src -name "*.java" > /tmp/sources.txt && javac -cp "/usr/local/tomcat/lib/*:/tmp/mysql.jar:lib/*:web/WEB-INF/lib/*" -d /tmp/build/WEB-INF/classes @/tmp/sources.txt
# 4. Copy web files + MySQL jar to WAR
RUN cp -r web/* /tmp/build/ && cp /tmp/mysql.jar /tmp/build/WEB-INF/lib/ && cp lib/* /tmp/build/WEB-INF/lib/ 2>/dev/null || true && cp web/WEB-INF/lib/* /tmp/build/WEB-INF/lib/ 2>/dev/null || true
# 5. Make ROOT.war
RUN cd /tmp/build && jar -cf /usr/local/tomcat/webapps/ROOT.war . && rm -rf /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]
