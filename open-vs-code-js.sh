if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    DESKTOP_DIR="$HOME/Desktop"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Para Windows, obtener el directorio del usuario y luego el escritorio
    DESKTOP_DIR="$(powershell.exe -NoProfile -Command '[System.Environment]::GetFolderPath("Desktop")' | tr -d '\r')"
else
    echo "Not supported OS"
    exit 1
fi
PROJECT_DIR="$DESKTOP_DIR/fullstack"
mkdir -p "$PROJECT_DIR"

cd $PROJECT_DIR
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

# Check OS and procced how it corresponds
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Debian/Ubuntu-based systems
    if ! command -v npm > /dev/null; then
        install_npm_debian
    else
        echo "npm is already installed on Linux."
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS-based sytems
    if ! command -v npm > /dev/null; then
        install_npm_macos
    else
        echo "npm is already installed on macOS."
    fi
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows-based sytems
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
mkdir back-end
cd back-end
mkdir api database
cat << EOF > .env_example
DB_NAME = 
DB_USER = 
DB_PASSWD = 
DB_HOST = 
DB_PORT = 
SECRET =
EOF
cat << EOF > .gitignore
node_modules
.env
EOF
touch index.js
cd ..

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
        # Detectar distribución de Linux
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

if command -v code > /dev/null; then
    code .
else
    echo "Visual Studio Code not installed, you'll have to open project in folder $PROJECT_DIR manually"
fi
