clc
clear all;
<<<<<<< HEAD
port = 'COM5';
io = HardwareIOGen4(port);
io.Awake();
disp('connecteds')
while ~GetKey('ESCAPE')
=======
port = 'COM6';
io = HardwareIOGen4(port);
io.Awake();
while ~GetKey('ESC')
>>>>>>> 91050b6ab5731991429c53c797fd26f53e4d3175
    if GetKey('s')
        try
        io.GiveWater(1);
        catch
            pause(1)
            io.CloseSolenoid();
        end
    end
end
