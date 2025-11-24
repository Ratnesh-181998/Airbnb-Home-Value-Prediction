#!/bin/bash
# GitHub Upload Setup Script
# This script helps you prepare and upload the project to GitHub

echo "=========================================="
echo "🚀 GitHub Upload Setup"
echo "=========================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "❌ Git is not installed. Please install Git first."
    echo "   Download from: https://git-scm.com/downloads"
    exit 1
fi

echo "✅ Git is installed"
echo ""

# Initialize git repository if not already initialized
if [ ! -d .git ]; then
    echo "📦 Initializing Git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

echo ""
echo "📝 Setting up Git configuration..."
echo "   Please enter your details:"
echo ""

# Get user details
read -p "Enter your GitHub username: " github_username
read -p "Enter your email: " github_email
read -p "Enter repository name (default: airbnb-ml-system): " repo_name
repo_name=${repo_name:-airbnb-ml-system}

# Configure git
git config user.name "$github_username"
git config user.email "$github_email"

echo ""
echo "✅ Git configured with:"
echo "   Username: $github_username"
echo "   Email: $github_email"
echo "   Repository: $repo_name"

echo ""
echo "📋 Checking project files..."

# List important files
files=(
    "README.md"
    "index.html"
    "use_case_demo.html"
    "airbnb_ml_system.py"
    "requirements.txt"
    ".gitignore"
    "LICENSE"
    "Makefile"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file (missing)"
    fi
done

echo ""
echo "📦 Adding files to Git..."
git add .

echo ""
echo "💬 Creating initial commit..."
git commit -m "Initial commit: Airbnb Home Value Prediction ML System

- Interactive documentation website with modern UI
- Real-time prediction demo with SHAP explanations
- Complete Python ML implementation
- Comprehensive documentation and guides
- Production-ready system architecture"

echo ""
echo "✅ Initial commit created!"

echo ""
echo "=========================================="
echo "📤 Next Steps:"
echo "=========================================="
echo ""
echo "1. Create a new repository on GitHub:"
echo "   https://github.com/new"
echo "   Repository name: $repo_name"
echo ""
echo "2. Run these commands to push your code:"
echo ""
echo "   git branch -M main"
echo "   git remote add origin https://github.com/$github_username/$repo_name.git"
echo "   git push -u origin main"
echo ""
echo "3. Or use GitHub CLI (if installed):"
echo ""
echo "   gh repo create $repo_name --public --source=. --remote=origin"
echo "   git push -u origin main"
echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
