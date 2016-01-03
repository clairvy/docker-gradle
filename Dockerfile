FROM java:8-jdk
MAINTAINER Nicholas Iaquinto <nickiaq@gmail.com>

# Gradle
ENV GRADLE_VERSION 2.7
ENV GRADLE_HASH fe801ce2166e6c5b48b3e7ba81277c41
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
