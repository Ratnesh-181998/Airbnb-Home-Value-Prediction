# Airbnb Home Value Prediction - ML System Design
# Makefile for easy project management

.PHONY: help install clean run-demo open-docs open-demo test lint format

# Default target
help:
	@echo "=========================================="
	@echo "🏠 Airbnb ML System - Available Commands"
	@echo "=========================================="
	@echo ""
	@echo "📚 Documentation & Demos:"
	@echo "  make open-docs       - Open main documentation website"
	@echo "  make open-demo       - Open interactive prediction demo"
	@echo "  make open-all        - Open both documentation and demo"
	@echo ""
	@echo "🐍 Python Setup & Execution:"
	@echo "  make install         - Install Python dependencies"
	@echo "  make run-demo        - Run Python ML demo (simple version)"
	@echo "  make run-full        - Run full ML system (requires XGBoost)"
	@echo ""
	@echo "🧪 Development:"
	@echo "  make test            - Run tests (if available)"
	@echo "  make lint            - Check code quality"
	@echo "  make format          - Format Python code"
	@echo "  make clean           - Remove temporary files"
	@echo ""
	@echo "📊 Project Info:"
	@echo "  make info            - Display project information"
	@echo "  make tree            - Show project structure"
	@echo ""
	@echo "=========================================="

# Open documentation website in browser
open-docs:
	@echo "🌐 Opening main documentation website..."
	@start index.html

# Open interactive demo in browser
open-demo:
	@echo "🎮 Opening interactive prediction demo..."
	@start use_case_demo.html

# Open both documentation and demo
open-all: open-docs open-demo
	@echo "✅ Opened both documentation and demo!"

# Install Python dependencies
install:
	@echo "📦 Installing Python dependencies..."
	pip install numpy pandas scikit-learn matplotlib seaborn
	@echo "⚠️  Note: XGBoost and SHAP require compatible numpy version"
	@echo "   If you need XGBoost, run: pip install xgboost shap"
	@echo "✅ Basic dependencies installed!"

# Install all dependencies including XGBoost
install-full:
	@echo "📦 Installing all dependencies including XGBoost..."
	pip install numpy pandas scikit-learn xgboost shap matplotlib seaborn
	@echo "✅ All dependencies installed!"

# Run the simplified Python demo
run-demo:
	@echo "🚀 Running simplified ML demo..."
	@echo "=========================================="
	python airbnb_ml_demo_simple.py

# Run the full ML system
run-full:
	@echo "🚀 Running full ML system with XGBoost..."
	@echo "=========================================="
	python airbnb_ml_system.py

# Display project information
info:
	@echo "=========================================="
	@echo "📊 Project Information"
	@echo "=========================================="
	@echo ""
	@echo "Project: Airbnb Home Value Prediction"
	@echo "Type: End-to-End ML System Design"
	@echo "Status: Complete ✅"
	@echo ""
	@echo "📁 Key Files:"
	@echo "  - index.html              Main documentation"
	@echo "  - use_case_demo.html      Interactive demo"
	@echo "  - airbnb_ml_system.py     Full Python implementation"
	@echo "  - README.md               Comprehensive guide"
	@echo ""
	@echo "🎯 Features:"
	@echo "  - Real-time predictions"
	@echo "  - SHAP explainability"
	@echo "  - Interactive web UI"
	@echo "  - Complete ML pipeline"
	@echo ""
	@echo "=========================================="

# Show project structure
tree:
	@echo "📁 Project Structure:"
	@echo ""
	@dir /B
	@echo ""
	@echo "Total files: "
	@dir /B | find /c /v ""

# Clean temporary files
clean:
	@echo "🧹 Cleaning temporary files..."
	@if exist __pycache__ rmdir /s /q __pycache__
	@if exist *.pyc del /q *.pyc
	@if exist .pytest_cache rmdir /s /q .pytest_cache
	@if exist .coverage del /q .coverage
	@echo "✅ Cleanup complete!"

# Run tests (placeholder)
test:
	@echo "🧪 Running tests..."
	@echo "⚠️  No tests configured yet"
	@echo "   To add tests, create a tests/ directory with pytest"

# Lint Python code
lint:
	@echo "🔍 Checking code quality..."
	@echo "⚠️  Linting not configured"
	@echo "   To enable, install: pip install flake8 pylint"
	@echo "   Then run: flake8 *.py"

# Format Python code
format:
	@echo "✨ Formatting Python code..."
	@echo "⚠️  Formatting not configured"
	@echo "   To enable, install: pip install black"
	@echo "   Then run: black *.py"

# Quick start - open everything and show info
quickstart: open-all info
	@echo ""
	@echo "🎉 Quick start complete!"
	@echo "   Documentation and demo are now open in your browser"

# Development setup
dev-setup: install
	@echo "🛠️  Development environment setup..."
	@echo "   Installing development tools..."
	pip install black flake8 pytest ipython jupyter
	@echo "✅ Development setup complete!"

# Create a simple server for the web files (requires Python)
serve:
	@echo "🌐 Starting local web server..."
	@echo "   Access at: http://localhost:8000"
	@echo "   Press Ctrl+C to stop"
	python -m http.server 8000

# Show README
readme:
	@echo "📖 Opening README..."
	@type README.md

# Show project summary
summary:
	@echo "📋 Opening Project Summary..."
	@type PROJECT_SUMMARY.md

# Verify installation
verify:
	@echo "✅ Verifying installation..."
	@echo ""
	@echo "Python version:"
	@python --version
	@echo ""
	@echo "Installed packages:"
	@pip list | findstr "numpy pandas scikit-learn xgboost shap"
	@echo ""
	@echo "Project files:"
	@if exist index.html echo ✅ index.html
	@if exist use_case_demo.html echo ✅ use_case_demo.html
	@if exist airbnb_ml_system.py echo ✅ airbnb_ml_system.py
	@if exist README.md echo ✅ README.md

# All-in-one: install, verify, and open
all: install verify open-all info
	@echo ""
	@echo "🎉 Everything is ready!"
	@echo "   Your browser should now show the documentation and demo"
