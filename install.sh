#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}"
echo "======================================================"
echo "  ______    _____     _____   _____       ___   __   __"
echo " |  ____|  |  __ \\   |_   _| |  __ \\     / _ \\  \\ \\ / /"
echo " | |__     | |__) |    | |   | |  | |   | (_) |  \\ V / "
echo " |  __|    |  _  /     | |   | |  | |    > _ <    > <  "
echo " | |       | | \\ \\    _| |_  | |__| |   | (_) |  / . \\ "
echo " |_|       |_|  \\_\\  |_____| |_____/     \\___/  /_/ \\_\\"
echo "                                                       "
echo "======================================================"
echo -e "${NC}"

echo -e "${GREEN}F.R.I.D.A.Y. Installer${NC}"
echo "This script will install all dependencies needed for F.R.I.D.A.Y."

# Directories
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
INSTALL_DIR="${SCRIPT_DIR}"
LOG_FILE="${INSTALL_DIR}/install.log"

# Check if credentials.json exists
if [ ! -f "credentials.json" ]; then
    echo "====================================================="
    echo "Missing: credentials.json"
    echo "====================================================="
    echo "To use this tool, you need to create your own Google API credentials."
    echo
    echo "1. Go to: https://console.cloud.google.com/apis/credentials"
    echo "2. Create a new project (or select an existing one)."
    echo "3. Enable the Gmail and Google Calendar APIs."
    echo "4. Create OAuth 2.0 Client ID for 'Desktop App'."
    echo "5. Download the JSON and rename it to 'credentials.json'."
    echo "6. Place it in this folder and re-run this script."
    echo "====================================================="
    exit 1
fi

echo "credentials.json found. Proceeding with installation..."


# Create log file
touch $LOG_FILE
echo "Installation log created at $(date)" > $LOG_FILE

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
    echo -e "$1"
}

# Function to check command success
check_success() {
    if [ $? -eq 0 ]; then
        log "${GREEN}✓ $1 completed successfully${NC}"
    else
        log "${RED}✗ $1 failed. Check $LOG_FILE for details${NC}"
        exit 1
    fi
}

# Make all shell scripts executable
log "${YELLOW}Making all shell scripts in directory executable...${NC}"
find "${INSTALL_DIR}" -name "*.sh" -exec chmod +x {} \; 2>> $LOG_FILE
check_success "Making scripts executable"

# Update package lists
log "${YELLOW}Updating package lists...${NC}"
apt-get update -y >> $LOG_FILE 2>&1
check_success "Package list update"

# Install Node.js and npm if not already installed
if ! command -v node &> /dev/null; then
    log "${YELLOW}Installing Node.js and npm...${NC}"
    apt-get install -y nodejs npm >> $LOG_FILE 2>&1
    check_success "Node.js and npm installation"
else
    NODE_VERSION=$(node -v)
    log "${GREEN}Node.js $NODE_VERSION is already installed${NC}"
fi

# Install system dependencies
log "${YELLOW}Installing system dependencies...${NC}"
apt-get install -y \
    curl \
    socat \
    playerctl \
    pulseaudio \
    xfce4-screenshooter \
    sudo \
    xdg-utils \
    >> $LOG_FILE 2>&1
check_success "System dependencies installation"

# Install required npm packages
log "${YELLOW}Installing npm dependencies...${NC}"
cd "${INSTALL_DIR}"
# Install http-server globally
log "${YELLOW}Installing http-server globally...${NC}"
npm install -g http-server >> $LOG_FILE 2>&1
check_success "Global http-server installation"


# Create package.json if it doesn't exist
if [ ! -f package.json ]; then
    log "${YELLOW}Creating package.json...${NC}"
    cat > package.json << EOL
{
  "name": "friday-assistant",
  "version": "1.0.0",
  "description": "F.R.I.D.A.Y. Assistant Server",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "axios": "^1.8.4",
    "body-parser": "^1.20.3",
    "cors": "^2.8.5",
    "express": "^4.21.2",
    "googleapis": "^148.0.0",
    "http-proxy-middleware": "^3.0.3",
    "jsdom": "^26.1.0",
    "node-fetch": "^3.3.2",
    "node-pulse": "^0.0.0",
    "open": "^10.1.1",
    "pulseaudio.js": "^1.3.4"
  }
}
EOL
    check_success "Package.json creation"
fi

# Install npm dependencies
npm install >> $LOG_FILE 2>&1
check_success "npm dependencies installation"
chmod +x windsurf_trigger.sh
check_success "Done"

# Make sure public directory has correct permissions
log "${YELLOW}Setting proper permissions for public directory...${NC}"
chmod -R 755 "${INSTALL_DIR}/public" 2>> $LOG_FILE
check_success "Setting public directory permissions"

# Ask for the API keys and user name
echo -e "${BLUE}Please enter your API keys for various services${NC}"

echo -e "${YELLOW}Please enter your Groq API key:${NC}"
read groqApiKey

echo -e "${YELLOW}Please enter your Weather API key:${NC}"
read weatherApiKey

echo -e "${YELLOW}Please enter your Guardian API key:${NC}"
read guardianApiKey

echo -e "${YELLOW}Please enter your YouTube API key:${NC}"
read youtubeApiKey


echo -e "${YELLOW}Please enter your TMDB API key:${NC}"
read tmdbApiKey

echo -e "${YELLOW}Please enter your Spotify Client ID:${NC}"
read spotifyClientId

echo -e "${YELLOW}Please enter your Spotify Client Secret:${NC}"
read spotifyClientSecret

echo -e "${YELLOW}What should I call you? (Your name):${NC}"
read userName

# Path to the index.html file
indexHtmlPath="${INSTALL_DIR}/public/index.html"

# Check if the index.html exists
if [[ ! -f $indexHtmlPath ]]; then
    log "${RED}Error: $indexHtmlPath not found!${NC}"
    exit 1
fi

# Create a temporary string to hold the script content
scriptContent="const apiUrl = 'http://localhost:3000';\n"
scriptContent+="const apiKey = '$groqApiKey'; // Groq API key\n"
scriptContent+="const weatherApiKey = '$weatherApiKey'; // Weather API key\n"
scriptContent+="const guardianApiKey = '$guardianApiKey'; // The Guardian API key\n"
scriptContent+="const YoutubeAPI = '$youtubeApiKey'; // Youtube"
scriptContent+="const tmdbApiKey = '$tmdbApiKey'; // TMDB API key for movie suggestions\n"
scriptContent+="const userName = '$userName';\n"

# Backup the original index.html
cp "$indexHtmlPath" "$indexHtmlPath.bak"

# Insert the generated scriptContent inside the existing <script> tag
sed -i "/<script>/a $scriptContent" "$indexHtmlPath"

# Ask user if they want to start on boot
echo -e "${YELLOW}Do you want to enable F.R.I.D.A.Y. to start automatically on boot? (y/n)${NC}"
read startOnBoot

if [[ "$startOnBoot" == "y" || "$startOnBoot" == "Y" ]]; then
    echo -e "${YELLOW}Setting up auto-start on boot...${NC}"

    # Create a cron job to run the script at startup
    (crontab -l ; echo "@reboot ${INSTALL_DIR}/run.sh") | crontab -

    # Alternatively, you can use systemd (uncomment below code for systemd)
    # cat > /etc/systemd/system/friday.service << EOL
    # [Unit]
    # Description=F.R.I.D.A.Y. Assistant
    # After=network.target

    # [Service]
    # ExecStart=${INSTALL_DIR}/start_friday.sh
    # WorkingDirectory=${INSTALL_DIR}
    # Restart=always
    # User=$(whoami)
    
    # [Install]
    # WantedBy=multi-user.target
    # EOL

    # systemctl enable friday.service
    check_success "Setting up auto-start"
fi

chmod +x "${INSTALL_DIR}/start_friday.sh"
check_success "Startup script creation"

# Set correct permissions
log "${YELLOW}Setting correct permissions...${NC}"
chmod -R 755 "${INSTALL_DIR}" 2>> $LOG_FILE
chmod 777 "${INSTALL_DIR}/windsurf_trigger.sh" 2>> $LOG_FILE
chmod 777 "${INSTALL_DIR}/start.sh" 2>> $LOG_FILE
check_success "Setting permissions"

# Done
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}✓ F.R.I.D.A.Y. installation complete!${NC}"
echo -e "${BLUE}You can start F.R.I.D.A.Y. using:${NC}"
echo -e "${YELLOW}${INSTALL_DIR}/.run.sh or ./start start/stop/debug${NC}"
echo -e "${GREEN}======================================${NC}"

