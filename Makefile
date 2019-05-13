AS=as
LD=ld
ASFLAGS=-Os -s --64
LDFLAGS=-static -s

SOURCES=$(wildcard *.s)
OBJECTS=$(SOURCES:.s=.o)
EXECUTABLE=build

.PHONY: all clean

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
