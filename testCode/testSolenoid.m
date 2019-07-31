clc
clear all;
port = 'COM4';
addpath('Common');
addpath('PTB-Game-Engine/GameEngine');
fprintf("connecting...\n");
io = HardwareIOGen4(port);
io.Awake();
fprintf("arduino setup complete\n");

while ~GetKey('ESC')
    if GetKey('s')
        try
        io.GiveWater(1);
        catch
            pause(1)
            io.CloseSolenoid();
        end
    end
end
