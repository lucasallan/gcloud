FROM ubuntu:16.10
MAINTAINER Lucas Amorim <lucasamorim@protonmail.com>

# install dev toolsA
RUN apt-get update
RUN apt-get install -y python openjdk-8-jre wget unzip

# install gcloud
ENV PATH /opt/google-cloud-sdk/bin:$PATH
RUN mkdir -p /opt/gcloud && \
    wget --no-check-certificate --directory-prefix=/tmp/ https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && \
    unzip /tmp/google-cloud-sdk.zip -d /opt/ && \
    /opt/google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/opt/gcloud/.bashrc --disable-installation-options && \
    gcloud --quiet components update app preview alpha beta app-engine-java app-engine-python kubectl bq core gsutil gcloud && \
    rm -rf /tmp/*

COPY imagescripts/docker-entrypoint.sh /opt/gcloud/docker-entrypoint.sh
ENTRYPOINT ["/opt/gcloud/docker-entrypoint.sh"]
CMD ["cron"]
