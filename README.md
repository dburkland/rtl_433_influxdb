README
=========

### Introduction

After purchasing my first Raspberry Pi along with some other gear (including a RTL-SDR Radio Kit), I began looking for a Docker container that would run rtl_433 and stream the decoded data to a defined InfluxDB database. I found a few great examples however I ultimately decided to create my own container based on the excellent code and documentation shared by LinuxChristian [here](https://github.com/LinuxChristian/rtl_433-docker). While this container is designed for modern Raspberry Pi hardware it may work on other platforms with some minor modifications.

### Build (Optional)

* Clone all of the appropriate files from GitHub and change to the repo directory
  ```bash
  root@dbraspberrypi02:~# git clone https://github.com/dburkland/rtl_433_influxdb.git
  Cloning into 'rtl_433_influxdb'...
  remote: Enumerating objects: 6, done.
  remote: Counting objects: 100% (6/6), done.
  remote: Compressing objects: 100% (6/6), done.
  remote: Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
  Unpacking objects: 100% (6/6), done.

  root@dbraspberrypi02:~# cd rtl_433_influxdb
  ```

* Build the rtl_433_influxdb container image
  ```bash
  root@dbraspberrypi02:~/rtl_433_influxdb# docker build -t dburkland/rtl_433_influxdb .
  ````

* Verify the container image build completed successfully 
  ```bash
  root@dbraspberrypi02:~/rtl_433_influxdb# docker images
  REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
  dburkland/rtl_433_influxdb   latest              8bbc3ca0ad30        3 minutes ago       358MB
  ````

### Usage

* Find the bus address of the RTL-SDR USB dongle
  ```bash
  root@dbraspberrypi02:~# lsusb
  Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
  Bus 001 Device 003: ID 0bda:2838 Realtek Semiconductor Corp. RTL2838 DVB-T
  Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
  Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
  ```

* Replace the variable values mentioned below and start an instance of the container
  ```bash
  root@dbraspberrypi02:~# docker run -d --name rtl_433_influxdb --device=/dev/bus/usb/001/003 -e INFLUXDB_HOST="192.168.1.50" -e INFLUXDB_PORT="8086" -e INFLUXDB_DBNAME="DATABASE1" -e INFLUXDB_USERNAME="testuser" -e INFLUXDB_PASSWORD="PASSWORD123" --restart=always dburkland/rtl_433_influxdb:latest
  ```
