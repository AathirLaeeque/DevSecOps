FROM openjdk:11
WORKDIR /opt/app
COPY target/aathir-demo-8496988.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
