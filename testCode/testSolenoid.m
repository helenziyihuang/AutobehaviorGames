clc
clear all;
port = 'COM5';
io = HardwareIOGen4(port);
io.Awake();
disp('connecteds')
while ~GetKey('ESCAPE')
    if GetKey('s')
        try
        io.GiveWater(1);
        catch
            pause(1)
            io.CloseSolenoid();
        end
    end
end
