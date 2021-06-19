# basic-makefile
A high quality makefile template

```makefile
CXX := g++
CC := gcc

SRC_DIRECTORY = src
OBJ_DIRECTORY = obj
BIN_DIRECTORY = bin

CREATE_DIRS = mkdir -p $(@D)

CXXFLAGS := \
		-I $(SRC_DIRECTORY) \
		-std=c++17

LFLAGS :=

SOURCES := \
		$(wildcard $(SRC_DIRECTORY)/*.cpp) \
		$(wildcard $(SRC_DIRECTORY)/*/*.cpp)
HEADERS := \
		$(wildcard $(SRC_DIRECTORY)/*.h) \
		$(wildcard $(SRC_DIRECTORY)/*/*.h)

OBJECTS := $(SOURCES:$(SRC_DIRECTORY)/%.cpp=$(OBJ_DIRECTORY)/%.o)

all: $(BIN_DIRECTORY)/a.out

$(BIN_DIRECTORY)/a.out: $(OBJECTS)
	@$(CREATE_DIRS)
	@echo "linking"
	@$(CXX) $(OBJECTS) -o $@ $(LFLAGS)

$(OBJ_DIRECTORY)/%.o: $(SRC_DIRECTORY)/%.cpp $(HEADERS)
	@$(CREATE_DIRS)
	@echo "$@"
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

clean:
	@rm -rf $(OBJ_DIRECTORY)
	@rm -rf $(BIN_DIRECTORY)
```
