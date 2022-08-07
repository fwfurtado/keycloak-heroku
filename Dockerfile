FROM quay.io/keycloak/keycloak:19.0

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres
# Install custom providers
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
RUN /opt/keycloak/bin/kc.sh build

WORKDIR /opt/keycloak

ENTRYPOINT /opt/keycloak/bin/kc.sh start --http-port=$PORT --proxy=edge --hostname-strict=false --hostname-strict-https=false --db postgres --db-url $KC_DB_URL --db-username $KC_DB_USER --db-password $KC_DB_PASSWORD --health-enabled=true --metrics-enabled=true