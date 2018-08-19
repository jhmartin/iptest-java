FROM maven:3-jdk-10
COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven/iptest
RUN mvn clean install

#
#docker run -ti --rm -v ~/.m2:/root/.m2 -w /usr/src/mymaven -v `pwd`/iptest:/usr/src/mymaven maven:3-jdk-10 mvn clean install
#docker build . -t jhmartin/iptest_java
#docker push  jhmartin/iptest_java


FROM openjdk:10-jdk

WORKDIR /usr/src/myapp
COPY --from=0 /usr/src/mymaven/iptest/target/iptest-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/src/myapp/iptest.jar
CMD ["java", "-cp", "/usr/src/myapp/iptest.jar", "us.toger.App"]
