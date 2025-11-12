# 🤖 AI Hosting Server – AG Tech Sec

## 🌍 Overview  
**AI-Hosting-Server-AGTechSec** is a complete self-hosted AI infrastructure built and maintained by **AG Tech Sec**, combining the power of **Ollama**, **OpenWebUI**, and **InvokeAI**.  
It runs locally or remotely with full GPU acceleration and SSL security via NGINX — designed for private AI research, creative image generation, and scalable hosting for clients or collaborators.

---

## ⚙️ Stack Summary
| Component | Purpose | Notes |
|------------|----------|-------|
| **Ubuntu 22.04 LTS** | Base OS | Clean, stable, secure |
| **Docker + NVIDIA Runtime** | Container management | Auto-restart & isolated GPU workloads |
| **Ollama** | Local LLM engine | Runs models like Llama 3, Mistral, Phi 3 |
| **OpenWebUI** | Chat interface | Web front-end connected to Ollama |
| **InvokeAI** | Image generator | Stable Diffusion / Flux, GPU-accelerated |
| **NGINX + SSL (Certbot)** | Reverse proxy + HTTPS | `https://ai.mychatgpt.pl` |
| **NVMe Storage** | High-speed persistent data | Models on `/mnt/backup/models` |

---

## 🚀 Key Features
- 💬 **Text AI**: Local, private LLMs via OpenWebUI + Ollama  
- 🎨 **Image AI**: Stable Diffusion / Flux generation through InvokeAI  
- 🔒 **Secure Access**: Full HTTPS + reverse proxy isolation  
- ⚡ **NVMe Performance**: Separate SSDs for OS, Docker, and model storage  
- 🔁 **Auto-Recovery**: Containers restart automatically after reboot  

---

## 🧩 Current Domains  
- Main AI Server: **[https://ai.mychatgpt.pl](https://ai.mychatgpt.pl)**  
- Backup / Expansion: **https://ai.mychatgpt.com** (future public mirror)

---

## 💡 Why Choose *AG Tech Sec*  
AG Tech Sec offers a reliable, technically refined environment for AI model hosting and experimentation.  
This platform is built by an engineer with over 15 years in IT and cybersecurity, focused on performance, privacy, and transparency.  
Whether for personal R&D, secure private inference, or GPU-assisted AI workloads — this setup delivers enterprise-grade stability in a compact, cost-efficient form.

---

## 🖼️ Screenshots

#### 🔹 OpenWebUI – Chat Interface
![OpenWebUI Screenshot](https://ai.mychatgpt.pl/assets/openwebui-preview.png)

#### 🔹 InvokeAI – Image Generation Dashboard
![InvokeAI Screenshot](https://ai.mychatgpt.pl/assets/invokeai-preview.png)

> *Note: Screenshots captured from the live AG Tech Sec AI hosting environment running on NVIDIA RTX 3060.*

---

## 🛠️ Installation & Setup (for reference)
```bash
# 1. Install Docker
sudo apt update && sudo apt install -y docker.io docker-compose

# 2. Create NVMe mount folders
sudo mkdir -p /mnt/docker_data
sudo mkdir -p /mnt/backup/models/invokeai

# 3. Pull and run containers
sudo docker run -d --name ollama --restart unless-stopped \
  -v /mnt/backup/models/ollama:/root/.ollama/models -p 11434:11434 ollama/ollama

sudo docker run -d --name openwebui --restart unless-stopped \
  -p 3000:8080 -v /mnt/docker_data/openwebui_data:/app/backend/data \
  --add-host=host.docker.internal:host-gateway ghcr.io/open-webui/open-webui:main

sudo docker run -d --name invokeai --restart unless-stopped \
  -p 9090:9090 -v /mnt/backup/models/invokeai:/opt/invokeai/invokeai/backend/image_util/mlsd/models \
  ghcr.io/invoke-ai/invokeai:latest


server {
    server_name ai.mychatgpt.pl www.ai.mychatgpt.pl;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/ai.mychatgpt.pl/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/ai.mychatgpt.pl/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}

server {
    listen 80;
    server_name ai.mychatgpt.pl www.ai.mychatgpt.pl;
    return 301 https://$host$request_uri;
}


## 🧾 Author & Contact
**Adam Gwozdz (AG Tech Sec)**  
GitHub: [AG-Sec4](https://github.com/AG-Sec4)  
Websites: [https://ai.mychatgpt.pl](https://ai.mychatgpt.pl) | [https://www.mychatgpt.pl](https://www.mychatgpt.pl)

