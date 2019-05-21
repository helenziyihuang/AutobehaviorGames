choice = menu("Email error notification has not yes been set up or the username/password is incorrect. Would you like to set up email now?","Yes","No, continue without emailing errors.");
if choice == 1
    if exist('mailRecipient')
        choice = menu("Current mail recipient: "+string(mailRecipient),"Ok","Change mail recipient");
    end
    if choice == 2 || ~exist('mailRecipient')
         mailRecipient = input('Email address to receive error messages: ','s');
    end
    sender = input('\nEmail address to send error messages: ','s');
    psswd = input('\nPassword of sender email. WARNING THIS WILL BE STORED LOCALLY AS PLAINTEXT: ','s');
    saveLocalData;
end