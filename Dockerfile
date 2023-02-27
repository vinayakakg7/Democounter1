FROM maven as build
WORKDIR /app
copy . .
RUN mvn install


FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/Uber.jar /app/
CMD ["java" , "-jar" , "Uber.jar" ]