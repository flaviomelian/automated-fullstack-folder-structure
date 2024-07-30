Automated Fullstack Folder Structure
This repository contains a desktop application written in Java that automates the creation of a basic fullstack project structure. This includes frontend setup with Vite, and installation of npm and Visual Studio Code (VS Code) depending on the operating system.

Application Description
The application performs the following tasks:

Operating System Detection:
Detects if the operating system is Linux, macOS, or Windows.
For Windows, it uses PowerShell to get the Desktop directory.
Uses Git Bash to run the Bash script on Windows systems.
Project Structure Creation:
Creates a fullstack folder on the user's Desktop.
Within this folder, it creates subdirectories for the frontend and backend.
Frontend Setup:
In the frontend directory, it creates basic files like index.html and vite.config.js.
Creates directories for components, pages, and other resources.
npm Installation:
Checks if npm is installed, and if not, attempts to install it based on the operating system:
Linux: Supports Debian/Ubuntu and RHEL/CentOS/Fedora distributions.
macOS: Uses Homebrew.
Windows: Uses Chocolatey.
Backend Setup:
Creates a basic structure with directories for api and database.
Includes an .env_example file for environment variables and a .gitignore file to exclude node_modules and .env.
Visual Studio Code (VS Code) Installation:
Attempts to install VS Code if it is not already installed, adapting to the operating system.
Usage
Prerequisites
Java installed to run the desktop application.
Bash and a compatible command-line environment.
Ensure you have administrator permissions if you need to install software (like npm or VS Code).
Running the Application
To run the application, simply clone this repository and compile the Java project. Then, start the application:

bash
Copiar código
git clone git@github.com:flaviomelian/automated-fullstack-folder-structure.git
cd automated-fullstack-folder-structure/AutomatedFullStackCreationTool
javac -d build/classes src/automatedfullstackcreationtool/*.java
java -cp build/classes automatedfullstackcreationtool.MainWindow
Running the Bash Script
The application allows specifying multiple entities that will be passed to the Bash script to create the corresponding structure:

bash
Copiar código
./open-vs-code-js.sh User Product Order
Notes
The application and script are designed to be compatible with multiple operating systems, but additional adjustments may be needed depending on your specific system setup.
Installing npm and VS Code may require administrator privileges, so you might need to run the application with elevated permissions on Unix systems.
Contributions
If you have suggestions or improvements, feel free to open an issue or submit a pull request.