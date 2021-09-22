FROM gcr.io/kaniko-project/executor:v1.6.0
FROM alpine

COPY --from=0 /kaniko/executor /kaniko/executor
COPY --from=0 /kaniko/docker-credential-gcr /kaniko/docker-credential-gcr
COPY --from=0 /kaniko/docker-credential-ecr-login /kaniko/docker-credential-ecr-login
COPY --from=0 /kaniko/docker-credential-acr /kaniko/docker-credential-acr
COPY --from=0 /kaniko/ssl/certs/ /kaniko/ssl/certs/
COPY --from=0 /kaniko/.docker /kaniko/.docker

ENV HOME /root
ENV USER root
ENV PATH /usr/local/bin:/kaniko
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json

RUN ["docker-credential-gcr", "config", "--token-source=env"]

ENTRYPOINT ["/kaniko/executor"]
