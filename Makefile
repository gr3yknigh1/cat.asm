

SRCTREE := $(CURDIR)

CAT_BIN := $(SRCTREE)/cat
CAT_OBJ := $(SRCTREE)/cat.o
CAT_SRC := $(SRCTREE)/cat.asm


ASM      := nasm
ASMFLAGS := -f elf64

LD       := ld
LDFLAGS  :=



default: all


all: $(CAT_BIN)


$(CAT_BIN): $(CAT_OBJ)
	$(LD) $(LDFLAGS) $^ -o $@


$(CAT_OBJ): $(CAT_SRC)
	$(ASM) $(ASMFLAGS) $^ -o $@


clean:
	rm -rf $(CAT_OBJ) $(CAT_BIN)


.PHONY: default all clean
