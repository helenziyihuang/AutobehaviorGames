clc
clear all;
<<<<<<< HEAD
port = 'COM5';
io = HardwareIOGen4(port);
io.Awake();
sound = SoundMaker;
disp('connected')
while true
=======
port = 'COM6';
addpath('Common');
addpath('PTB-Game-Engine/GameEngine');
fprintf("connecting...\n");
io = HardwareIOGen4(port);
io.Awake();
fprintf("arduino setup complete\n");
while ~GetKey("ESC")
    clc;
>>>>>>> 91050b6ab5731991429c53c797fd26f53e4d3175
    if io.ReadLick()
        fprintf("LICKMETER ACTUATED\n");
    else
        fprintf("0\n");
    end
    pause(0.1);
end