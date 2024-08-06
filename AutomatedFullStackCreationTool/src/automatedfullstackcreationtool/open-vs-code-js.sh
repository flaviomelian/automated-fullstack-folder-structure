#!/bin/bash

# Verificar si se ha proporcionado un nombre de proyecto, de lo contrario, usar "fullstack"
FULLSTACK_NAME="${1:-fullstack}"

FULLSTACK_NAME="$1"

# Determinar el sistema operativo
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    DESKTOP_DIR="$HOME/Desktop"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Para Windows, obtener el directorio del usuario y luego el escritorio
    DESKTOP_DIR="$(powershell.exe -NoProfile -Command '[System.Environment]::GetFolderPath("Desktop")' | tr -d '\r')"
else
    echo "Not supported OS"
    exit 1
fi

PROJECT_DIR="$DESKTOP_DIR/$FULLSTACK_NAME"
mkdir -p "$PROJECT_DIR"
cd $PROJECT_DIR

# Configuración del front-end
touch README.md
mkdir front-end
cd front-end
touch index.html
cat << EOF > vite.config.js
import {defineConfig} from 'vite'
import react from '@vitejs/plugin-react'
export default defineConfig({plugins: [react()]})
EOF
mkdir -p node-modules public src
cd src

# Verificar e instalar npm si es necesario
if ! command -v npm > /dev/null; then
    echo "npm is not installed. Trying to install it..."
fi

install_npm_debian() {
    echo "Installing npm on Debian/Ubuntu..."
    sudo apt update
    sudo apt install -y npm
}

install_npm_redhat() {
    echo "Installing npm on RHEL/CentOS/Fedora..."
    sudo dnf install -y npm
}

install_npm_macos() {
    echo "Installing npm on macOS..."
    brew install node
}

install_npm_windows() {
    echo "Installing npm on Windows..."
    choco install -y nodejs
}

# Check OS and proceed accordingly
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command -v npm > /dev/null; then
        install_npm_debian
    else
        echo "npm is already installed on Linux."
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v npm > /dev/null; then
        install_npm_macos
    else
        echo "npm is already installed on macOS."
    fi
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    if ! command -v npm > /dev/null; then
        install_npm_windows
    else
        echo "npm is already installed on Windows."
    fi
else
    echo "Not supported OS."
    exit 1
fi

touch App.css App.jsx index.css main.jsx
mkdir -p Context assets components pages
cd components
mkdir -p Header Footer
cd Header
touch Header.css Header.jsx
cd ../Context
touch file.js
cd ../pages
mkdir Home
cd Home
touch Home.css Home.jsx
cd ../../../../../

# Configuración del back-end
mkdir back-end
cd back-end
mkdir api database

# Entidades especificadas, estas se pasarían como argumentos al script
# Comprobar si se pasaron argumentos
if [ "$#" -eq 0 ]; then
    echo "Error: No se han pasado entidades como argumentos."
    echo "Uso: $0 entidad1 entidad2 ..."
    exit 1
fi

# Leer las entidades desde los argumentos
entities=("$@")

# Mostrar las entidades para verificación
echo "Entidades:"
for entity in "${entities[@]}"; do
    echo "$entity"
done

# Crear directorios para modelos, rutas y middlewares
mkdir -p api/models
mkdir -p api/routes
mkdir -p api/middlewares
mkdir -p api/controllers

# Crear estructuras para cada entidad
for (( i=1; i<${#entities[@]}; i++ )); do
    entity="${entities[i]}"
    # Normalizar el nombre de la entidad (p. ej., convertir a minúsculas)
    entity_dir=$(echo "$entity" | tr '[:upper:]' '[:lower:]')

    # Crear archivos de ejemplo para modelo, ruta y middleware
    touch api/models/${entity_dir}_model.js
    touch api/routes/${entity_dir}_route.js
    touch api/middlewares/${entity_dir}_middleware.js
    touch api/controllers/${entity_dir}_controller.js
done

# Archivo de configuración de ejemplo
cat << EOF > .env_example
DB_NAME=
DB_USER=
DB_PASSWD=
DB_HOST=
DB_PORT=
SECRET=
EOF

# Archivo .gitignore
cat << EOF > .gitignore
node_modules
.env
EOF

# Archivo de entrada
touch index.js
cd ..

# Instalación de Visual Studio Code
install_vscode_debian() {
    echo "Installing Visual Studio Code on Debian/Ubuntu..."
    sudo apt update
    sudo apt install -y software-properties-common apt-transport-https wget
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
}

install_vscode_redhat() {
    echo "Installing Visual Studio Code on RHEL/CentOS/Fedora..."
    sudo dnf install -y https://code.visualstudio.com/sha/download?build=stable&os=rpm
}

install_vscode_macos() {
    echo "Installing Visual Studio Code on macOS..."
    brew install --cask visual-studio-code
}

install_vscode_windows() {
    echo "Installing Visual Studio Code on Windows..."
    choco install -y visual-studio-code
}

if ! command -v code > /dev/null; then
    echo "Visual Studio Code not installed. Trying to install it..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if grep -q "Ubuntu\|Debian" /etc/os-release; then
            install_vscode_debian
        elif grep -q "RedHat\|Fedora\|CentOS" /etc/os-release; then
            install_vscode_redhat
        else
            echo "Unsupported Linux distribution for VS Code installation."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        install_vscode_macos
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        install_vscode_windows
    else
        echo "Not supported OS for VS Code installation."
        exit 1
    fi
fi

# Abrir el proyecto en Visual Studio Code si está instalado
if command -v code > /dev/null; then
    code .
else
    echo "Visual Studio Code not installed, you'll have to open the project in folder $PROJECT_DIR manually."
fi
