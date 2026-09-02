

<h1 align="center">BXY-Scoreboard</h1>

<p align="center">
  A redesigned scoreboard for the <b>QBCore</b> framework — lightweight, easy to configure, and no CSS editing required.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/framework-QBCore-blue" />
  <img src="https://img.shields.io/badge/status-active-brightgreen" />
  <img src="https://img.shields.io/badge/license-MIT-lightgrey" />
</p>

---

## ✨ Features

- Full rebuild of `qb-scoreboard` with a fresh, modern look
- Easy configuration with automatic integration of jobs and duty-based roles into the HTML — no CSS editing needed
- Custom redesign: server logo header and new icon set
- **Player ID** and **Play Time** displayed at the top of the scoreboard
- Option to show player IDs to everyone or only to opted-in staff

## 🖼️ Preview

<div align="center">
  <img src="https://s21.uupload.ir/files/hesamlightpower/Screenshot%202026-09-02%20072226.png" width="25%" />
</div>

## 📦 Requirements

- [qb-core](https://github.com/qbcore-framework/qb-core)
- FiveM Server (fx_version `cerulean` or newer)

## 🚀 Installation

1. Place the `BXY-Scoreboard` folder inside your server's `resources` directory.
2. Add the following line to your `server.cfg`:

   ```cfg
   ensure BXY-Scoreboard
   ```

3. Restart your server.

## ⚙️ Configuration

All settings live in `config.lua`:

| Option | Description | Default |
|---|---|---|
| `Config.OpenKey` | Key used to open the scoreboard | `HOME` |
| `Config.Toggle` | `true` = press once to open/close, `false` = only visible while the key is held | `false` |
| `Config.MaxPlayers` | Max player capacity (auto-read from `sv_maxclients`) | `48` |
| `Config.availableJobs` | List of jobs counted on the scoreboard (e.g. police, EMS) | - |
| `Config.ShowIDforALL` | Show player IDs to everyone or staff only | `true` |

## 📁 Project Structure

```
BXY-Scoreboard/
├── client.lua         # Client-side logic
├── server.lua         # Server-side callbacks (player & job data)
├── config.lua         # User-configurable settings
├── fxmanifest.lua      # Resource manifest
└── html/
    ├── index.html
    ├── ui.html
    ├── style.css
    └── app.js
```

## 🛠️ Built With

- Lua (Client / Server)
- HTML, CSS, JavaScript (NUI interface)

## 💬 Support

For bug reports, feature requests, or questions, join our <a href="https://discord.gg/gcbzMPxSQt">Discord server</a>.

## 📄 License

This project is released under the MIT License.
