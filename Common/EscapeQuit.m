classdef EscapeQuit < GameObject
    methods (Access = public)
        function obj = Awake(obj)
            KbCheck();
        end
        function obj = Update(obj)
                   if GetKey('ESC') || GetKey('ESCAPE') || GetKey('q')
                       obj.Game.Quit(); 
                   end
        end
    end
end