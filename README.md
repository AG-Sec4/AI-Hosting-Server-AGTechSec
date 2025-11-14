# 🤖 AI-Hosting-Server-AG Tech Sec

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




 

