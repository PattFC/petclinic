# Etapa base: prepara el entorno de compilación
FROM eclipse-temurin:21-jdk-jammy AS base
WORKDIR /app

# Copia Maven wrapper y configura permisos
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw && ./mvnw dependency:resolve

# Copia el código fuente
COPY src ./src

# Instala el agente OpenTelemetry
ARG OTEL_AGENT_VERSION=1.32.0
RUN curl -L https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_AGENT_VERSION}/opentelemetry-javaagent.jar \
    -o /opt/opentelemetry-javaagent.jar

# Etapa de desarrollo
FROM base AS development
ENV JAVA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
ENV JAVA_TOOL_OPTIONS="-javaagent:/opt/opentelemetry-javaagent.jar"
CMD ["./mvnw", "spring-boot:run", "-Dspring-boot.run.profiles=mysql"]

# Etapa de compilación
FROM base AS build
RUN ./mvnw package

# Etapa final de producción
FROM eclipse-temurin:21-jre-jammy AS production
EXPOSE 8080

# Copia el agente OpenTelemetry
COPY --from=base /opt/opentelemetry-javaagent.jar /opt/opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:/opt/opentelemetry-javaagent.jar"

# Copia el JAR de la app
COPY --from=build /app/target/spring-petclinic-*.jar /spring-petclinic.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]
