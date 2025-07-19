CONFIG=mitsusplit.yaml
INCLUDES=secrets.yaml $(wildcard common/*.yaml)
# Used for uploading images, if connected, otherwise prompt during upload
SERIAL_DEV=/dev/ttyACM0
SERIAL_ARG=$(if $(wildcard SERIAL_DEV), --device $(SERIAL_DEV))

.PHONY: all
all: run

.PHONY: run
run: $(CONFIG) $(INCLUDES)
	esphome run $(SERIAL_ARG) $(CONFIG)

.PHONY: upload
upload: $(CONFIG) $(INCLUDES)
	esphome upload $(SERIAL_ARG) $(CONFIG)

.PHONY: compile
compile: $(CONFIG) $(INCLUDES)
	esphome compile $(CONFIG)

.PHONY: config
config: $(CONFIG) $(INCLUDES)
	esphome config $(CONFIG)
