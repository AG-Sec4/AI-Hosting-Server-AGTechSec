# 🤖 AG Tech Sec – AI Hosting Platform

A secure, GPU-accelerated AI hosting environment engineered and maintained by **Adam Gwozdz (AG Tech Sec)**.  
This platform integrates **Ollama**, **OpenWebUI**, and a modular Image Generation Service, all running inside **Docker**, accelerated with **NVIDIA RTX GPUs**, served through **NGINX + HTTPS**, and backed by fast **NVMe storage**.

Designed for **privacy, reliability, and long-term scalability**.

---

## ⚙️ Key Capabilities
- One-command deployment using `install_docker.sh`
- Automatic startup for all services using `start_all.sh`
- GPU-accelerated inference via NVIDIA Container Toolkit
- Fast NVMe model storage for rapid load times
- Secure external access through **mychatgpt.pl** only
- Modular architecture (easy to add new components)
- Reboot-resistant design using systemd
- Fully containerised and isolated

---

## 🌐 Public Endpoints (Safe Version)

### **Chat AI (OpenWebUI + Ollama)**
- Public access: **https://mychatgpt.pl**
- Local access: `http://SERVER_IP:3000`

### **Image Generation (InvokeAI / Modular SD Engine)**
- **Local access only**  
  `http://SERVER_IP:9090`

No private domains or IPs are exposed publicly in documentation.

---

## 🧠 Components Overview

### **1. Ollama – LLM Engine**
- Runs models like Llama, Mistral, Gemma, etc.
- Fully GPU-accelerated
- Local model storage for speed and privacy
- Easy to extend with new models

### **2. OpenWebUI – Chat Interface**
- Clean and modern AI chat UI
- Personas, prompt templates, conversation memory
- Optional Kid-Safe workspace with restrictions
- Routed securely via NGINX

### **3. Image Generation Service**
- Supports SD 1.5, SDXL, and custom models
- GPU-accelerated rendering
- Independent Docker container
- Data stored in `/mnt/backup/models/`

---

## 🧱 Modern Architecture Diagram

## 🧱 Modern Architecture Diagram

```text
                  [ Internet ]
                       |
                       v
            +-----------------------+
            |        NGINX          |
            |  HTTPS + Security     |
            +-----------+-----------+
                        |
        +---------------+--------------------+
        |                                    |
        v                                    v
 [ OpenWebUI ]                         [ Image Engine ]
   (Chat UI)                           (SD / SDXL, Docker)
        |                                    |
        v                                    |
     [ Ollama ]                              |
  (LLM Engine, GPU)                          |
        |____________________________________|
                        GPU

