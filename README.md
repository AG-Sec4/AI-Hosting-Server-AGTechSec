# 🤖 AG Tech Sec – AI Hosting Platform
A secure, GPU-accelerated, self-hosted AI environment built and maintained by **Adam Gwoźdź (AG Tech Sec)**.  
This platform brings together **Ollama**, **OpenWebUI**, and a modular Image Generation engine — fully containerised with **Docker**, optimised with **NVIDIA RTX GPU acceleration**, running on high-performance **NVMe storage**, and secured through **NGINX + HTTPS**.

This project is a **fully automated AI hosting environment** built and maintained by **Adam Gwozdz (AG Tech Sec)**.

It combines:

- **Ollama** – local LLM engine (Mistral, Llama3, Gemma2, StarCoder, CodeLlama, etc.)
- **OpenWebUI** – modern chat interface for AI models
- **InvokeAI** – image generation UI and API (SD 1.5 / SDXL and others)
- **NGINX + SSL (Let’s Encrypt)** – secure public access with your own domains

All services run in **Docker**, use **NVMe storage**, and are **GPU-accelerated** on an **NVIDIA RTX 3060**.

---

## 🌐 Public Endpoints

- 🧠 **Chat AI (OpenWebUI + Ollama)**  
  → **https://mychatgpt.pl** (and local: `http://<SERVER_IP>:3000`)

- 🎨 **Image Generation (InvokeAI)**  
  → **https://ai.mychatgpt.pl** (and local: `http://<SERVER_IP>:9090`)

> `mychatgpt.pl` is dedicated to **chat / coding / research**.  
> `ai.mychatgpt.pl` is dedicated to **image generation** only.

---

## ⚙️ Features

- 🔹 One-command Docker install via `install_docker.sh`
- 🔹 One-command AI stack start via `start_all.sh`
- 🔹 Ollama models stored persistently under `/mnt/backup/models/ollama`
- 🔹 InvokeAI models stored persistently under `/mnt/backup/models/invokeai`
- 🔹 Docker data on `/mnt/docker_data` (separate NVMe)
- 🔹 GPU support enabled (`--gpus all`) for fast inference
- 🔹 NGINX reverse proxy + Let’s Encrypt SSL for both domains
- 🔹 Designed to survive **reboots** (systemd + Docker `--restart unless-stopped`)

---

## 🧰 Included Scripts

| Script              | Purpose                                                                 |
|---------------------|-------------------------------------------------------------------------|
| `install_docker.sh` | Install Docker, NVIDIA runtime, and prepare mount points on Ubuntu.    |
| `start_all.sh`      | Start **Ollama**, **OpenWebUI**, and **InvokeAI** with the right mounts and ports. |

---

## 🏗 High-Level Architecture

- **Host OS**: Ubuntu 22.04 bare-metal server
- **Storage Layout**  
  - `/` → OS (LVM)  
  - `/mnt/docker_data` → Docker root  
  - `/mnt/backup` → Long-term data and models  
- **Docker Containers**  
  - `ollama` → `0.0.0.0:11434` (models stored in `/mnt/backup/models/ollama`)  
  - `openwebui` → `0.0.0.0:3000` (chat UI)  
  - `invokeai` → `0.0.0.0:9090` (image generator UI/API)  
- **NGINX Sites**  
  - `mychatgpt.pl` → proxy to `http://localhost:3000`  
  - `ai.mychatgpt.pl` → proxy to `http://127.0.0.1:9090`




 
Designed for **privacy, stability, scalability and everyday use**.

---

## ⚙️ Key Capabilities
- 🔹 One-command deployment using `install_docker.sh`  
- 🔹 Automatic startup for all AI services via `start_all.sh`  
- 🔹 GPU-accelerated inference using NVIDIA Container Toolkit  
- 🔹 Fast NVMe model storage  
- 🔹 Secure public access through **mychatgpt.pl**  
- 🔹 Fully modular Docker architecture  
- 🔹 Reboot-resistant design using systemd  
- 🔹 Easy expansion for future AI services  

---

## 🧠 Main Components

### **1. Ollama – LLM Engine**
- Runs advanced models: Llama, Mistral, Gemma, etc.  
- GPU-accelerated token generation  
- Locally stored models for privacy  
- Supports custom models and quantisations  

### **2. OpenWebUI – Chat Interface**
- User-friendly chat UI  
- Multiple personas, memory, prompt templates  
- Can be locked down to provide *Kid-Safe Mode*  
- Accessible securely through the domain  

### **3. Image Generation Engine (Modular)**
- Processes Stable Diffusion and SDXL models  
- Runs inside its own Docker container  
- Uses the same GPU for high-speed image generation  
- Store new image models in `/mnt/backup/models/`  

---

## 🌍 Public Endpoint
- **Chat AI:** https://mychatgpt.pl  
(Reverse-proxied via NGINX → OpenWebUI → Ollama)

---

## 🧱 Architecture Diagram
>>>>>>> e375272 (Documentation update: polished README.md, improved clarity, expanded platform details)

                  +--------------------------+
                  |         Internet         |
                  +-------------+------------+
                                |
                                v
                  +--------------------------+
                  |          NGINX           |
                  |  HTTPS + Security Layer  |
                  +------+-------------------+
                         |
        +----------------+-------------------------+
        |                                          |
        v                                          v
+---------------+                        +---------------------+
|  OpenWebUI    |                        | Image Generation    |
|  (Chat UI)    |                        |  Service (Docker)   |
+-------+-------+                        +---------+-----------+
        |                                           |
        v                                           |
+---------------+                                    |
|    Ollama     |                                    |
|  (LLM Engine) |                                    |
+-------+-------+                                    |
        |                                            |
        +------------------- GPU ---------------------+


---

## 📂 Project Structure
AI-Hosting-Server-AGTechSec/
├─ README.md
├─ scripts/
│  ├─ install_docker.sh
│  ├─ start_all.sh
│  └─ restart_all.sh
├─ nginx/
│  └─ mychatgpt.pl.conf
├─ docs/
│  ├─ architecture.md
│  └─ manual.md
└─ models/   (optional – local model storage)

---

## 📘 Quick Usage Guide

### **Start all AI services**
sudo bash scripts/start_all.sh


### **Restart after reboot**
sudo bash scripts/restart_all.sh


### **Check running containers**
docker ps


### **Check GPU status**
nvidia-smi


### **Pull new LLM models**
ollama pull llama3
ollama pull mistral


### **View logs**
docker logs openwebui
docker logs ollama
docker logs imagegen


---

## 🔒 Security Features
- Full HTTPS with Certbot  
- Hardened NGINX security headers  
- Containers isolated on internal Docker network  
- Only *one safe domain* documented  
- No secrets, no tokens, no IPs stored in GitHub  
- Safe for public sharing  

---

## 🚀 Future Roadmap
- Multi-user GPU isolation  
- Vast.ai provider integration  
- Enhanced monitoring dashboards  
- Whisper audio transcription  
- OCR/TTS modules  
- Full backup automation  
- Per-user workspace isolation  

---

## 👨‍💻 About AG Tech Sec
This platform is engineered by **Adam Gwozdz**, bringing over 15 years of international IT experience across the UK and Poland, with expertise in:

- AI infrastructure & automation  
- Cybersecurity & red team techniques  
- Cisco networking and virtualisation  
- Linux server administration  
- Docker, DevOps and homelab architecture  

The mission:  
**Build powerful, private, secure AI systems accessible anywhere.**

GitHub → https://github.com/AG-Sec4  
Website → https://mychatgpt.pl  
