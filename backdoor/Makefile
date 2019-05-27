AS=as
LD=ld

DEBUG ?= 1
ifeq ($(DEBUG), 1)
    ASFLAGS=-O0 -s --64 --gdwarf-2
	LDFLAGS=-static
else
    ASFLAGS=-Os -s --64
	LDFLAGS=-static --strip-all
endif

SOURCES=$(wildcard *.s)
OBJECTS=$(SOURCES:.s=.o)
EXECUTABLE=Backdoor

.PHONY: all clean exec

all: $(SOURCES) $(EXECUTABLE)

.s.o:
	$(AS) $(ASFLAGS) $< -o $@

$(EXECUTABLE): $(OBJECTS) 
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@

clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

exec:
	chmod +x $(EXECUTABLE)
