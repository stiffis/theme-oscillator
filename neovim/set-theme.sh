#!/bin/bash

# Script para cambiar tema de Neovim
# Uso: ./set-theme.sh [0|1]
# 0 = Noche (Gruvbox)
# 1 = Día (Kanagawa)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_FILE="$HOME/.config/nvim/current-theme.txt"

# Validar argumento
if [ -z "$1" ]; then
    echo "Error: Debes especificar un argumento"
    echo "Uso: $0 [0|1]"
    echo "  0 = Noche (Gruvbox)"
    echo "  1 = Día (Kanagawa)"
    exit 1
fi

# Determinar tema según argumento
if [ "$1" = "1" ]; then
    THEME_NAME="kanagawa"
    echo "Cambiando Neovim a tema de DÍA: Kanagawa"
elif [ "$1" = "0" ]; then
    THEME_NAME="gruvbox"
    echo "Cambiando Neovim a tema de NOCHE: Gruvbox"
else
    echo "Error: Argumento inválido"
    echo "Usa 0 (noche) o 1 (día)"
    exit 1
fi

# Escribir el tema actual al archivo
echo "$THEME_NAME" > "$THEME_FILE"

echo "✓ Tema de Neovim configurado: $THEME_NAME"
echo "✓ Todas las sesiones activas de Neovim se actualizarán automáticamente"
