function [] = requestInput()
    mouseID = [];rig = [];sessionNum=[];numTrials = [];port = [];screenNum=[];reward = [];
    if exist('values.mat','file')
        load('values.mat');
    end
    prompt = {"Mouse ID","Rig" ,"Session Number", "Number of Trials", "Port","Output Monitor Number (zero for single monitor)","Reward On Incorrect (0 or 1)"};
    title = "Settings";
    dims = [1 35];
    
    
    defInput = {mouseID,rig,sessionNum,numTrials,port,screenNum,reward};
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
    reward = str2num(val{7});
    saveLocalData;
    evalin('base',"load('values')");
end
    
