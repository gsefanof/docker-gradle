FROM gradle:latest
MAINTAINER gsefanof@gmail.com

ENV JDK_URL http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz

ENV JDK_HOME /usr/java/jdk
ENV JAVA_HOME /usr/java/jre

USER root

RUN mkdir -p ${JDK_HOME} && ln -s ${JDK_HOME}/jre $JAVA_HOME && \
        curl --silent --location --retry 3 --cacert /etc/ssl/certs/GeoTrust_Global_CA.pem \
  	  --header "Cookie: oraclelicense=accept-securebackup-cookie;" "$JDK_URL" \
	  | tar -xz --strip-components=1 -C ${JDK_HOME} 

RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
	update-alternatives --set java "${JAVA_HOME}/bin/java" && \
	update-alternatives --set javaws "${JAVA_HOME}/bin/javaws"

USER gradle
