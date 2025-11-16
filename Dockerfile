# 1단계: Maven으로 빌드
FROM maven:3.8-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# 2단계: Tomcat에 배포
FROM tomcat:9.0
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]