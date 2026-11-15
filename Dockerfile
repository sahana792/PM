FROM tomcat:9.0-jdk11
WORKDIR /app
COPY . /app
# 1. Make folders
RUN mkdir -p /tmp/build/WEB-INF/classes
# 2. Compile all Java files manually with Tomcat + lib jars
RUN find src -name "*.java" > /tmp/sources.txt && javac -cp "/usr/local/tomcat/lib/*:lib/*:web/WEB-INF/lib/*" -d /tmp/build/WEB-INF/classes @/tmp/sources.txt
# 3. Copy web files (JSP, HTML, CSS) + libs to build folder
RUN cp -r web/* /tmp/build/ && mkdir -p /tmp/build/WEB-INF/lib && cp lib/* /tmp/build/WEB-INF/lib/ 2>/dev/null || true && cp web/WEB-INF/lib/* /tmp/build/WEB-INF/lib/ 2>/dev/null || true
# 4. Make ROOT.war and put in Tomcat
RUN cd /tmp/build && jar -cf /usr/local/tomcat/webapps/ROOT.war . && rm -rf /usr/local/tomcat/webapps/ROOT
EXPOSE 8080
CMD ["catalina.sh", "run"]
