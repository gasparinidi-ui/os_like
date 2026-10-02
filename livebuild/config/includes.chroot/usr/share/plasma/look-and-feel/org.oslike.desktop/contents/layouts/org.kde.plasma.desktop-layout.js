// Layout estilo Windows para o OSLike.

// Área de trabalho: papel de parede do OSLike com ícones (Folder View)
var desktopsArray = desktopsForActivity(currentActivity());
for (var j = 0; j < desktopsArray.length; j++) {
    var desk = desktopsArray[j];
    desk.wallpaperPlugin = "org.kde.image";
    desk.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"];
    desk.writeConfig("Image", "file:///usr/share/wallpapers/OSLike/");
}

// Barra de tarefas inferior, fixa (sem flutuar), como no Windows 10
var panel = new Panel;
panel.location = "bottom";
panel.height = 2 * Math.floor(gridUnit * 2.4 / 2);
panel.floating = false;
panel.hiding = "none";

// Botão Iniciar
var kickoff = panel.addWidget("org.kde.plasma.kickoff");
kickoff.currentConfigGroup = ["General"];
kickoff.writeConfig("icon", "oslike-start");
kickoff.writeConfig("favoritesPortedToKAstats", "true");
kickoff.currentConfigGroup = ["Shortcuts"];
kickoff.writeConfig("global", "Alt+F1");

panel.addWidget("org.kde.plasma.marginsseparator");

// Programas fixados / abertos (só ícones, como a taskbar do Windows)
var tasks = panel.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("launchers", [
    "applications:org.kde.dolphin.desktop",
    "applications:firefox-esr.desktop",
    "applications:libreoffice-writer.desktop",
    "applications:org.kde.discover.desktop",
    "applications:org.kde.konsole.desktop"
]);

panel.addWidget("org.kde.plasma.marginsseparator");

// Bandeja do sistema, relógio e "mostrar área de trabalho" no canto direito
panel.addWidget("org.kde.plasma.systemtray");
var clock = panel.addWidget("org.kde.plasma.digitalclock");
clock.currentConfigGroup = ["Appearance"];
clock.writeConfig("showDate", "true");
clock.writeConfig("dateDisplayFormat", "BelowTime");
panel.addWidget("org.kde.plasma.showdesktop");
