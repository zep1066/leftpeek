
# FiveM Left Peek

Lightweight left peek camera script for FiveM, compatible with ESX, QBCore, Qbox, and standalone servers.

Allows players to switch the camera to the left while aiming.

* Lightweight & optimized

<img width="1280" height="720" alt="leftpeek" src="https://github.com/user-attachments/assets/3fc53f90-ca6e-4fdd-97cf-214299ae33fc" />

## Installation

1. Download or clone the resource
2. Place into your `resources` folder
3. Add to your `server.cfg`

```cfg
ensure leftpeek
```

---

## API

Disable or enable left peek:

```lua
---@param state boolean
exports["leftpeek"]:setDisabled(true)
```

Check if left peek is disabled:

```lua
---@return boolean
exports["leftpeek"]:isDisabled()
```
