FROM traefik:v2.4.5

RUN apk add bash

COPY service /service

ENTRYPOINT [ "/service" ]

CMD []
