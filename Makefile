gps-files:=$(shell find Sport-sessions/GPS-data/*.json)

all: setup

setup: clean dirs

test:
	head Sport-sessions/GPS-data/0562fe6b-084a-43e1-8b4b-50bf06a9141d.json | \
		sed 's/"latitude":[0-9.]*/"latitude":-1/g'| \
		sed 's/"longitude":[0-9.]*/"longitude":-1/g'


dirs:
	-@mkdir data
	-@mkdir data/masked-gps


data/masked-gps/%:
	cat Sport-sessions/GPS-data/$(@F) | \
		sed 's/"latitude":[0-9.]*/"latitude":-1/g'| \
		sed 's/"longitude":[0-9.]*/"longitude":-1/g' > data/masked-gps/$(@F)


clean:
	rm -rf data

mask: $(patsubst %,data/masked-gps/%,$(gps-files))
