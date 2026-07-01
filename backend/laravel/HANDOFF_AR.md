# تسليم Apple Login للباك إند — Season

## رابط GitHub (بعد push)

```
https://github.com/minaypclub/season_app/tree/main/backend/laravel
```

ابدأ من: **`README_FOR_BACKEND.md`**

---

## ملف ZIP (ابعته للباك إند مع GitHub)

على جهازك:

```
~/Downloads/Season-Apple-Backend-Handoff.zip
```

يحتوي كل ملفات Laravel + **`apple-auth.env.local`** (قيم `.env` الكاملة).

---

## checklist للباك إند (5 دقائق)

- [ ] نسخ `AppleAuthService.php` → `app/Services/`
- [ ] إضافة methods من `AuthController_apple_methods.php`
- [ ] إضافة أسطر `.env` من `apple-auth.env.local`
- [ ] `composer require firebase/php-jwt`
- [ ] `php artisan config:clear && php artisan cache:clear`
- [ ] التأكد من routes: `/auth/login/apple` و `/auth/register/apple`
- [ ] أعمدة `users.provider` و `users.provider_id`

---

## رسالة WhatsApp جاهزة

```
السلام عليكم،

ملفات Apple Sign-In جاهزة:

1) GitHub:
https://github.com/minaypclub/season_app/tree/main/backend/laravel
(ابدأ من README_FOR_BACKEND.md)

2) ZIP فيه .env كامل + ملفات PHP (هبعتّهولك)

APPLE_CLIENT_ID لازم = com.season.app.seasonApp (Bundle ID)

بعد التطبيق على seasonksa.com بلغوني نجرب Apple Login من التطبيق.
```

---

## Push على GitHub (من Terminal)

```bash
cd /Users/minatharwat/season_app-1
git push origin main
```

---

## ما يرفعش على GitHub

- `apple-auth.env.local` — Private Key (موجود في ZIP فقط)
- ملف `.p8` — احفظه في Downloads
