fx_version "cerulean"
game { "gta5" }

author 'snakewiz'
description 'A flexible player customization script for FiveM.'
repository 'https://github.com/pedr0fontoura/fivem-appearance'
version '1.3.0'

lua54 'yes'

shared_script '@core/imports.lua'

client_scripts {
  'game/dist/index.js',
  'game/lua/client.lua'
}

server_script {
  '@oxmysql/lib/MySQL.lua',
  'game/lua/server.lua'
}

files {
  'web/dist/index.html',
  'web/dist/assets/*.js',
  'locales/*.json',
  'peds.json',
  'tattoos.json'
}

ui_page 'web/dist/index.html'