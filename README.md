# gcm - Git Commit Message Generator

`gcm` is a lightweight Bash function that automatically generates commit messages using an AI model with `ollama`. It provides an interactive prompt to accept, edit, regenerate, or cancel the commit message. You can also specify a different model for message generation. Inspired by Andrej Karpathy's [gist snippet](https://gist.github.com/karpathy/1dd0294ef9567971c1e4348a90d69285).

## 🚀 Features
- **AI-powered commit message generation** using `ollama`
- **Interactive prompt** to accept, edit, or regenerate messages
- **Custom model selection** with `-m` flag
- **Fully compatible with Bash**

---

## 📥 Installation

### **1. Install Ollama**
`gcm` requires [Ollama](https://ollama.ai) to generate commit messages. Install it by following the instructions on the official website:
```bash
curl -fsSL https://ollama.ai/install.sh | sh
```

### **2. Install gcm**
Run the following script to install `gcm`:

```bash
# Clone the repository
git clone https://github.com/umutkavakli/gcm.git
cd gcm

# Run the install script
chmod +x install.sh
./install.sh
```

This will:
- Copy required files to `/usr/local/share/gcm/`
- Set up an alias in `~/.bashrc` for easy access

---

## 📌 Usage

### **Basic Commit Message Generation**
Simply stage your changes and run:
```bash
gcm
```
This will:
1. Generate a commit message based on staged changes
2. Show an interactive prompt with options:
   - `(a)ccept`: Use the generated commit message
   - `(e)dit`: Enter a custom message
   - `(r)egenerate`: Generate a new message
   - `(c)ancel`: Exit without committing

### **Using a Custom Model**
To use a different model for commit message generation:
```bash
gcm -m model_name
```
This will:
- Update `Modelfile` to use the specified model
- Recreate the AI model with `ollama create`

### **Help Command**
To see available options, run:
```bash
gcm -h
```

---

## 🛠️ Troubleshooting

**1. `gcm: command not found`?**  
Ensure that your shell is sourcing the alias. Run:
```bash
source ~/.bashrc
```

**2. AI model fails to generate messages?**  
Check if `ollama` is installed and working properly:
```bash
ollama list
```
