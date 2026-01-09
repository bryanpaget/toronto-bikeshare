# Makefile for Toronto Bike Share Analytics Development

.PHONY: help setup activate deactivate install-spacy update-spacy test clean

# Default target
help:
	@echo "Toronto Bike Share Analytics Development Environment"
	@echo ""
	@echo "Usage:"
	@echo "  make setup          - Create virtual environment and install dependencies"
	@echo "  make activate       - Activate the virtual environment"
	@echo "  make deactivate     - Deactivate the virtual environment"
	@echo "  make install-spacy  - Install spaCy model"
	@echo "  make update-spacy   - Update spaCy and install model"
	@echo "  make test           - Run the analytics script"
	@echo "  make clean          - Remove virtual environment"

# Create virtual environment and install dependencies
setup:
	python3 -m venv venv
	./venv/bin/pip install --upgrade pip
	./venv/bin/pip install -r requirements.txt
	@echo "Virtual environment created and dependencies installed."
	@echo "Run 'make install-spacy' to install the spaCy language model."

# Activate virtual environment
activate:
	@echo "To activate the virtual environment, run:"
	@echo "source venv/bin/activate"

# Deactivate virtual environment (this is handled by the shell, not make)
deactivate:
	@echo "To deactivate the virtual environment, run:"
	@echo "deactivate"

# Install spaCy English model
install-spacy:
	./venv/bin/python -m spacy download en_core_web_sm
	@echo "spaCy English model installed."

# Update spaCy and install model
update-spacy:
	./venv/bin/pip install --upgrade spacy
	./venv/bin/python -m spacy download en_core_web_sm
	@echo "spaCy updated and English model installed."

# Run the analytics script
test:
	@echo "Running Toronto Bike Share Analytics..."
	Rscript update_report.R

# Clean up virtual environment
clean:
	rm -rf venv
	@echo "Virtual environment removed."