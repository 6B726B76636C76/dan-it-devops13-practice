FROM fluent/fluentd:v1.16-1

USER root
RUN gem install elasticsearch -v 7.17.10 --no-document && \
    gem install fluent-plugin-elasticsearch --no-document
USER fluent