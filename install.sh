#!/bin/bash

echo 'Copying files into the location "/usr/local/share/gcm"...'
sudo mkdir -p -m 755 /usr/local/share/gcm
sudo cp commit_generator.sh Modelfile /usr/local/share/gcm

echo -e 'Creating default model...\n'
sudo ollama create llm:commit -f /usr/local/share/gcm/Modelfile

echo -e '\nAdding alias to shell configuration...'
echo 'alias gcm="source /usr/local/share/gcm/commit_generator.sh && sudo gcm"' | sudo tee -a ~/.bashrc

# Reload shell configuration
source ~/.bashrc
