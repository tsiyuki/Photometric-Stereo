function  heightMap = getSurface(surfaceNormals, method)
% GETSURFACE computes the surface depth from normals
%   HEIGHTMAP = GETSURFACE(SURFACENORMALS, IMAGESIZE, METHOD) computes
%   HEIGHTMAP from the SURFACENORMALS using various METHODs. 
%  
% Input:
%   SURFACENORMALS: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object
[h, w, n] = size(surfaceNormals);
switch method
    case 'column'
        %%% implement this %%%
        fx = - surfaceNormals(:,:,1) ./ surfaceNormals(:,:,3);
        fy = - surfaceNormals(:,:,2) ./ surfaceNormals(:,:,3);
        firstColumn = cumsum(fy, 1);
        firstColumn = bsxfun(@minus,firstColumn(:,1),firstColumn(1,1));
        fx(:,w) = [];
        rows = cat(2,zeros(h,1),cumsum(fx,2));
        heightMap = bsxfun(@plus, firstColumn, rows);
        
    case 'row'
        %%% implement this %%%
        fx = - surfaceNormals(:,:,1) ./ surfaceNormals(:,:,3);
        fy = - surfaceNormals(:,:,2) ./ surfaceNormals(:,:,3);
        firstRow = cumsum(fx, 2);
        firstRow = bsxfun(@minus,firstRow(1,:),firstRow(1,1));
        fy(h,:) = [];
        columns = cat(1,zeros(1,w),cumsum(fy,1));
        heightMap = bsxfun(@plus, firstRow, columns);
    case 'average'
        %%% implement this %%%
        fx = - surfaceNormals(:,:,1) ./ surfaceNormals(:,:,3);
        fy = - surfaceNormals(:,:,2) ./ surfaceNormals(:,:,3);
        firstColumn = cumsum(fy, 1);
        firstColumn = bsxfun(@minus,firstColumn(:,1),firstColumn(1,1));
        fx(:,w) = [];
        rows = cat(2,zeros(h,1),cumsum(fx,2));
        heightMap1 = bsxfun(@plus, firstColumn, rows);
        fx = - surfaceNormals(:,:,1) ./ surfaceNormals(:,:,3);
        fy = - surfaceNormals(:,:,2) ./ surfaceNormals(:,:,3);
        firstRow = cumsum(fx, 2);
        firstRow = bsxfun(@minus,firstRow(1,:),firstRow(1,1));
        fy(h,:) = [];
        columns = cat(1,zeros(1,w),cumsum(fy,1));
        heightMap2 = bsxfun(@plus, firstRow, columns);
        heightMap = bsxfun(@plus, heightMap1, heightMap2);
        heightMap = heightMap ./ 2;
    case 'random'
        numberPaths = 20;
        heightMap = zeros(h,w);
        fx = - surfaceNormals(:,:,1) ./ surfaceNormals(:,:,3);
        fy = - surfaceNormals(:,:,2) ./ surfaceNormals(:,:,3);
        firstRow = cumsum(fx, 2);
        firstRow = bsxfun(@minus,firstRow(1,:),firstRow(1,1));
        firstColumn = cumsum(fy, 1);
        firstColumn = bsxfun(@minus,firstColumn(:,1),firstColumn(1,1));
        for times = 1 : numberPaths
            heightMapSub = firstRow + firstColumn;
            heightMapSub(2:h,2:w) = 0;
            for x = 2 : h
                for y = 2 : w
                    yTurn = randperm(w+h,h);
                    steps = zeros(1, w+h);
                    steps(yTurn) = 1;
                     if steps(x+y-3) == 1
                         heightMapSub(x,y) = heightMapSub(x,y-1) + fx(x,y-1);
                     else
                         heightMapSub(x,y) = heightMapSub(x-1,y) + fy(x-1,y);
                     end
                 end
             end
             heightMap = heightMap + heightMapSub;
         end
         heightMap = heightMap ./ numberPaths;
          

                        

        
            
            
end

