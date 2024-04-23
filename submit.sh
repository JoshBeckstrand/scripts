#!/bin/bash

# Function to print the menu
print_menu() {
  echo "Menu:"
  echo "1 - Print welcome message"
  echo "2 - Get process status on remote host"
  echo "3 - Get disk percentage used on root filesystem"
  echo "4 - Get hostname of remote machine"
}

# Function to print welcome message
print_welcome_message() {
  echo "Welcome to the script!"
}

# Function to get process status on remote host
get_process_status() {
  read -p "Enter the service name: " service
  status=$(ssh josh@$ip "service $service status" | grep "Active:" | awk '{print $2}')
  echo "Service $service is $status"
}

# Function to get disk percentage used on root filesystem
get_disk_percentage() {
  percentage=$(ssh josh@$ip "df | egrep '/$'" | awk '{print $5}')
  echo "Disk percentage used on root filesystem: $percentage%"
}

# Function to get hostname of remote machine
get_hostname() {
  hostname=$(ssh josh@$ip "hostname")
  echo "Hostname of remote machine: $hostname"
}

# Main script

# Ask user for IP address
read -p "Enter the IP address of the remote machine: " ip

# Present menu options
print_menu

# Ask user to select an option
read -p "Enter your choice: " choice

# Perform action based on user's choice
if [[ $choice -eq 1 ]]; then
  print_welcome_message
elif [[ $choice -eq 2 ]]; then
  get_process_status
elif [[ $choice -eq 3 ]]; then
  get_disk_percentage
elif [[ $choice -eq 4 ]]; then
  get_hostname
else
  echo "Invalid option"
fi
