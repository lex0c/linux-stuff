import os
import time
import psutil
import pandas as pd
from datetime import datetime

csv_file = "system_data.csv"
columns = ["timestamp", "cpu", "ram", "network_sent", "network_received", "fs_changes"]

if not os.path.exists(csv_file):
    df = pd.DataFrame(columns=columns)
    df.to_csv(csv_file, index=False)

def count_fs_changes(path):
    try:
        file_count = sum([len(files) for _, _, files in os.walk(path)])
    except Exception as e:
        print(f"Error counting files: {e}")
        file_count = 0
    return file_count

monitor_interval = 10  # s
fs_path = "/"

while True:
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    cpu_percent = psutil.cpu_percent(interval=1)
    ram_percent = psutil.virtual_memory().percent

    net_counters = psutil.net_io_counters()
    network_sent = net_counters.bytes_sent
    network_received = net_counters.bytes_recv

    fs_changes = None #count_fs_changes(fs_path)

    data = pd.DataFrame([[timestamp, cpu_percent, ram_percent, network_sent, network_received, fs_changes]], columns=columns)
    data.to_csv(csv_file, mode='a', header=False, index=False)

    time.sleep(monitor_interval)

