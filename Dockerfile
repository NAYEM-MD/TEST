# Use a multi-stage build to keep the final image clean
# Stage 1: Build the Java code
FROM openjdk:17-jdk-slim AS build
WORKDIR /app

# Copy the source code and libraries
COPY . .

# Create the output directory
RUN mkdir -p WEB-INF/classes

# Compile the Java source code
# Note: We include both H2 and MySQL drivers in the classpath
RUN javac -d WEB-INF/classes -cp "WEB-INF/lib/*" $(find src -name "*.java")

# Stage 2: Create the runtime Tomcat image
FROM tomcat:10.1-jdk17

# Remove the default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Create the ROOT directory
RUN mkdir -p /usr/local/tomcat/webapps/ROOT

# Copy compiled classes
COPY --from=build /app/WEB-INF/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Copy libraries
COPY --from=build /app/WEB-INF/lib /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

# Copy Views and Web Content
# Note: Adjusting path based on project structure where views are in WEB-INF/views
COPY --from=build /app/WEB-INF/views /usr/local/tomcat/webapps/ROOT/WEB-INF/views
COPY --from=build /app/assets /usr/local/tomcat/webapps/ROOT/assets
COPY --from=build /app/index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp
# Also copy docs just in case
COPY --from=build /app/docs /usr/local/tomcat/webapps/ROOT/docs

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
