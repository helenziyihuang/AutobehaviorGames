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
            obj.maxPixelsPerFrame = 10;
        end
        function obj = Awake(obj)
            windowSize = obj.Renderer.WindowSize();
            obj.initialOffset = (windowSize(1)/2-obj.radius)/2;
        end
        function img = GenerateImage(obj)
            gb = imadjust(obj.GenerateGabor(100, pi/4, 64*pi, 0, 1), [0 1], [.5-obj.contrast/2 .5 + obj.contrast/2], .2);
            res = size(gb);
            side = floor(obj.radius)*2;
            gb = imresize(gb, side/res(1));

            [x,y]=meshgrid(1:side, 1:side);
            circleMask = (((x - side/2).^2 + (y - side/2).^2)>=obj.radius^2);
            gb(circleMask) = .5;
            img = gb;
        end
        function gb=GenerateGabor(obj,sigma,theta,lambda,psi,gamma)
            %james's procedural gabor function
            sigma_x = sigma;
            sigma_y = sigma/gamma;

            % Bounding box
            nstds = 3;
            xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
            xmax = ceil(max(1,xmax));
            ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
            ymax = ceil(max(1,ymax));
            xmin = -xmax; ymin = -ymax;
            [x,y] = meshgrid(xmin:xmax,ymin:ymax);

            % Rotation 
            x_theta=x*cos(theta)+y*sin(theta);
            y_theta=-x*sin(theta)+y*cos(theta);

            gb= exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);
        end
        function obj = Reset(obj,side)
            obj.SetVelocity(0,1);
            obj.SetPosition([obj.initialOffset*side,0]);
        end
       
    end
end
