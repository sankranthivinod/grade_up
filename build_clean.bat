@echo off
echo Cleaning Flutter build...
flutter clean

echo Getting dependencies...
flutter pub get

echo Running build_runner...
flutter pub run build_runner build --delete-conflicting-outputs

echo Done!
pause
