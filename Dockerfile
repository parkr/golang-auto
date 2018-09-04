#
FROM golang:1

ADD docker-entrypoint.sh /bin/docker-entrypoint.sh

ENTRYPOINT [ "/bin/docker-entrypoint.sh" ]
