@echo off
REM Cleaup Script for Windows
REM
REM Rajesh Raheja
REM
REM Run as-is or schedule this to run using Scheduled Tasks
REM Pre-requisites: Set cleanup options once on the computer using "cleanmgr /sageset:1"

echo Cleaning DNS entries cache
ipconfig /flushdns

echo Cleaning system using Windows Clean Manager
cleanmgr /sagerun:1

echo Cleaning system using CCleaner
"C:\Program Files\CCleaner\CCleaner" /AUTO

echo Cleanup complete.
