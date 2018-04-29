ARG CHANNEL=beta
ARG TINI_ARCH=armhf
ARG ARCH=arm32v7

FROM duplicati/duplicati:${CHANNEL} AS duplicati

RUN curl -L -o /tmp/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH} && \
    chmod 0755 /tmp/tini

FROM ${ARCH}/mono:5

COPY --from=duplicati /tmp/tini /usr/sbin/tini
ENTRYPOINT ["/usr/sbin/tini", "--"]

ENV XDG_CONFIG_HOME=/data
VOLUME /data

COPY --from=duplicati /usr/bin/duplicati-cli /usr/bin/duplicati-server /usr/bin/
COPY --from=duplicati /opt/duplicati /opt/duplicati

EXPOSE 8200
CMD ["/usr/bin/duplicati-server", "--webservice-port=8200", "--webservice-interface=any"]
