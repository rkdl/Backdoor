AS=as
LD=ld
ASFLAGS=-O0 -s --64 --gdwarf-2
LDFLAGS=-static

EXECUTABLE=Backdoor

.PHONY: all clean exec

all: 
	backdoor

backdoor:
	$(AS) $(ASFLAGS) backdoor.s -o backdoor.o
	$(LD) $(LDFLAGS) backdoor.o -o $(EXECUTABLE)

clean: 
	rm -f *.o $(EXECUTABLE)

exec:
	chmod +x $(EXECUTABLE)
