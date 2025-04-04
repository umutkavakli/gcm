#!/bin/bash

gcm() {
    # Default model
    model="llama3:instruct"
    
    # Function to generate commit message
    generate_commit_message() {
        git diff --cached | ollama run llm:commit
    }

    # Function to read user input compatibly with both Bash and Zsh
    read_input() {
        if [ -n "$ZSH_VERSION" ]; then
            echo -n "$1"
            read -r REPLY
        else
            read -p "$1" -r REPLY
        fi
    }


    # Parse CLI arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -m|--model)
                echo -e "[INFO]: Model Creating...\n"
                shift
                model="$1"
                sed -i "s/^FROM .*/FROM $model/" ./Modelfile
                ollama create llm:commit -f ./Modelfile
                ;;
            -h|--help)
                echo "Usage: gcm [OPTIONS]"
                echo "  -m, --model <model>   Use a specific ollama model for generating the commit message"
                echo "  -h, --help            Show this help message"
                return 0
                ;;
            *)
                echo "Unknown option: $1"
                echo "Use 'gcm -h' for help."
                return 1
                ;;
        esac
        shift
    done


    # Main script
    echo -e  "[INFO]: Generating..."
    commit_message=$(generate_commit_message)

    while true; do
        echo "Proposed commit message:"
        echo "$commit_message"

        read_input "Do you want to (a)ccept, (e)dit, (r)egenerate, or (c)ancel? "
        choice="$REPLY"

        case "$choice" in
            a|A )
                if git commit -m "$commit_message"; then
                    echo "Changes committed successfully!"
                    return 0
                else
                    echo "Commit failed. Please check your changes and try again."
                    return 1
                fi
                ;;
            e|E )
                read_input "Enter your commit message: "
                commit_message="$REPLY"
                if [ -n "$commit_message" ] && git commit -m "$commit_message"; then
                    echo "Changes committed successfully with your message!"
                    return 0
                else
                    echo "Commit failed. Please check your message and try again."
                    return 1
                fi
                ;;
            r|R )
                echo "Regenerating commit message..."
                commit_message=$(generate_commit_message)
                ;;
            c|C )
                echo "Commit cancelled."
                return 1
                ;;
            * )
                echo "Invalid choice. Please try again."
                ;;
        esac
    done
}