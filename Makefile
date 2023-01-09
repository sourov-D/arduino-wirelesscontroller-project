#    Copyright 2023 Sourov Sharma
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
# -------------------------------------------------------------------------------

CC=avr-gcc
BIN=controller
HEX=controller.hex
MCU=atmega328p
CONF=/etc/avrdude.conf
PROGRAMER=arduino
BAUD=115200
PORT=/dev/ttyUSB0
SRC=*.c
OBJ=*.o

all: $(HEX)
	rm -rf *.o

$(HEX): $(BIN)
	avr-objcopy -O ihex bin/$(BIN) $(HEX)

$(BIN):$(OBJ)
	avr-gcc -mmcu=atmega328p -O2 $(OBJ) -o bin/$(BIN)

$(OBJ):
	avr-gcc -mmcu=atmega328p -O2 -c src/$(SRC)

upload:
	avrdude -C $(CONF) -v -p $(MCU) -c $(PROGRAMER) -b $(BAUD) -P $(PORT) -U flash:w:$(HEX)
