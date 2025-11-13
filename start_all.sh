#!/bin/bash
# ---------------------------------------------------------------------------
# start_all.sh  —  AG Tech Sec AI Hosting Server Launcher
# Author: Adam Gwozdz (AG Tech Sec)
# 
# Purpose:
#   Starts the complete AI hosting stack including:
#     • Ollama (text LLMs)
#     • OpenWebUI (chat frontend)
#     • InvokeAI (image generation)
#   All services run in Docker with auto-restart and persistent storage.
#   Designed for continuous improvement — future features and integrations
#   will follow new AI trends, Cisco automation and cybersecurity research.
# ---------------------------------------------------------------------------
#!/bin/bash
# start_all.sh — Start full AI Hosting stack (AG Tech Sec)

set -e

echo "🚀 Starting AG Tech Sec AI Hosting Stack..."

# Create required folders
sudo mkdir -p /mnt/docker_data/openwebui_data
sudo mkdir -p /mnt/backup/models/invokeai
sudo mkdir -p /mnt/backup/models/ollama

# Pull and run Ollama
echo "🧠 Starting Ollama..."
sudo docker rm -f ollama 2>/dev/null || true
sudo docker run -d --name ollama --restart unless-stopped \
  -v /mnt/backup/models/ollama:/root/.ollama/models \
  -p 11434:11434 ollama/ollama

# Pull and run OpenWebUI
echo "💬 Starting OpenWebUI..."
sudo docker rm -f openwebui 2>/dev/null || true
sudo docker run -d --name openwebui --restart unless-stopped \
  -p 3000:8080 \
  -v /mnt/docker_data/openwebui_data:/app/backend/data \
  --add-host=host.docker.internal:host-gateway \
  ghcr.io/open-webui/open-webui:main

# Pull and run InvokeAI
echo "🎨 Starting InvokeAI..."
sudo docker rm -f invokeai 2>/dev/null || true
sudo docker run -d --name invokeai --restart unless-stopped \
  -p 9090:9090 \
  -v /mnt/backup/models/invokeai:/opt/invokeai/invokeai/backend/image_util/mlsd/models \
  ghcr.io/invoke-ai/invokeai:latest

echo "✅ All containers launched successfully!"
echo "🌍 Access via:"
echo "   • OpenWebUI → https://ai.mychatgpt.pl"
echo "   • InvokeAI  → https://ai.mychatgpt.pl:9090"
echo "   • Ollama API → http://localhost:11434"


