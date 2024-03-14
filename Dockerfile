FROM eclipse-temurin:17-jdk-jammy as builder

WORKDIR /opt/app

# Copiar los archivos de configuración de Maven
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Cambiar permisos para mvnw
RUN chmod +x mvnw

# Descargar las dependencias de Maven
RUN ./mvnw.cmd dependency:go-offline

# Copiar el código fuente y compilar la aplicación
COPY ./src ./src
RUN ./mvnw clean install

# Cambiar a la imagen base de JRE
FROM eclipse-temurin:17-jre-jammy

WORKDIR /opt/app

# Exponer el puerto 8080
EXPOSE 9090

# Copiar el archivo JAR generado desde la etapa de compilación
COPY --from=builder /opt/app/target/*.jar /opt/app/app.jar

# Definir el comando de inicio de la aplicación
ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]
