# we will use openjdk 8 with alpine as it is a very small linux distro
FROM openjdk:8-jre-alpine3.9

# copy the packaged jar file into our docker image
COPY countries-assembly-1.0.1.jar /countries-assembly-1.0.1.jar
EXPOSE 8080
# set the startup command to execute the jar
CMD ["java", "-jar", "/countries-assembly-1.0.1.jar"]
