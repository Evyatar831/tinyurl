FROM eclipse-temurin:17-jdk-alpine
COPY target/tinyurl-0.0.1-SNAPSHOT.jar tinyurl.jar
ENTRYPOINT ["java", "-jar", "/tinyurl.jar"]
