KEY_FILE_PREFIX:=image_sign
KEY_FILE_PRIVATE:=$(KEY_FILE_PREFIX).pem
KEY_FILE_PUBLIC:=$(KEY_FILE_PREFIX)_pub.der
KEY_FILE_PUBLIC_IMPORT:=libs/ec256/src/$(KEY_FILE_PREFIX)_pub.c.import

.PHONY: all build clean clean_all

all: install build

install:
	newt install

load: build
	newt load nrf52_boot
	newt load nrf52_blinky

build: $(KEY_FILE_PUBLIC_IMPORT)
	newt build nrf52_boot
	newt build nrf52_blinky
	newt create-image nrf52_blinky 1.0.0

$(KEY_FILE_PUBLIC_IMPORT): $(KEY_FILE_PUBLIC)
	xxd -i $^ $@

$(KEY_FILE_PRIVATE):
	openssl ecparam -name prime256v1 -genkey -noout -out $@

$(KEY_FILE_PUBLIC): $(KEY_FILE_PRIVATE)
	openssl ec -in $^ -pubout -outform DER -out $@

clean:
	rm -rf bin

clean_all: clean
	rm -rf repos
	rm -f $(KEY_FILE_PRIVATE) $(KEY_FILE_PUBLIC)
