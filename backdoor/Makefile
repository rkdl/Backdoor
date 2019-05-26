AS=as
LD=ld
ASFLAGS=-O0 -s --64 --gdwarf-2
LDFLAGS=-static

SOURCES=$(wildcard *.s)
OBJECTS=$(SOURCES:.s=.o)
EXECUTABLE=build

.PHONY: all clean exec

all: 
	$(SOURCES) $(EXECUTABLE)

# Create executable
$(EXECUTABLE): $(OBJECTS) 
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@

# Compile
$(OBJECTS): $(SOURCES)
	$(AS) $(ASFLAGS) $(SOURCES) -o $@

clean: 
	rm -f $(OBJECTS) $(EXECUTABLE)

exec:
	chmod +x $(EXECUTABLE)
