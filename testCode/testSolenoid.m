clc
clear all;
port = 'COM6';
io = HardwareIOGen4(port);
io.Awake();
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
