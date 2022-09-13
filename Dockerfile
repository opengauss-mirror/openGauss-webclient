FROM openeuler/openeuler:22.03-lts
LABEL maintainer="Nelson-He <heguofeng@openeuler.com>"
ENV OPENGAUSS_WEBCLIENT_VERSION 1.0.4

RUN \
  yum -y update && \
  yum -y install sudo util-linux lsof wget unzip && \
  yum -y install opengauss && \
  su - opengauss -c "gsql -d postgres -U opengauss -p 7654 -c 'alter user opengauss password \"opengauss_2022\"'" && \
  su - opengauss -c "gs_ctl stop -D /var/lib/opengauss/data -mf " && \
  cd /tmp && \
  wget -q https://gitee.com/opengauss/openGauss-webclient/releases/download/v$OPENGAUSS_WEBCLIENT_VERSION-master/openGauss-webclient_linux_amd64.zip && \
  unzip openGauss-webclient_linux_amd64.zip -d /usr/bin && \
  mv /usr/bin/openGauss-webclient_linux_amd64 /usr/bin/openGauss_webclient && \
  chmod 755 /usr/bin/openGauss_webclient && \
  rm -f openGauss-webclient_linux_amd64.zip && \
  yum clean all 

COPY --chown=opengauss:opengauss ./entrypoint.sh /var/lib/opengauss/entrypoint.sh
USER opengauss:opengauss

ENTRYPOINT ["/bin/bash", "/var/lib/opengauss/entrypoint.sh"]

EXPOSE 8081

CMD ["openGauss_webclient"]
