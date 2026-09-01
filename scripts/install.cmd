@echo off
rem Single-line installer for sp-ecc on Windows (cmd.exe).
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/jamaicanyutie/sp-ecc/master/scripts/install.ps1 | iex"