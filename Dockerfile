FROM alpine:3.8

ENV PIP_INSTALLER "https://bootstrap.pypa.io/get-pip.py"
ENV AWS_CLI_VERSION "1.16.142"

# Install dependent packages
RUN apk --update --no-cache add \
    python3 \
    curl \
    git

# Install awscli
RUN curl -s ${PIP_INSTALLER} | python3
RUN pip install --upgrade awscli==${AWS_CLI_VERSION}

# install kubectl
ENV KUBECTL_RELEASE_DATE "2019-06-11"
ENV KUBECTL_VERSION "1.13.7"

RUN curl -so /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${KUBECTL_RELEASE_DATE}/bin/linux/amd64/kubectl
RUN chmod +x /usr/local/bin/kubectl

# install kustomize
ENV KUSTOMIZE_VERSION "3.1.0"

RUN curl -so /usr/local/bin/kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64
RUN chmod +x /usr/local/bin/kustomize

# install AWS IAM Authenticator
ENV AWS_IAM_AUTHENTICATOR_RELEASE_DATE "2019-03-27"
ENV AWS_IAM_AUTHENTICATOR_VERSION "1.12.7"

RUN curl -so /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR_VERSION}/${AWS_IAM_AUTHENTICATOR_RELEASE_DATE}/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/local/bin/aws-iam-authenticator