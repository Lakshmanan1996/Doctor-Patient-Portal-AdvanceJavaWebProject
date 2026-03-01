# -------- Build Stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY Doctor-Patient-Portal/pom.xml .
RUN mvn dependency:go-offline

COPY Doctor-Patient-Portal/src ./src
RUN mvn clean package -DskipTests

# -------- Runtime Stage --------
FROM tomcat:9.0-jdk17

WORKDIR /usr/local/tomcat/webapps/

COPY --from=build /app/target/*.war ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
