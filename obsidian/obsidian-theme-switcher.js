/**
 * Obsidian Theme Switcher
 * Vigila el archivo y cambia el tema automáticamente
 */

const THEME_FILE = "obsidian-theme.txt";
const THEMES = {
    "Kanagawa": "Kanagawa",
    "Obsidian gruvbox": "Obsidian gruvbox"
};

let lastTheme = null;
let checkInterval = null;

/**
 * Lee el tema del archivo usando Obsidian API
 */
async function readThemeFromFile() {
    try {
        // Usar Obsidian vault API
        const adapter = app.vault.adapter;
        if (adapter.exists(THEME_FILE)) {
            const content = await adapter.read(THEME_FILE);
            return content.trim();
        }
    } catch (e) {
        console.log("ThemeSwitcher: Error", e);
    }
    return null;
}

/**
 * Aplica el tema a Obsidian
 */
async function applyTheme(themeName) {
    if (!themeName || !THEMES[themeName]) {
        return;
    }
    
    const actualTheme = THEMES[themeName];
    const currentTheme = app.customCss.theme;
    
    if (currentTheme !== actualTheme) {
        console.log(`ThemeSwitcher: Cambiando a ${actualTheme}`);
        app.customCss.setTheme(actualTheme);
        new Notice(`🎨 Tema: ${actualTheme}`);
    }
}

/**
 * Verifica cambios en el archivo
 */
async function checkForChanges() {
    const currentTheme = await readThemeFromFile();
    
    if (currentTheme && currentTheme !== lastTheme) {
        lastTheme = currentTheme;
        await applyTheme(currentTheme);
    }
}

/**
 * Inicia el observador
 */
function startWatcher() {
    if (checkInterval) {
        clearInterval(checkInterval);
    }
    
    // Verificar cada 2 segundos
    checkInterval = setInterval(() => {
        checkForChanges();
    }, 2000);
    
    console.log("ThemeSwitcher: Iniciado");
}

/**
 * Detiene el observador
 */
function stopWatcher() {
    if (checkInterval) {
        clearInterval(checkInterval);
        checkInterval = null;
        console.log("ThemeSwitcher: Detenido");
    }
}

/**
 * Función principal
 */
async function main() {
    console.log("ThemeSwitcher: Cargando...");
    
    // Verificar tema inicial
    const initialTheme = await readThemeFromFile();
    if (initialTheme) {
        lastTheme = initialTheme;
        await applyTheme(initialTheme);
    }
    
    // Iniciar observador
    startWatcher();
}

// Exportar para uso manual
window.ThemeSwitcher = {
    start: startWatcher,
    stop: stopWatcher,
    check: checkForChanges
};

// Ejecutar
main();
