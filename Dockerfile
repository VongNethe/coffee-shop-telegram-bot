# Stage 1: Build your JAR
FROM eclipse-temurin:24-jdk AS build
WORKDIR /app

# Copy all project files
COPY . .

# Build the Spring Boot JAR
RUN ./gradlew clean bootJar -x test

# Stage 2: Run your app
FROM eclipse-temurin:24-jdk
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose the default Spring Boot port (will use Render's PORT variable)
EXPOSE 8080

# Start the app
ENTRYPOINT ["java","-jar","app.jar"]
