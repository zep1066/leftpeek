
# FiveM Left Peek

Lightweight left peek camera script for FiveM, compatible with ESX, QBCore, Qbox, and standalone servers.

Allows players to switch the camera to the left while aiming, and allows other resources to enable or disable it dynamically.

* Lightweight & optimized
* Works with **ox_lib** keybinds (optional)
  
---

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

---

## Dependencies

Optional:

* ox_lib

Script works without it using native key mapping.
