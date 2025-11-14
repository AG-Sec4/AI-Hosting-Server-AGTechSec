# 🛠️ AG Tech Sec – Full Troubleshooting Guide (Advanced Version)

This is the **complete, advanced troubleshooting manual** for the  
AG Tech Sec AI Hosting Platform — covering Ollama, OpenWebUI, InvokeAI, NGINX, GPU,  
Docker, NVMe storage, SSL, networking, ports, and system failures.

It includes **all issues resolved during real deployment**, plus required fixes,  
diagnostic commands, and full recovery procedures.

---

# ⚡ 1. GPU / CUDA Issues (NVIDIA)

## ❗ Symptoms
- `nvidia-smi` missing or returns “No devices found”
- Ollama running **CPU-only**
- InvokeAI errors:
  - `CUDA initialization failed`
  - `RuntimeError: CUDA error: out of memory`
- GPU not passed into Docker

## ✔ Fix – Reinstall NVIDIA Toolkit
```bash
sudo bash scripts/install_docker.sh
sudo reboot
```

Verify:
```bash
nvidia-smi
```

## ✔ Fix – Ensure Docker GPU runtime
```bash
docker info | grep -i nvidia
```

If missing:
```bash
sudo apt install nvidia-container-toolkit
sudo systemctl restart docker
```

---

# ⚡ 2. Ollama Issues

## ❗ Symptoms
- Slow model loading  
- OpenWebUI cannot connect to Ollama  
- Pulls fail  
- GPU not used  

## ✔ Fix – Restart
```bash
docker restart ollama
```

## ✔ Fix – Pull fresh models
```bash
ollama pull llama3
ollama pull mistral
ollama pull gemma
```

## ✔ Fix – Reset model cache
```bash
rm -rf ~/.ollama
sudo bash scripts/start_all.sh
```

---

# ⚡ 3. OpenWebUI Problems

## ❗ Symptoms
- 502 errors  
- UI not reachable on port 3000  
- CSS/JS missing  
- Blank page  

## ✔ Fix – Restart stack
```bash
sudo bash scripts/start_all.sh
docker ps
```

## ✔ Fix – Fix NGINX routing
```bash
sudo systemctl reload nginx
sudo systemctl restart nginx
```

Ensure:
```
/mnt/backup/models/ollama
```

---

# ⚡ 4. InvokeAI (Image Engine) Failures

## ❗ Issues
- “Model not found”  
- CUDA errors  
- Black output images  
- Slow processing  
- Missing SD/SDXL folders  

## ✔ Restart
```bash
docker restart imagegen
```

## ✔ Model placement
```
/mnt/backup/models/invokeai/
```

Permissions:
```bash
sudo chown -R me:me /mnt/backup/models/
sudo chmod -R 755 /mnt/backup/models/
```

## ✔ Rebuild container
```bash
docker rm -f imagegen
sudo bash scripts/start_all.sh
```

---

# ⚡ 5. Model Folder Mapping (Ollama + SD/SDXL)

## ❗ Symptoms
- Models disappear  
- InvokeAI cannot load  
- Incorrect weight paths  

## ✔ Correct structure

```
/mnt/backup/models/
├── ollama/
└── invokeai/
    ├── sd15/
    ├── sdxl/
    ├── controlnet/
    └── upscalers/
```

Permissions:
```bash
sudo chown -R me:me /mnt/backup
sudo chmod -R 755 /mnt/backup
```

---

# ⚡ 6. Docker Daemon Issues

## ❗ Symptoms
- Daemon not running  
- “Cannot connect to Docker daemon”  
- Stack not starting  

## ✔ Restart
```bash
sudo systemctl restart docker
```

## ✔ Enable at boot
```bash
sudo systemctl enable docker
```

## ✔ Full reset (dangerous)
```bash
sudo rm -rf /var/lib/docker
sudo systemctl restart docker
```

---

# ⚡ 7. NGINX / SSL / Domain Issues

## ❗ Symptoms
- SSL failure  
- 502 errors  
- Domain unreachable  

## ✔ Restart NGINX
```bash
sudo systemctl restart nginx
```

## ✔ Force renew SSL
```bash
sudo certbot renew --force-renewal
sudo systemctl restart nginx
```

## ✔ Validate config
```bash
sudo nginx -t
```

---

# ⚡ 8. Port Conflicts

## ❗ Affected ports
- 3000 (OpenWebUI)
- 9090 (InvokeAI)
- 11434 (Ollama)

## ✔ Identify process
```bash
sudo lsof -i :3000
sudo lsof -i :9090
sudo lsof -i :11434
```

Kill:
```bash
sudo kill -9 <PID>
```

---

# ⚡ 9. Storage / NVMe Mapping Issues

## ❗ Symptoms
- Models missing  
- InvokeAI weight errors  
- Docker resets  

## ✔ Check mounts
```bash
df -h
lsblk
mount | grep mnt
```

Create:
```bash
sudo mkdir -p /mnt/docker_data
sudo mkdir -p /mnt/backup/models
```

---

# ⚡ 10. Reboot Problems

## ❗ Symptoms
- Stack doesn't start  
- GPU driver missing  
- Containers offline  

## ✔ Manual start
```bash
sudo bash scripts/restart_all.sh
```

✔ Enable services:
```bash
sudo systemctl enable nginx
sudo systemctl enable docker
```

---

# ⚡ 11. DNS / Network Issues

## ❗ Testing
```bash
dig mychatgpt.pl
ping mychatgpt.pl
```

## ✔ Open firewall ports
```bash
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 3000
sudo ufw allow 9090
```

---

# ⚡ 12. Permissions Problems

## ❗ Symptoms
- “Access denied”
- InvokeAI cannot load models  

## ✔ Fix
```bash
sudo chown -R me:me /mnt/backup/
sudo chmod -R 755 /mnt/backup/
```

---

# ⚡ 13. Full Safe Recovery Procedure

Run these **in order**:

```bash
sudo systemctl restart docker
sudo systemctl restart nginx
sudo bash scripts/start_all.sh
nvidia-smi
docker ps
```

This resolves **95% of issues**.

---

# ⚡ 14. Logs to Check

```bash
docker logs openwebui
docker logs ollama
docker logs imagegen
sudo journalctl -u nginx
sudo journalctl -u docker
sudo dmesg | grep -i nvidia
```

---

# 🙋 Support

AG Tech Sec Documentation  
Website: https://www.agtechsec.com  
Chat AI: https://mychatgpt.pl  
GitHub: https://github.com/AG-Sec4
