#!/usr/bin/env bash
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOkxxxxddkNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0l,,,,,',cONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk:,,,,,;cONMMMMMMMMMMMMMWWWWMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:',,,ckKNMMMMMMMMMMMWX0kdllkNMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0c',,;dXWMMMMMMMMMMNKko:;,',,,oKWMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMWKkKMMMMMMNd,,,cONMMMMMMMMMWKxl;,,,,,,,,,,:kWMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMW0c,dWMMMMW0c',oKWMMMMMMMWXkl;,,,,,,,,,;:lodONMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMW0c,'lXMMMMWx,,dXMMMMMMMWKx:,,,,,,:loxk0KXWWMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMNd,,':OWMMMNo,dXMMMMMWWKd:,,,:ldk0XWWMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMWOc,,,dNMMMKloXMMMMWXxl:,:ox0XWMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMWXx:,:0WMM0d0MMMMNklloxOXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMWXkcoXMMK0WMMWXkk0NWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMNKXWMMMMMN0KWMWWMMMWNNMMMMMMMMMMMMMMMMMMMWWWWNNNNNNWMMMMMMMMM"
echo "MMMMMMMMMMMMMMWO::ok0XNWWMMMMMMMMMMMMMMMMMWWWNXXK0OOkxddoollccccccdXMMMMMMMM"
echo "MMMMMMMMMMMMMMWx,,'',:ox0NWMMMMMMMMWX0Oxxdolcc:;;,,,,,,,,,,,,,,,,'cKMMMMMMMM"
echo "MMMMMMMMMMMMMMWkcloxk0KNWWMMMMMMMMMWXK00OOkkxddollc:;;,,,,'',,,,,'lXMMMMMMMM"
echo "MMMMMMMMMMMMMMMWNWWMMMMMWNNMMMMMMWNWMMMMMMMMMMMMWWNXXK0OOkxddolcc:xNMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMWXOoxXMMXXWMWKxkXWMMMMMMMMMMMMMMMMMMMMMMMWWNXNMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMN0o:,lKMMM0kXMMWKocok0KWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMW0l;,,:0WMMMOckWMMMNk:,,;lx0XWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMNo,,,;kWMMMM0:c0WMMMWKdl:,,,:ox0XWWMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMWk;,,dNMMMMMKc'lKWMMMMWNKd:,,,,,:ldk0XNWMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMKl'lKMMMMMMXl',c0WMMMMMMWKxc,,,,,,,;:codkOKXWMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMWKxKWMMMMMMNx,,,:OWMMMMMMMWXOo;,,,,,,,,',,;oXMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0:',,;xNMMMMMMMMMWKxl:,,,,,,,;dKWMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd,,,,,oKWMMMMMMMMMMWKkdc;,,l0WMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0c',,,,:kKNMMMMMMMMMMMWNKOONMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:,,,,,,;lONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk:,,,,,,,;l0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0c,,'',,,,cOWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXkddxkkO0KNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"

# Check if repository exists
if [[ -d .git ]] ;then
echo Pulling latest changes
git pull origin main
else
  if [[ -d GPT4All ]] ;then
    cd GPT4All
  else
    echo Cloning repository...
    rem Clone the Git repository into a temporary directory
    git clone https://github.com/cguz/chatbot-ui.git ./GPT4All
    cd GPT4All
  fi
fi
echo Pulling latest version...
git pull

# Install Python and pip
echo -n "Checking for python..."
if command -v python > /dev/null 2>&1; then
  echo "is installed"
else
  read -p "Python is not installed. Would you like to install Python3.10? [Y/N] " choice
  if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
    echo "Installing Python3.10..."
    sudo apt update
    sudo apt install -y python3.10 python3.10-venv
  else
    echo "Please install Python3.10 and try again."
    exit 1
  fi
fi

# Install conda module
echo -n "Checking for conda module..."
if conda > /dev/null 2>&1; then
  echo "is installed"
  conda create -n gpt4all-webui python=3.10
  conda activate gpt4all-webui
else
  # Install venv module
  echo -n "Checking for venv module..."
  if python -m venv env > /dev/null 2>&1; then
    echo "is installed"
  else
    read -p "venv module is not available. Would you like to install it? [Y/N] " choice
    if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
      echo "Installing venv module..."
      sudo apt update
      sudo apt install -y python3.10-venv
    else
      echo "Please install venv module and try again."
      exit 1
    fi
  fi

  # Create a new virtual environment
  echo -n "Creating virtual environment..."
  python -m venv env
  if [ $? -ne 0 ]; then
    echo "Failed to create virtual environment. Please check your Python installation and try again."
    exit 1
  else
    echo "is created"
  fi


  # Activate the virtual environment
  echo -n "Activating virtual environment..."
  source env/bin/activate
  echo "is active"

fi

# Install the required packages
echo "Installing requirements..."
python -m pip install pip --upgrade
python -m pip install --upgrade -r requirements.txt

if [ $? -ne 0 ]; then
  echo "Failed to install required packages. Please check your internet connection and try again."
  exit 1
fi


# Cleanup

if [ -d "./tmp" ]; then
  rm -rf "./tmp"
  echo "Cleaning tmp folder"
fi

# Launch the Python application
python app.py
