# Usa una imagen base con OpenJDK 17 para Windows
FROM openjdk:17

# Establece el directorio de trabajo en la imagen
WORKDIR /opt/app

# Copia los archivos de Maven
COPY .mvn/ .mvn

# Copia el script Maven Wrapper y el archivo de proyecto
COPY mvnw pom.xml ./

# Ejecuta el script Maven Wrapper para descargar las dependencias
RUN powershell -Command ./mvnw dependency:go-offline

# Copia el resto de la aplicación
COPY src ./src

# Compila la aplicación
RUN powershell -Command ./mvnw package -DskipTests

# Expone el puerto 8080 en la imagen
EXPOSE 8080

# Comando para ejecutar la aplicación cuando se inicia el contenedor
CMD ["java", "-jar", "target/demo.jar"]
