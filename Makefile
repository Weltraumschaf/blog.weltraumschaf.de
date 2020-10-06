# Disable built-in rules and variables because we do not need them.
# - https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html#Catalogue-of-Rules
# - https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html#Implicit-Variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

PROJECT_DIR		= $(shell pwd)
WORKFILES_DIR	= $(PROJECT_DIR)/workfiles
STATIC_DIR		= $(PROJECT_DIR)/static

all: build

.PHONY:
build: generate-pumls ## Make all the things

.PHONY:
generate-pumls: ## Generate the PlantUML images
	plantuml -tpng -o $(STATIC_DIR)/img/blog $(WORKFILES_DIR)/blog/**/*.puml

.PHONY:
help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'