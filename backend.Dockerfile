# -------- Stage 1: Build --------
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY pom.xml .

# Install Maven inside container
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

COPY src ./src

RUN mvn clean package -DskipTests

# -------- Stage 2: Runtime --------
FROM eclipse-temurin:21-jre AS runtime

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]