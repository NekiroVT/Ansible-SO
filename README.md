# 🧠 Manual de Tareas Administrativas — Laboratorio Académico y de Juegos

## 📘 Descripción General

Este manual detalla las **tareas administrativas esenciales** implementadas con **Ansible** para garantizar la **estabilidad, seguridad y rendimiento** en los laboratorios:

- 🧪 **Laboratorio Académico:** entorno base para prácticas de servicios, procesos y automatización.  
- 🎮 **Laboratorio de Juegos:** entorno opcional de expansión y pruebas de compatibilidad.

Cada área del sistema (procesos, servicios, seguridad, automatización y almacenamiento) fue desarrollada con **4 niveles de madurez** según la rúbrica institucional de la Unidad 2.

---

## ⚙️ Estructura del Proyecto

```bash
ansible_so/
├── hosts.ini
├── group_vars/
│   └── laboratorio_academico.yml
├── playbooks/
│   ├── procesos.yml
│   ├── servicios.yml
│   ├── usuarios.yml
│   ├── automatizacion.yml
│   └── almacenamiento.yml
└── roles/
    ├── procesos/
    │   └── tasks/nivel{1..4}.yml
    ├── servicios/
    │   └── tasks/nivel{1..4}.yml
    ├── usuarios/
    │   └── tasks/nivel{1..4}.yml
    ├── automatizacion/
    │   └── tasks/nivel{1..4}.yml
    └── almacenamiento/
        └── tasks/nivel{1..4}.yml
🧩 Requisitos Previos
En el host (controlador Ansible)
bash
Copiar código
sudo apt update && sudo apt install -y ansible openssh-client
En el laboratorio Ubuntu (host gestionado)
bash
Copiar código
sudo apt install -y python3 python3-apt openssh-server
sudo systemctl enable --now ssh
🧾 Configuración del inventario
Archivo: hosts.ini

ini
Copiar código
[laboratorio_academico]
ubuntu1 ansible_host=192.168.1.102 ansible_user=ubuntu ansible_ssh_private_key_file=/home/nekiro29/.ssh/lab_ed25519

[laboratorio_juegos]
# (opcional, puedes añadir más nodos)

[all:vars]
ansible_python_interpreter=/usr/bin/python3
🚀 Ejecución de Playbooks
Cada módulo puede ejecutarse individualmente, indicando el nivel deseado (1–4):

bash
Copiar código
ansible-playbook playbooks/<nombre>.yml -e nivel_actual=<1-4>
Ejemplo:

bash
Copiar código
ansible-playbook playbooks/procesos.yml -e nivel_actual=3
🧩 MÓDULOS Y FUNCIONALIDADES
🧠 1️⃣ Gestión de Procesos
Nivel 1 — Listado general de procesos
bash
Copiar código
ps aux --sort=-%mem | head -n 10
top -b -n1 | head -n 20
📄 Evidencias:

bash
Copiar código
/var/log/procesos_nivel1.txt  
/var/log/top_nivel1.txt
Nivel 2 — Detección por CPU
bash
Copiar código
ps aux --sort=-%cpu | head -n 10
📄 Evidencia:

bash
Copiar código
/var/log/procesos_nivel2.txt
Nivel 3 — Finalización automática de procesos >80% CPU
bash
Copiar código
ps -eo pid,comm,%cpu --no-headers | awk '$3 > 80 {print $1}'
kill -9 <PID>
📄 Evidencia:

bash
Copiar código
/var/log/procesos_nivel3.txt
Nivel 4 — Resumen funcional
bash
Copiar código
ps -eo user,pid,%cpu,%mem,comm --sort=-%mem | head -n 20
📄 Evidencia:

bash
Copiar código
/var/log/procesos_nivel4.txt
⚙️ 2️⃣ Gestión de Servicios
Nivel 1 — Inventario total
bash
Copiar código
systemctl list-units --type=service
📄 Evidencia:

pgsql
Copiar código
/var/log/servicios_nivel1.json
Nivel 2 — Validación de servicios definidos
Archivo: group_vars/laboratorio_academico.yml

yaml
Copiar código
servicios_basicos:
  - { nombre: ssh, estado: iniciado, habilitado: true }
  - { nombre: cron, estado: iniciado, habilitado: true }
  - { nombre: apache2, estado: detenido, habilitado: false }
📄 Evidencia:

pgsql
Copiar código
/var/log/servicios_nivel2.json
Nivel 3 — Reinicio de servicios caídos
bash
Copiar código
sudo systemctl restart <servicio>
📄 Evidencia:

bash
Copiar código
/var/log/servicios_nivel3.txt
Nivel 4 — Reporte de estado y control
bash
Copiar código
systemctl status <servicio> --no-pager
📄 Evidencia:

pgsql
Copiar código
/var/log/servicios_nivel4.json
🔒 3️⃣ Gestión de Seguridad por Usuario
Nivel 1 — Sin roles ni permisos
Solo usuario ubuntu sin privilegios extras.

Nivel 2 — Creación básica de usuario
bash
Copiar código
sudo useradd testuser -m
sudo passwd testuser
Nivel 3 — Usuarios con roles y permisos
bash
Copiar código
sudo useradd devuser -m -G sudo
sudo chmod 750 /home/devuser
📄 Evidencia:

bash
Copiar código
/var/log/usuarios_nivel3.txt
Nivel 4 — Políticas seguras y restricciones
bash
Copiar código
sudo groupadd secure_admins
sudo useradd adminsafe -m -G secure_admins
echo '%secure_admins ALL=(ALL) /usr/bin/apt, /usr/bin/systemctl' > /etc/sudoers.d/secure_admins
📄 Evidencia:

bash
Copiar código
/var/log/usuarios_nivel4.txt
⏰ 4️⃣ Automatización de Tareas (Cron)
Nivel 1 — Sin planificación
No existen crontabs configurados.

Nivel 2 — Herramientas básicas
bash
Copiar código
crontab -e
# */5 * * * * echo "demo" >> /var/log/cron_demo.log
Nivel 3 — Programaciones funcionales
bash
Copiar código
#Ansible: demo_horaria
0 * * * * echo "OK hora $(date)" >> /var/log/cron_demo_hora.log
Nivel 4 — Automatización robusta y validada
bash
Copiar código
*/5 * * * * flock -n /tmp/cron_demo.lock -c "echo 'run $(date)' >> /var/log/cron_demo_robusto.log"
📄 Evidencia:

bash
Copiar código
/var/log/auto_nivel4.txt
🧩 Comandos de verificación:

bash
Copiar código
sudo systemctl status cron --no-pager
sudo crontab -l | egrep 'demo_|MAILTO|PATH'
sudo tail -f /var/log/cron_demo_robusto.log
💾 5️⃣ Administración de Almacenamiento
Nivel 1 — Exploración básica
bash
Copiar código
lsblk
df -h
sudo fdisk -l
Nivel 2 — Partición sin lógica
bash
Copiar código
sudo dd if=/dev/zero of=/opt/demo_loop.img bs=1M count=100
sudo losetup -fP /opt/demo_loop.img
sudo mkfs.ext4 /dev/loop15
sudo mkdir -p /mnt/demo_sin_logica
sudo mount /dev/loop15 /mnt/demo_sin_logica
📄 Evidencia:

bash
Copiar código
/var/log/alm_nivel2.txt
Nivel 3 — Organización persistente
bash
Copiar código
sudo mkdir -p /data/app
sudo mount /dev/loop14 /data/app
sudo blkid /dev/loop14
sudo nano /etc/fstab
# Añadir: UUID=<uuid_loop> /data/app ext4 defaults 0 2
📄 Evidencia:

bash
Copiar código
/var/log/alm_nivel3.txt
Nivel 4 — Administración avanzada
bash
Copiar código
df -h
du -sh /home
lsblk -f
📄 Evidencia:

bash
Copiar código
/var/log/alm_nivel4.txt
📊 Validaciones finales
Ver logs
bash
Copiar código
sudo ls /var/log | egrep 'procesos|servicios|usuarios|auto_|alm_'
Ver contenido
bash
Copiar código
sudo tail -n 20 /var/log/auto_nivel4.txt
sudo cat /var/log/servicios_nivel2.json | jq .
🧹 Limpieza general (opcional)
bash
Copiar código
sudo umount /mnt/demo_sin_logica /data/app || true
sudo losetup -D
sudo rm -rf /opt/demo_loop.img /var/log/cron_demo_* /var/log/alm_nivel*.txt
sudo find /var/log -name 'procesos_*' -delete
👨‍💻 Autor
Elias Jorge Alcca Condori
Laboratorio Académico - Universidad Peruana Unión
📅 Octubre 2025

yaml
Copiar código

---

¿Quieres que te lo exporte directamente como un archivo `.md` descargable (`README.md`)? Puedo generarlo y pasártelo listo para subir a GitHub.
