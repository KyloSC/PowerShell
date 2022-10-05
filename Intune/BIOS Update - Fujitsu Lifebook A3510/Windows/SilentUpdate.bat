@echo off
@echo BIOS Version: 1.13
@echo Intel(R) ME Firmware Version: 13.0.60.2101
@echo.
@echo Notes:
@echo - Do not switch off your system during System Firmware flash
@echo - System will reboot automatically after System Firmware flash

DskFlash.exe /UPD /W /OV /O=A3510v113.bup /ARB /BPC=26 /IAC

