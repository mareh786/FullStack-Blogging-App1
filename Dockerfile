# FROM eclipse-temurin:17-jdk-alpine
    
# EXPOSE 8080
 
# ENV APP_HOME /usr/src/app

# COPY target/*.jar $APP_HOME/app.jar

# WORKDIR $APP_HOME

# CMD ["java", "-jar", "app.jar"]


# -------- Stage 1: Build the app --------
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /build

# Copy pom.xml and download dependencies first (for layer caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the JAR
RUN mvn clean package -DskipTests

# -------- Stage 2: Create runtime image --------
FROM eclipse-temurin:17-jdk-alpine

ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME

# Copy the built JAR from the build stage
COPY --from=build /build/target/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
