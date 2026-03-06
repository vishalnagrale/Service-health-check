# Automated Service Health Check System

## Project Objective

This project implements an automated monitoring system that periodically
checks the health of critical application services and system resources.
If a service is found to be down, the script attempts to restart it
automatically and records the event in log files for debugging and
analysis.

The system is designed to work in lightweight Linux environments such as
**WSL, containers, or minimal servers** where `systemd` services may not
always be available.

------------------------------------------------------------------------

## Architecture Overview

1.  **Service Monitoring Script (Bash)**
    -   Checks whether required service processes are running.
    -   Automatically restarts services if they are detected as stopped.
    -   Logs every event with timestamps.
2.  **Resource Monitoring Script (Python)**
    -   Monitors CPU, memory, and disk usage.
    -   Writes system resource metrics to the same log file.
3.  **Cron Scheduler**
    -   Runs both monitoring scripts automatically at fixed intervals.
4.  **Logging System**
    -   All monitoring results are written to a centralized log file.
5.  **Failure Simulation & RCA**
    -   Services are intentionally stopped to simulate outages.
    -   Root Cause Analysis (RCA) documentation explains detection and
        recovery.

------------------------------------------------------------------------

## Project Structure

    service-health-check/
    ├── bash/
    │   └── service_check.sh
    ├── python/
    │   └── resource_monitor.py
    ├── logs/
    │   └── health.log
    ├── config/
    ├── rca/
    │   └── outage_report.md
    └── README.md

------------------------------------------------------------------------

## Tech Stack

  Component            Technology
  -------------------- --------------------
  Automation           Bash
  System Monitoring    Python
  Metrics Collection   psutil
  Scheduling           Cron
  OS Environment       Ubuntu (WSL)
  Services Monitored   Apache, MySQL, SSH

------------------------------------------------------------------------

## Installation & Setup

### 1. Update Ubuntu

    sudo apt update
    sudo apt upgrade -y

### 2. Install Required Services

    sudo apt install apache2 mysql-server -y

### 3. Install Python Dependency

    pip3 install psutil

### 4. Start Services

    sudo service apache2 start
    sudo service mysql start

------------------------------------------------------------------------

## Running the Monitoring Scripts

### Run Service Health Check

    sudo bash bash/service_check.sh

### Run Resource Monitoring

    python3 python/resource_monitor.py

Logs will be written to:

    logs/health.log

------------------------------------------------------------------------

## Automating with Cron

Open crontab:

    crontab -e

Add:

    */5 * * * * /bin/bash /home/visha/service-health-check/bash/service_check.sh
    */5 * * * * /usr/bin/python3 /home/visha/service-health-check/python/resource_monitor.py

Start cron service:

    sudo service cron start

------------------------------------------------------------------------

## Sample Log Output

    2026-01-17 10:22:01 | Apache DOWN | Restarting
    2026-01-17 10:22:02 | Apache RUNNING
    2026-01-17 10:22:05 | CPU: 18% | MEM: 52% | DISK: 41%

------------------------------------------------------------------------

## Failure Simulation

To simulate a production outage:

    sudo service apache2 stop

Run the health check script:

    sudo bash bash/service_check.sh

The script will: 1. Detect that Apache is not running 2. Restart the
service automatically 3. Log the incident

------------------------------------------------------------------------

## Root Cause Analysis (RCA)

Example incident documentation:

**Incident:** Apache service stopped.

**Detection:** Health check script detected missing `apache2` process.

**Resolution:** Script restarted the service automatically.

**Root Cause:** Simulated outage for testing purposes.

**Prevention:** Automated monitoring ensures minimal downtime.

------------------------------------------------------------------------

## Key Features

-   Automated service monitoring
-   Automatic restart for failed services
-   System resource tracking
-   Scheduled execution via cron
-   Logging for debugging and audit
-   Failure simulation with RCA documentation

------------------------------------------------------------------------

## Future Improvements

-   Email or Slack alerts for failures
-   Web dashboard for monitoring
-   Configuration-based service management
