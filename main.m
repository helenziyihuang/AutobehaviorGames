
clc; 
clear all;
addpath('PTB-Game-Engine/GameEngine');
addpath('Common');
addpath('Main Game');

requestInput;
if ~(exist('sender') && exist('psswd') && exist('mailRecipient'))
emailError; 
end
developerMode = false;

if developerMode
choice = menu('Keyboard or Autobehavior Rig input?','Keyboard','Rig');
usingKeyboard = choice==1;
else
usingKeyboard = false;
end

if usingKeyboard
    io = Keyboard;
else
    choice = menu('Which circuit board are you using?', 'Gen2 (Purple)','Gen3 (Purple, non-recatngular)','Gen2.1 (Gen3 hardware on purple PCB)','Headfixed');
    switch choice
        case 1
            io = HardwareIOGen2(port);
        case 2
            io = HardwareIOGen3(port);
        case 3
            io = HardwareIOGen2_1(port);
        case 4
            io = HardwareHeadfixed(port,str2num(rig));
    end
end

results = Results(mouseID,numTrials,sessionNum,'closedLoopTraining');


renderer = Renderer(screenNum);
grating = GratedCircle;
greenCirc = TargetRing;
iescape = EscapeQuit;
sound = SoundMaker;


controller = GratedCircleController(grating,io);

manager = MainGameManager(grating,greenCirc,controller,io,sound,results);
manager.SetMaxTrials(numTrials);
manager.SetAllowIncorrect(reward);


ge = GameEngine;
try
    ge.Start(); 
catch e
    if ~developerMode
            msg = char(getReport(e,'extended','hyperlinks','off'));
            subject = "Autobehaviour ERROR: rig "+string(rig)+" mouse "+string(mouseID);
            try
                matlabmail(mailRecipient,msg,subject,sender,psswd);
            catch 
                emailError;
            end
    end
    rethrow(e);
end
if manager.GetNumberOfGamesPlayed()>=numTrials
    msg = char("mouse "+string(mouseID) + " on rig " + string(rig) + " has successfully completed " + string(numTrials) + " trials.");
    subject = "Autobehaviour SUCCESS: rig "+string(rig)+" mouse "+string(mouseID);
    try
        matlabmail(mailRecipient,msg,subject,sender,psswd);
    catch e
        emailError;
    end
end
