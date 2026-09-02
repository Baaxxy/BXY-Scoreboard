<p align="center">
    <img width="140" src="https://i.ibb.co/3kTNY7C/x19-icon-9-1.png" />
</p>

<h1 align="center">BXY-Scoreboard</h1>

<p align="center">
  یک اسکوربورد بازطراحی‌شده برای فریم‌ورک <b>QBCore</b>، سبک، قابل تنظیم و بدون نیاز به ویرایش CSS.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/framework-QBCore-blue" />
  <img src="https://img.shields.io/badge/status-active-brightgreen" />
  <img src="https://img.shields.io/badge/license-MIT-lightgrey" />
</p>

---

## ✨ ویژگی‌ها

- بازسازی کامل `qb-scoreboard` با ظاهری جدید و مدرن‌تر
- پیکربندی آسان و یکپارچه‌سازی خودکار مشاغل (Jobs) و هیست‌ها با HTML، بدون نیاز به دست‌کاری CSS
- طراحی اختصاصی: هدر با لوگوی سرور و آیکون‌های جدید
- نمایش **Player ID** و **Play Time** در بالای اسکوربورد
- امکان تعیین اینکه ID بازیکنان برای همه نمایش داده شود یا فقط برای استاف‌های آپت‌این‌شده

## 🖼️ پیش‌نمایش

<div align="center">
  <img src="https://i.ibb.co/BGxXWky/x19dev-scoreboardfree2.png" width="80%" />
</div>
<div align="center">
  <img src="https://i.ibb.co/2jdzP8W/Screenshot-2024-10-22-184348.png" width="80%" />
</div>

## 📦 پیش‌نیازها

- [qb-core](https://github.com/qbcore-framework/qb-core)
- FiveM Server (fx_version `cerulean` یا بالاتر)

## 🚀 نصب

1. پوشه‌ی `BXY-Scoreboard` را داخل دایرکتوری `resources` سرورتان قرار دهید.
2. خط زیر را به `server.cfg` اضافه کنید:

   ```cfg
   ensure BXY-Scoreboard
   ```

3. سرور را ری‌استارت کنید.

## ⚙️ پیکربندی

تمام تنظیمات در فایل `config.lua` قرار دارند:

| گزینه | توضیح | مقدار پیش‌فرض |
|---|---|---|
| `Config.OpenKey` | کلید باز کردن اسکوربورد | `HOME` |
| `Config.Toggle` | `true` = با یک بار فشار باز/بسته می‌شود، `false` = فقط تا زمانی که کلید نگه داشته شود باز است | `false` |
| `Config.MaxPlayers` | حداکثر ظرفیت بازیکنان (به‌صورت خودکار از `sv_maxclients` خوانده می‌شود) | `48` |
| `Config.availableJobs` | لیست مشاغلی که در اسکوربورد شمارش می‌شوند (مثل پلیس، امداد) | - |
| `Config.ShowIDforALL` | نمایش ID بازیکنان برای همه یا فقط استاف | `true` |

## 📁 ساختار پروژه

```
BXY-Scoreboard/
├── client.lua         # منطق سمت کلاینت
├── server.lua         # کالبک‌های سمت سرور (دریافت اطلاعات بازیکنان و مشاغل)
├── config.lua         # تنظیمات قابل شخصی‌سازی
├── fxmanifest.lua      # مانیفست ریسورس
└── html/
    ├── index.html
    ├── ui.html
    ├── style.css
    └── app.js
```

## 🛠️ ساخته‌شده با

- Lua (Client / Server)
- HTML, CSS, JavaScript (رابط کاربری NUI)

## 💬 پشتیبانی

برای گزارش باگ، درخواست قابلیت جدید یا سوال، به <a href="https://discord.gg/gcbzMPxSQt">Discord سرور</a> ما بپیوندید.

## 📄 لایسنس

این پروژه تحت لایسنس MIT منتشر شده است.
