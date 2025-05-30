# 1. 빌드용 이미지
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# 2. 실행용 이미지
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/kotlin-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]