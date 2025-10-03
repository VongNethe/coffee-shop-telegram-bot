# ==========================
# Stage 1: Build the Spring Boot JAR
# ==========================
FROM eclipse-temurin:24-jdk AS build
WORKDIR /app

# Copy all project files
COPY . .

# Make Gradle wrapper executable
RUN chmod +x ./gradlew

# Build the Spring Boot JAR, skip tests
RUN ./gradlew clean bootJar -x test

# ==========================
# Stage 2: Run the Spring Boot JAR
# ==========================
FROM eclipse-temurin:24-jdk
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port (Render/Railway will override)
EXPOSE 8080

# Run the app
ENTRYPOINT ["java","-jar","app.jar"]
