clc
clear all;

port = 'COM3';
addpath('Common');
addpath('PTB-Game-Engine/GameEngine');
fprintf("connecting...\n");
io = HardwareIOGen4(port);
io.Awake();
fprintf("arduino setup complete\n");
io.PowerServos(true);
io.OpenServos();
pause(5);
io.CloseServos();
pause(5);
io.PowerServos(false);