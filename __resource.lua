resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'FiFTeeN Status'

version '1.0.1'

ui_page "ui.html"

files {
    "ui.html",
    "ui.css",
    "ui.js",
	'html/armor.png',
	'html/drunk.png',
	'html/health.png',
	'html/hunger.png',
	'html/speaker.png',
	'html/water.png',
	'html/stamina.png',
}

client_script {
    'client.lua'
}