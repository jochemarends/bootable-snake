SOURCE_DIR := src
OUTPUT_DIR := bin
TARGET := $(OUTPUT_DIR)/snake.bin

ASM := nasm
ASM_ARGS := -i inc/ -f elf32
ASM_FILES := $(wildcard $(SOURCE_DIR)/*.asm)
OBJ_FILES := $(patsubst $(SOURCE_DIR)/%.asm, $(OUTPUT_DIR)/%.o, $(ASM_FILES))

LD := ld
LD_FILE := $(SOURCE_DIR)/linker.ld
LD_ARGS := -m elf_i386 -T$(LD_FILE) -o $(TARGET) $(OBJ_FILES)

QEMU := qemu-system-x86_64
QEMU_ARGS := -drive format=raw,file=$(TARGET)

$(TARGET): $(OBJ_FILES)
	@$(LD) $(LD_ARGS)

$(OUTPUT_DIR)/%.o: $(SOURCE_DIR)/%.asm
	@mkdir -p $(OUTPUT_DIR)
	@$(ASM) $(ASM_ARGS) -o $@ $< 

.PHONY: run
run: $(TARGET)
	@$(QEMU) $(QEMU_ARGS)

.PHONY: clean
clean:
	@rm -rf $(OUTPUT_DIR)
