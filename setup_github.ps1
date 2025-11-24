# GitHub Upload Setup Script (PowerShell)
# This script helps you prepare and upload the project to GitHub

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "🚀 GitHub Upload Setup" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "✅ Git is installed: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git is not installed. Please install Git first." -ForegroundColor Red
    Write-Host "   Download from: https://git-scm.com/downloads" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# Initialize git repository if not already initialized
if (-not (Test-Path .git)) {
    Write-Host "📦 Initializing Git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "✅ Git repository already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "📝 Setting up Git configuration..." -ForegroundColor Yellow
Write-Host "   Please enter your details:" -ForegroundColor Yellow
Write-Host ""

# Get user details
$github_username = Read-Host "Enter your GitHub username"
$github_email = Read-Host "Enter your email"
$repo_name = Read-Host "Enter repository name (default: airbnb-ml-system)"
if ([string]::IsNullOrWhiteSpace($repo_name)) {
    $repo_name = "airbnb-ml-system"
}

# Configure git
git config user.name "$github_username"
git config user.email "$github_email"

Write-Host ""
Write-Host "✅ Git configured with:" -ForegroundColor Green
Write-Host "   Username: $github_username" -ForegroundColor Cyan
Write-Host "   Email: $github_email" -ForegroundColor Cyan
Write-Host "   Repository: $repo_name" -ForegroundColor Cyan

Write-Host ""
Write-Host "📋 Checking project files..." -ForegroundColor Yellow

# List important files
$files = @(
    "README.md",
    "index.html",
    "use_case_demo.html",
    "airbnb_ml_system.py",
    "requirements.txt",
    ".gitignore",
    "LICENSE",
    "Makefile"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "   ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $file (missing)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "📦 Adding files to Git..." -ForegroundColor Yellow
git add .

Write-Host ""
Write-Host "💬 Creating initial commit..." -ForegroundColor Yellow
git commit -m "Initial commit: Airbnb Home Value Prediction ML System

- Interactive documentation website with modern UI
- Real-time prediction demo with SHAP explanations
- Complete Python ML implementation
- Comprehensive documentation and guides
- Production-ready system architecture"

Write-Host ""
Write-Host "✅ Initial commit created!" -ForegroundColor Green

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "📤 Next Steps:" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Create a new repository on GitHub:" -ForegroundColor Yellow
Write-Host "   https://github.com/new" -ForegroundColor Cyan
Write-Host "   Repository name: $repo_name" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Run these commands to push your code:" -ForegroundColor Yellow
Write-Host ""
Write-Host "   git branch -M main" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/$github_username/$repo_name.git" -ForegroundColor White
Write-Host "   git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "3. Or use GitHub CLI (if installed):" -ForegroundColor Yellow
Write-Host ""
Write-Host "   gh repo create $repo_name --public --source=. --remote=origin" -ForegroundColor White
Write-Host "   git push -u origin main" -ForegroundColor White
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "✅ Setup Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Press any key to continue..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
