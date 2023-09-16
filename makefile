rwildcard = $(foreach dir, $(wildcard $(1:=/*)), $(call rwildcard, $(dir), $2) $(filter $(subst *, %, $2), $(dir)))

CXX := g++
CC := gcc

SRC_DIRECTORY = src
OBJ_DIRECTORY = obj
BIN_DIRECTORY = bin

CREATE_DIRS = mkdir -p $(@D)

INC_DIRECTORIES := \
		$(SRC_DIRECTORY)

CXXFLAGS := \
		$(foreach inc_dir, $(INC_DIRECTORIES), -I $(inc_dir)) \
		-std=c++17

LFLAGS :=

SOURCES := \
		$(call rwildcard, $(SRC_DIRECTORY), *.cpp)

OBJECTS := $(SOURCES:$(SRC_DIRECTORY)/%.cpp=$(OBJ_DIRECTORY)/%.o)

EXECUTABLE := $(BIN_DIRECTORY)/a.out

all: $(EXECUTABLE)

-include $(call rwildcard, $(OBJ_DIRECTORY), *.d)

$(EXECUTABLE): $(OBJECTS)
	@$(CREATE_DIRS)
	@echo "linking $@"
	@$(CXX) $(OBJECTS) -o $@ $(LFLAGS)

$(OBJ_DIRECTORY)/%.o: $(SRC_DIRECTORY)/%.cpp
	@$(CREATE_DIRS)
	@echo "compile $@"
	@$(CXX) -c $< -o $@ $(CXXFLAGS) -MP -MD

clean:
	@rm -rf $(OBJ_DIRECTORY)
	@rm -rf $(BIN_DIRECTORY)
