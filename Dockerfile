FROM maven:3-jdk-10
COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven/iptest
RUN mvn clean install


FROM openjdk:10-jdk
ADD https://raw.githubusercontent.com/eficode/wait-for/master/wait-for /bin/wait-for
RUN chmod a+rx /bin/wait-for

WORKDIR /usr/src/myapp
COPY --from=0 /usr/src/mymaven/iptest/target/iptest-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/src/myapp/iptest.jar
CMD [ "/bin/wait-for", "ip:80", "--", "java", "-cp", "/usr/src/myapp/iptest.jar", "us.toger.App"]
