# basic-makefile
A decent quality makefile template

```makefile
CXX := g++
CC := gcc

SRC_DIRECTORY = src
OBJ_DIRECTORY = obj
BIN_DIRECTORY = bin

CREATE_DIRS = mkdir -p $(@D)

INC_DIRECTORIES := \
		$(SRC_DIRECTORY)

CXXFLAGS := \
		$(foreach inc_dir,$(INC_DIRECTORIES),-I $(inc_dir)) \
		-std=c++17

LFLAGS :=

SOURCES := \
		$(wildcard $(SRC_DIRECTORY)/*.cpp) \
		$(wildcard $(SRC_DIRECTORY)/*/*.cpp)
HEADERS := \
		$(wildcard $(SRC_DIRECTORY)/*.h) \
		$(wildcard $(SRC_DIRECTORY)/*/*.h)

OBJECTS := $(SOURCES:$(SRC_DIRECTORY)/%.cpp=$(OBJ_DIRECTORY)/%.o)

EXECUTABLE := $(BIN_DIRECTORY)/a.out

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	@$(CREATE_DIRS)
	@echo "linking $@"
	@$(CXX) $(OBJECTS) -o $@ $(LFLAGS)

$(OBJ_DIRECTORY)/%.o: $(SRC_DIRECTORY)/%.cpp $(HEADERS)
	@$(CREATE_DIRS)
	@echo "compile $@"
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

clean:
	@rm -rf $(OBJ_DIRECTORY)
	@rm -rf $(BIN_DIRECTORY)
```

To prevent total recompilation, it is suggested that larger projects with a lot of header files use the `get_headers.sh` script. Just replace `$(HEADERS)` with  **`$(shell ./get_headers.sh $(SRC_DIRECTORY)/*.cpp $(INC_DIRECTORIES))`** in your recipe dependency list.
