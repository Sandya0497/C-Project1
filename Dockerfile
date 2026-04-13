# Build stage: use Maven with JDK
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app
# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY C-Project1/src ./src

# Build the application
RUN mvn package -DskipTests

# Runtime stage: lightweight JRE
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/target/myapp-1.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
