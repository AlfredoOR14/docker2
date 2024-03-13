# Utiliza una imagen base de AdoptOpenJDK con la versión 17
FROM openjdk:17-jdk

# Establece el directorio de trabajo en /opt/app
WORKDIR /opt/app

# Copia los archivos necesarios para la instalación de dependencias
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Descarga las dependencias de Maven utilizando el Wrapper Maven
RUN ./mvnw dependency:go-offline

# Copia el resto de la aplicación
COPY ./src ./src

# Compila la aplicación
RUN ./mvnw clean install

# Expone el puerto 8080 (ajusta según sea necesario)
EXPOSE 8080

# Comando para ejecutar la aplicación cuando se inicie el contenedor
CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]