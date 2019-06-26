clc
clear all;
port = 'COM6';
io = HardwareIOGen3(port);
io.Awake();
sound = SoundMaker;
while true
    if io.ReadLick()
        clc;
        fprintf("LICKMETER ACTUATED\n");
    else
        clc;
        fprintf("0\n");
    end
end