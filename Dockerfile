FROM openjdk:8

ADD target/apolis-demo.jar apolis-demo.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","apolis-demo.jar"]
