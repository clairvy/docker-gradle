FROM java:8-jdk
MAINTAINER Nicholas Iaquinto <nickiaq@gmail.com>

# Gradle
ENV GRADLE_VERSION 2.10
ENV GRADLE_HASH 5b8ad24373252dabce9dead708e409f8

RUN cd /usr/lib \
 && wget https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
 && echo "${GRADLE_HASH} gradle-${GRADLE_VERSION}-bin.zip" | md5sum -c - \
 && unzip "gradle-${GRADLE_VERSION}-bin.zip" \
 && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
 && rm "gradle-${GRADLE_VERSION}-bin.zip"

RUN mkdir -p /usr/src/app

# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/src/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Caches
VOLUME /root/.gradle/caches

# Default command is "/usr/bin/gradle -version" on /usr/bin/app dir
# (ie. Mount project at /usr/bin/app "docker --rm -v /path/to/app:/usr/bin/app gradle <command>")
VOLUME /usr/bin/app
WORKDIR /usr/bin/app
ENTRYPOINT ["gradle"]
CMD ["-version"]
