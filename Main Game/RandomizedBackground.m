classdef RandomizedBackground < Renderable
    properties(Constant)
        radius = 100;
    end
    properties(Access = private)
        quantity;
        imageMatrix;
    end
    methods(Access = public)
        function obj = RandomizedBackground(imgFileName,quantity)
            obj.quantity = quantity;
            [obj.imageMatrix,~,alpha] = imread(imgFileName,'png');
            obj.imageMatrix(:,:,4) = alpha;
            obj.screenBounded = false;
        end
        function obj = Awake(obj)
            windowSize = obj.Renderer.WindowSize();
            disp(windowSize);
            sizeVector = ones(1,2)* 2*obj.radius;
            for i = 1:obj.quantity
                pos = (rand(1,2)-0.5).*windowSize;
                obj.InstantiateNew(pos,sizeVector);
            end
        end
        function obj = RandomizePositions(obj)
            windowSize = obj.Renderer.WindowSize();
            for i = 1:size(obj.position,1)
                obj.position(i,:) = (rand(1,2)-0.5).*windowSize;
            end
        end
        function img = GenerateImage(obj)
            img = obj.imageMatrix;
        end
    end
end
