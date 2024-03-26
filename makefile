# Name of output file
APP_NAME := app.out
LIB_NAME := lib.a

OUTPUT_DIR = run/

# Collection of files for the program to compile
TARGET_DIR := source/
SRC_FILES := $(wildcard $(TARGET_DIR)*.c)
LIB_FILES := source/main.c

# Here goes every automatic variable for extra compile flags
main_FLAGS = -Wunused

# The libraries to be included (Use this is extra compile flags)
INCLUDE_LIBS = -L.


# C version used
TARGET_VERSION = -std=c2x

# General compile flags (used for every file)
COMPILE_FLAGS = -Wall -Wextra -Wpedantic


# Runs each changed file separately and then links them together
.PHONY: all
all: src

.PHONY: src
src: $(SRC_FILES:%.c=%.o)
	clang -o $(OUTPUT_DIR)$(APP_NAME) $(TARGET_VERSION) $(COMPILE_FLAGS) $^

# This command is invoked for each target found in 'src'
$(TARGET_DIR)%.o: $(TARGET_DIR)%.c
	clang -c -o $@ $(TARGET_VERSION) $(COMPILE_FLAGS) $^ $($*_FLAGS)

# Use 'make debug' for debug flag to be added
.PHONY: debug
debug: clean all
debug: COMPILE_FLAGS += -g

# Use 'make lib' for updated selected files to be made into a .a file
.PHONY: lib
lib: $(LIB_FILES:%.c=%.o)
	ar r $(LIB_NAME) $?

.PHONY: run
run:
	@echo "======== ======== App Running ======== ========"
	@./$(OUTPUT_DIR)$(APP_NAME)
	@echo "======== ========   App End   ======== ========"

.PHONY: clean cleanCore cleanLib
clean: cleanCore cleanLib
	-@rm $(OUTPUT_DIR)$(APP_NAME) 2>/dev/null || true
cleanCore:
	-@rm $(TARGET_DIR)*.o 2>/dev/null || true
cleanLib:
	-@rm $(LIB_NAME) 2>/dev/null || true
