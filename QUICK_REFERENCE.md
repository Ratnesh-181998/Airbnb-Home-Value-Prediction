# 🚀 Quick Reference Card

## ONE-COMMAND UPLOAD
```powershell
.\setup_github.ps1
```

## MANUAL UPLOAD (Copy-Paste Ready)
```bash
# 1. Initialize
git init
git add .
git commit -m "Initial commit: Airbnb ML System"

# 2. Create repo on GitHub: https://github.com/new
# Name: airbnb-ml-system

# 3. Push (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/airbnb-ml-system.git
git branch -M main
git push -u origin main
```

## KEY FILES
| File | Purpose |
|------|---------|
| `index.html` | Main documentation |
| `use_case_demo.html` | Interactive demo |
| `README.md` | Project guide |
| `setup_github.ps1` | Upload script |

## AFTER UPLOAD
1. Settings → Pages → Enable (branch: main, folder: /)
2. Add description & topics
3. Share: `https://github.com/YOUR_USERNAME/airbnb-ml-system`

## DEMO URL (after Pages enabled)
```
https://YOUR_USERNAME.github.io/airbnb-ml-system/
```

## HELP
- Full Guide: `GITHUB_UPLOAD_GUIDE.md`
- Checklist: `UPLOAD_CHECKLIST.md`
- Start: `START_HERE.md`
