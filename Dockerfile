FROM openjdk:8-jdk-alpine
WORKDIR /opt/app
COPY target/aathir-demo-8496988.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
