FROM eclipse-temurin:25-jdk AS builder

WORKDIR /app

COPY back/.mvn .mvn
COPY back/mvnw .
COPY back/pom.xml .
COPY back/src ./src

RUN chmod +x mvnw && ./mvnw clean package -DskipTests

FROM eclipse-temurin:25-jre

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]