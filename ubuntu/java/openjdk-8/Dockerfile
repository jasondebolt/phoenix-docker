FROM 714284646049.dkr.ecr.us-east-1.amazonaws.com/ubuntu:14.04

ENV JAVA_VERSION=8 \
    JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64" \
    JDK_HOME="/usr/lib/jvm/java-8-openjdk-amd64" \
    JRE_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre" \
    ANT_VERSION=1.9.6 \
    MAVEN_VERSION=3.3.3 \
    MAVEN_HOME="/usr/share/maven" \
    MAVEN_CONFIG="/root/.m2" \
    GRADLE_VERSION=2.7 \
    PROPERTIES_COMMON_VERSIION=0.92.37.8 \
    PYTHON_TOOL_VERSION="3.3-*"
# Install Java
RUN apt-get update \
    && apt-get install -y software-properties-common=$PROPERTIES_COMMON_VERSIION \
    && add-apt-repository ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get -y install python-setuptools=$PYTHON_TOOL_VERSION \
    && apt-get -y install openjdk-$JAVA_VERSION-jdk \
    && apt-get clean \
    # Ensure Java cacerts symlink points to valid location
    && update-ca-certificates -f \
    && mkdir -p /usr/src/ant \
    && wget "http://archive.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz" -O /usr/src/ant/apache-ant-$ANT_VERSION-bin.tar.gz \
    && tar -xzf /usr/src/ant/apache-ant-$ANT_VERSION-bin.tar.gz -C /usr/local \
    && ln -s /usr/local/apache-ant-$ANT_VERSION/bin/ant /usr/bin/ant \
    && rm -rf /usr/src/ant \
    && mkdir -p /usr/share/maven /usr/share/maven/ref $MAVEN_CONFIG \
    && curl -fsSL "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" \
        | tar -xzC /usr/share/maven --strip-components=1 \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
    && mkdir -p /usr/src/gradle \
    && wget "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -O /usr/src/gradle/gradle-$GRADLE_VERSION-bin.zip \
    && unzip /usr/src/gradle/gradle-$GRADLE_VERSION-bin.zip -d /usr/local \
    && ln -s /usr/local/gradle-$GRADLE_VERSION/bin/gradle /usr/bin/gradle \
    && rm -rf /usr/src/gradle \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY m2-settings.xml $MAVEN_CONFIG/settings.xml
