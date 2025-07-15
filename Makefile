CONFIG=mitsusplit.yaml
INCLUDES=secrets.yaml $(wildcard common/*.yaml)
# Used for uploading images, if connected, otherwise prompt during upload
SERIAL_DEV=/dev/ttyACM0
SERIAL_ARG=$(if $(wildcard SERIAL_DEV), --device $(SERIAL_DEV))

.PHONY: all
all: upload

.PHONY: upload
upload: $(CONFIG) $(INCLUDES) | compile
	esphome upload $(SERIAL_ARG) $(CONFIG)

.PHONY: compile
compile: $(CONFIG) $(INCLUDES)
	esphome compile $(CONFIG)

.PHONY: config
config: $(CONFIG) $(INCLUDES)
	esphome config $(CONFIG)
