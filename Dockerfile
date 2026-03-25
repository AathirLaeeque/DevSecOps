FROM openjdk:11
WORKDIR /opt/app
COPY target/aathir-demo-849698.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
