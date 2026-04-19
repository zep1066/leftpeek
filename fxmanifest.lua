fx_version "adamant"

game "gta5"
lua54 "yes"

author "zep1066"
description "Allows players to switch the camera to the left while aiming."

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua"
}

client_scripts {
    "client.lua"
}