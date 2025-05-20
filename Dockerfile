FROM eclipse-temurin:17-jdk-alpine
    
EXPOSE 8080
 
ENV APP_HOME /usr/src/app

COPY /home/runner/work/FullStack-Blogging-App1/FullStack-Blogging-App1/target/twitter-app-0.0.3.jar.original

WORKDIR $APP_HOME

CMD ["java", "-jar", "app.jar"]
