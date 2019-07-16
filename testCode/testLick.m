clc
clear all;
port = 'COM5';
io = HardwareIOGen4(port);
io.Awake();
sound = SoundMaker;
disp('connected')
while true
    if io.ReadLick()
        clc;
        fprintf("LICKMETER ACTUATED\n");
    else
        clc;
        fprintf("0\n");
    end
end