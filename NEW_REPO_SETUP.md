# رفع المشروع على GitHub — Repo جديد

## الطريقة السريعة (Terminal)

```bash
cd /Users/minatharwat/season_app-1
chmod +x create-new-github-repo.sh
./create-new-github-repo.sh season-app-latest private
```

- هيفتح GitHub login في المتصفح (أول مرة)
- هيعمل repo جديد **private** باسم `season-app-latest`
- هيرفع **كل** الـ commits (Apple Login + App Store fixes + backend handoff)

### Repo عام (public)

```bash
./create-new-github-repo.sh season-app-latest public
```

### اسم repo مختلف

```bash
./create-new-github-repo.sh season-app-ios private
```

---

## بعد الرفع

| المحتوى | الرابط |
|---------|--------|
| المشروع كامل | `https://github.com/YOUR_USER/season-app-latest` |
| ملفات الباك إند | `.../tree/main/backend/laravel` |

---

## ملفات للباك إند (منفصل عن GitHub)

`apple-auth.env.local` **مش** على GitHub (Private Key).

ابعت للباك إند:
1. لينك الـ repo
2. `~/Downloads/Season-Apple-Backend-Handoff.zip`

---

## لو مفيش `gh`

```bash
brew install gh
gh auth login
./create-new-github-repo.sh
```

---

## الإصدار الحالي

- **App:** `1.0.2+9` (see `pubspec.yaml`)
- **Apple Sign-In:** enabled on iOS
- **Phone:** optional at signup
