FROM python:3-alpine
COPY requirements.txt .

ENV TERRAFORM_VERSION=0.12.20
ENV TERRAFORM_ZIP=terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ENV TERRAFORM_SUM=46bd906f8cb9bbb871905ecb23ae7344af8017d214d735fbb6d6c8e0feb20ff3

RUN apk add -U ca-certificates curl && \
    cd /tmp && \
    curl -fsSLO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP} && \
    echo "${TERRAFORM_SUM}  /tmp/${TERRAFORM_ZIP}" | sha256sum -c - && \
    unzip /tmp/${TERRAFORM_ZIP} -d /usr/bin && \
    rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

RUN pip install --no-cache-dir -r requirements.txt
ADD infra /infra
