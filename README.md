# 🛠️ Manual de Administración de Laboratorios  
**Laboratorio Académico 🧪 & Laboratorio de Juegos 🎮**

Este repositorio documenta las **tareas administrativas esenciales** para garantizar el correcto funcionamiento y rendimiento de los servidores en ambos laboratorios. Las tareas se dividen en **cuatro áreas clave**, cada una con su respectivo procedimiento, comandos y buenas prácticas.

---

## 📂 Contenido

| Sección | Descripción |
|---------|-------------|
| [Gestión de Procesos y Servicios](#-gestion-de-procesos-y-servicios) | Monitoreo y control de servicios del sistema |
| [Usuarios, Permisos y Políticas](#-administracion-de-usuarios-permisos-y-politicas) | Creación y control de accesos |
| [Automatización de Tareas (Cron)](#-automatizacion-de-tareas-cron) | Programación de tareas periódicas |
| [Almacenamiento y Sistemas de Archivos](#-administracion-del-almacenamiento-y-sistemas-de-archivos) | Gestión de discos, particiones y cuotas |

---

## ✅ Gestión de Procesos y Servicios

| Tarea | Comando / Herramienta |
|-------|-----------------------|
| Ver procesos en tiempo real | `top` / `htop` |
| Listar procesos activos | `ps aux` |
| Buscar procesos específicos | `ps aux | grep <nombre>` |
| Iniciar / detener servicios | `systemctl start|stop|restart <servicio>` |
| Ver logs de servicio | `journalctl -u <servicio> -f` |

> 📌 *En el Laboratorio de Juegos es crítico monitorear procesos que consumen CPU/RAM excesiva para evitar caídas en sesiones de uso intensivo.*

---

## 👤 Administración de Usuarios, Permisos y Políticas

| Tarea | Comando / Configuración |
|-------|------------------------|
| Crear usuario | `adduser <nombre>` |
| Asignar permisos sudo | `usermod -aG sudo <nombre>` |
| Cambiar propietario de archivos | `chown usuario:grupo archivo` |
| Modificar permisos | `chmod 750 archivo` |
| Establecer límites de recursos | `/etc/security/limits.conf` |

> 🔒 *En el Laboratorio Académico los usuarios deben tener permisos limitados. En el de Juegos, los administradores deben tener control prioritario para mantenimiento.*

---

## ⏱️ Automatización de Tareas (Cron)

| Tarea | Comando |
|-------|--------|
| Editar tareas del usuario | `crontab -e` |
| Listar cron activos | `crontab -l` |
| Cron global del sistema | `/etc/crontab` |

**Ejemplo: Ejecutar limpieza cada día a las 2 AM**
```bash
0 2 * * * /usr/bin/find /tmp -type f -delete
