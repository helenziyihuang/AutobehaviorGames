function [] = requestInput()
    %Variables to be input by the user
    mouseID = [];
    rig = [];
    sessionNum=[];
    numTrials = [];
    port = [];
    screenNum=[];
    monitorType = [];   %use to adapt different monitor types (normal or stretched)
    reward = [];
    saveDir = 'Z:/Autobehaviour Data';
    
    if exist('values.mat','file')
        load('values.mat');
    end
    
    %Menu prompted for the input
    prompt = {
        "Mouse ID",
        "Rig",
        "Session Number",
        "Number of Trials",
        "Port",
        "Output Monitor Number (0 for single monitor)",
        "Monitor Type (0 for normal, 1 for stretched)";
        "Reward On Incorrect (0 or 1)",
        "Save Directory"};
    title = "Settings";
    dims = [1 35];
    
    %Inputs corresponding to each variables
    defInput = {mouseID, rig, sessionNum, numTrials, port, screenNum, monitorType, reward, saveDir};
    for i = 1:numel(defInput)
        if ~isstring(defInput{i})
            defInput{i} = num2str(defInput{i});
        end
    end
    
    val = inputdlg(prompt,title,dims,defInput);
    mouseID = val{1};
    rig = val{2};
    sessionNum = str2num(val{3});
    numTrials = str2num(val{4});
    port = val{5};
    screenNum = str2num(val{6});
    monitorType = str2num(val{7});
    reward = str2num(val{8});
    saveDir = val{9};
    saveLocalData;
    evalin('base',"load('values')");
end
    
