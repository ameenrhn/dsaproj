# Compiler
CXX = g++

# Compiler Flags
CXXFLAGS = -std=c++11 -Wall -Wextra

# OpenSSL Paths (via Homebrew)
OPENSSL_PATH = /opt/homebrew/opt/openssl@3
INCLUDES = -Isrc/ -I$(OPENSSL_PATH)/include
LIBS = -L$(OPENSSL_PATH)/lib -lssl -lcrypto

# Source and Object Directories
SRC_DIR = src
OBJ_DIR = obj

# Source and Object Files
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS = $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SOURCES))

# Executable
EXEC = blockchain_app

# Default Target
all: $(EXEC)

# Link all object files into final executable
$(EXEC): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

# Compile .cpp to .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c -o $@ $<

# Ensure obj/ directory exists
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Clean build files
clean:
	rm -rf $(OBJ_DIR) $(EXEC) merkle_demo

# Extra Target: merkle_demo
merkle_demo: $(OBJ_DIR)/MerkleTree.o $(SRC_DIR)/merkle_demo.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o merkle_demo $(SRC_DIR)/merkle_demo.cpp $(OBJ_DIR)/MerkleTree.o $(LIBS)

.PHONY: all clean merkle_demo
