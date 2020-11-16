FROM debian
COPY scripts /scripts
RUN chmod u+x /scripts/*.sh
CMD ["/scripts/run.sh"]