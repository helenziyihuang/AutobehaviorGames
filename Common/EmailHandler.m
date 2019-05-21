classdef EmailHandler < GameObject
    properties (Access = public)
        sender
        password
        recipientList
        loginFileName
        recipientFileName
    end
    methods (Access = public)
        function obj = EmailHandler(loginFileName,recipientFileName)
            obj.loginFileName = loginFileName;
            obj.recipientFileName = recipientFileName;
%             obj.sender = load(dataFileName,'sender');
%             obj.password = load(dataFileName,'password');
%             obj.recipientList = load(dataFileName,'recipientList');
            
        end
        function obj = Awake(obj)
        end
        function obj = Auth(obj)
            try
                obj.Send("(Ignore) AuthMessage","This is a test message used for authentication.",obj.sender);
            catch e
                AuthError();
            end
        end
        function obj =  AuthError(obj)
            choice = menu("Email error notification has not yes been set up or the username/password is incorrect. Would you like to set up email now?","Yes","No, continue without emailing errors.");
            if choice == 1
                if exist('mailRecipient')
                    choice = menu("Current mail recipient: "+string(mailRecipient),"Ok","Change mail recipient");
                end
                if choice == 2 || ~exist('mailRecipient')
                     mailRecipient = input('Email address to receive error messages: ','s');
                end
                obj.sender = input('\nEmail address to send error messages: ','s');
                obj.password = input('\nPassword of sender email. WARNING THIS WILL BE STORED LOCALLY AS PLAINTEXT: ','s');
                saveLocalData;
            end
        end
        function obj = Send(obj,subject,message,recipient)
            subject = char(subject);
            message = char(message);
            if nargin<4
                recipient = obj.recipientList;
            end
            setpref('Internet','E_mail',obj.sender);
            setpref('Internet','SMTP_Server','smtp.gmail.com');
            setpref('Internet','SMTP_Username',obj.sender);
            setpref('Internet','SMTP_Password',obj.password);
            props = java.lang.System.getProperties;
            props.setProperty('mail.smtp.auth','true');
            props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory');
            props.setProperty('mail.smtp.socketFactory.port','465');
            for i = 1:numel(recipient)
                sendmail(recipient(i), subject, message);
            end
        end
        function obj = Save(obj)
            SaveStringArray(obj.recipientFileName,obj.recipientList);
            SaveStringArray(obj.loginFileName,[obj.recipientList]);
        end
        function obj = Load(obj)
            vals = csvRead(obj.dataFileName)
        end
    end
end