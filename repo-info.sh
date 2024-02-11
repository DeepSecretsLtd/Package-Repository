#!/bin/bash

# Define the repository owner and name
OWNER="DeepSecretsLtd"
REPO="Project-Repository"

# Define the path to the data folder
DATA_FOLDER="data"

# Function to display repository information
display_repository_info() {
    REPO_DATA="$DATA_FOLDER/repository.json"
    echo "Repository: $(jq -r '.name' $REPO_DATA)"
    echo "Description: $(jq -r '.description' $REPO_DATA)"
    echo "URL: $(jq -r '.url' $REPO_DATA)"
}

# Function to display package information
display_package_info() {
    PACKAGE="$1"
    PACKAGE_DATA="$DATA_FOLDER/packages.json"
    echo "Package: $PACKAGE"
    echo "Description: $(jq -r '.["$PACKAGE"].description' $PACKAGE_DATA)"
}

# Function to display command help
display_command_help() {
    COMMAND="$1"
    COMMAND_DATA="$DATA_FOLDER/commands.json"
    echo "Command: $COMMAND"
    echo "Help: $(jq -r '.["$COMMAND"].help' $COMMAND_DATA)"
}

# Function to display package installation info
display_package_installation_info() {
    echo "To install a package, run:"
    echo "./repo-info.sh package <package-name>"
}

# Main function
main() {
    if [ $# -eq 0 ]; then
        echo "Usage: $0 [repository|package <package-name>|command <command-name>|package-installation]"
        exit 1
    fi

    case "$1" in
        "repository")
            display_repository_info
            ;;
        "package")
            if [ $# -ne 2 ]; then
                echo "Usage: $0 package <package-name>"
                exit 1
            fi
            display_package_info "$2"
            ;;
        "command")
            if [ $# -ne 2 ]; then
                echo "Usage: $0 command <command-name>"
                exit 1
            fi
            display_command_help "$2"
            ;;
        "package-installation")
            display_package_installation_info
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
}

# Call the main function with command-line arguments
main "$@"
