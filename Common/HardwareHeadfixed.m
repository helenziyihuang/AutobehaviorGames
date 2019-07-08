classdef HardwareHeadfixed < Rig
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
        lickVoltageDelta = 1;
        lickNominalVoltage = 5;
    end
end