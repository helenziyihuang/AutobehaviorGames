classdef GratedCircle < PhysicsObject
    properties(Constant)
        radius = 100;
        contrast = 1;
    end
    properties(Access = private)
        initialOffset;
    end
    methods(Access = public)
        function obj = GratedCircle()
            obj.size = ones(1,2)* 2*obj.radius;
            obj.renderLayer = 1;
            obj.screenBounded = true;
            obj.initialOffset = 4*obj.radius;
            obj.maxPixelsPerFrame = 10;
        end
        function img = GenerateImage(obj)
            gb = imadjust(GenerateGabor(100, pi/4, 64*pi, 0, 1), [0 1], [.5-obj.contrast/2 .5 + obj.contrast/2], .2);
            res = size(gb);
            side = floor(obj.radius)*2;
            gb = imresize(gb, side/res(1));

            [x,y]=meshgrid(1:side, 1:side);
            circleMask = (((x - side/2).^2 + (y - side/2).^2)>=obj.radius^2);
            gb(circleMask) = .5;
            img = gb;
        end
        function obj = Reset(obj,side)
            obj.SetVelocity(0,1);
            obj.SetPosition([obj.initialOffset*side,0]);
        end
       
    end
end
