FROM openjdk:8
COPY target/mon-projet-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]