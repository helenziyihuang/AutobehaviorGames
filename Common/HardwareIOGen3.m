classdef HardwareIOGen3 < Rig
    properties(Constant)
        leftServoPin = "D10"
        rightServoPin = "D9"
        servoPowerPin = "D6"
        encoderPinA = "D2"
        encoderPinB = "D3"
        solenoidPin = "D8"
        lickmeterReadPin  = "A2"
        breakBeamPin = "D7"
        beamPowerPin = "D4"
    end
    methods (Access = public)
        function obj = HardwareIOGen3(port)
            obj.port = port;
            obj.digitalOutputPins = [obj.solenoidPin, obj.beamPowerPin, obj.servoPowerPin];
            obj.digitalInputPins = [];
            obj.analogInputPins = [obj.lickmeterReadPin];
            obj.pullupPins = [obj.breakBeamPin];
        end
        function obj = Awake(obj)          
            obj.arduinoBoard = arduino(obj.port,'uno','libraries',{'servo','rotaryEncoder'});
            obj.ConfigurePins();            
            
            obj.encoder = rotaryEncoder(obj.arduinoBoard, obj.encoderPinA,obj.encoderPinB);
            
            obj.leftServo = servo(obj.arduinoBoard,obj.leftServoPin);
            obj.rightServo = servo(obj.arduinoBoard,obj.rightServoPin);
            obj.CloseServos();
        end
         function out = UnsafeReadJoystick(obj)
            out = readCount(obj.encoder)/obj.maxJoystickValue;
            if abs(out)>
                out = sign(out);
                obj.ResetEnc(out);
                return;
            end
            if abs(out)<obj.joystickResponseThreshold
                out = 0;
                return;
            end 
         end
        function out = ReadIR(obj)
             %reason for configure and disconfigure: 
                %The IR read pin interferes with servo power pins in the Gen2
                %PCB
                configurePin(obj.arduinoBoard,obj.breakBeamPin,'pullup');
               out = obj.Try('UnsafeReadIR');
               configurePin(obj.arduinoBoard,obj.breakBeamPin,'Unset');
        end
        function out = UnsafeReadIR(obj)      
                out = ~readDigitalPin(obj.arduinoBoard,obj.breakBeamPin);
        end
        function out = ReadLick(obj)
            out = false;
        end
        function obj = GiveWater(obj,time)
             writeDigitalPin(obj.arduinoBoard,obj.solenoidPin,1);
             if obj.lastWaterTime>0
                 time = obj.evaporationConstant*(obj.Game.GetTime() - obj.lastWaterTime);
             end
             obj.lastWaterTime = obj.Game.GetTime();
             obj.DelayedCall('CloseSolenoid',time);
        end
        function obj = CloseSolenoid(obj)
            writeDigitalPin(obj.arduinoBoard,obj.solenoidPin,0);
        end
    end
end