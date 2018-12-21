all: setup

setup: dirs

MASKED_GPS_DIR:=data/masked-gps

dirs:
	-@mkdir data
	-@mkdir data/masked-gps
	-@mkdir data/runsessions


data/runsessions/%:
	cat Sport-sessions/$(@F) | \
		sed 's/"latitude":[0-9.]*/"latitude":-1/g'| \
		sed 's/"longitude":[0-9.]*/"longitude":-1/g' > data/runsessions/$(@F)


data/masked-gps/%:
	cat Sport-sessions/GPS-data/$(@F) | \
		sed 's/"latitude":[0-9.]*/"latitude":-1/g'| \
		sed 's/"longitude":[0-9.]*/"longitude":-1/g' > data/masked-gps/$(@F)


clean:
	rm -rf data


gps-target:=$(shell find Sport-sessions/GPS-data/*.json)
gps-data: $(patsubst %,data/masked-gps/%,$(gps-target))

runsessions-target:=$(shell find Sport-sessions/*.json)
runsessions-data: $(patsubst %,data/runsessions/%,$(runsessions-target))

all-data: gps-data runsessions-data


.PHONY: all clean setup gps-data runsessions-data all-data
