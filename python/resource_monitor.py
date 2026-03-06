import psutil
from datetime import datetime

LOG_FILE = "../logs/health.log"

cpu = psutil.cpu_percent(interval=1)
memory = psutil.virtual_memory().percent
disk = psutil.disk_usage('/').percent

with open(LOG_FILE, "a") as log:
    log.write(f"{datetime.now()} | CPU: {cpu}% | MEM: {memory}% | DISK: {disk}%\n")
