Incident Summary:
Apache service stopped manually to simulate failure.

Detection:
Health check script detected missing apache2 process.

Resolution:
Service automatically restarted using service command.

Root Cause:
Intentional service termination.

Prevention:
Automated monitoring and restart logic.
