# Stage 1: Build the JAR
FROM eclipse-temurin:24-jdk AS build
WORKDIR /app
COPY . .

# Make gradlew executable
RUN chmod +x ./gradlew

# Build the Spring Boot JAR
RUN ./gradlew clean bootJar -x test

# Stage 2: Run the JAR
FROM eclipse-temurin:24-jdk
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
