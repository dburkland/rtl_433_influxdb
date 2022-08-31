FROM --platform=linux/arm64/v8 debian:latest
LABEL Dan Burkland <dburkland@dburkland.com>
WORKDIR /tmp/

ENV INFLUXDB_HOST="localhost" \
    INFLUXDB_PORT="8086" \
    INFLUXDB_DBNAME="blah_db_name" \
    INFLUXDB_USERNAME="blah_user" \
    INFLUXDB_PASSWORD="blah_password"

RUN apt-get update
RUN apt-get install -y git libtool libusb-1.0.0-dev librtlsdr-dev rtl-sdr cmake automake
RUN git clone https://github.com/merbanan/rtl_433.git

COPY build.sh .
COPY run.sh /run.sh

# Build rtl_433
RUN ./build.sh

CMD [ "/run.sh" ]
