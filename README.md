# automated-fullstack-folder-structure
Automated Fullstack Folder Structure
This repository contains a shell script that automates the creation of a basic fullstack project structure, including frontend setup with Vite, and the installation of npm and Visual Studio Code (VS Code) depending on the operating system.

Script Description
The script performs the following tasks:

Operating System Detection:

Detects if the operating system is Linux, macOS, or Windows.
For Windows, it uses PowerShell to get the Desktop directory.
Project Structure Creation:

Creates a fullstack folder on the user's Desktop.
Within this folder, it creates subdirectories for front-end and back-end.
Frontend Setup:

In the front-end directory, it creates basic files like index.html and vite.config.js.
Creates directories for components, pages, and other resources.
npm Installation:

Checks if npm is installed, and if not, tries to install it according to the operating system:
Linux: Supports Debian/Ubuntu and RHEL/CentOS/Fedora distributions.
macOS: Uses brew.
Windows: Uses choco.
Backend Setup:

Creates a basic structure with directories for api and database.
Includes an .env_example file for environment variables and a .gitignore file to exclude node_modules and .env.
Visual Studio Code (VS Code) Installation:

Attempts to install VS Code if it is not already installed, adapting to the operating system.
Usage
Prerequisites
bash and a compatible command-line environment.
Ensure you have administrator permissions if you need to install software (like npm or VS Code).
Running the Script
To run the script, simply clone this repository and execute the script in your terminal:

bash
Copiar código
git clone git@github.com:flaviomelian/automated-fullstack-folder-structure.git
cd automated-fullstack-folder-structure
chmod +x script.sh
./script.sh
Notes
The script is designed to be compatible with multiple operating systems, but additional adjustments may be needed depending on your specific system setup.
Installing npm and VS Code may require administrator privileges, so you might need to run the script with sudo on Unix systems.
Contributions
If you have suggestions or improvements, feel free to open an issue or submit a pull request.

License
This project is licensed under the MIT License - see the LICENSE file for details.

