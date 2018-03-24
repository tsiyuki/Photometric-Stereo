function [albedoImage, surfaceNormals] = photometricStereo(imArray, lightDirs)
% PHOTOMETRICSTEREO compute intrinsic image decomposition from images
%   [ALBEDOIMAGE, SURFACENORMALS] = PHOTOMETRICSTEREO(IMARRAY, LIGHTDIRS)
%   comptutes the ALBEDOIMAGE and SURFACENORMALS from an array of images
%   with their lighting directions. The surface is assumed to be perfectly
%   lambertian so that the measured intensity is proportional to the albedo
%   times the dot product between the surface normal and lighting
%   direction. The lights are assumed to be of unit intensity.
%
%   Input:
%       IMARRAY - [h w n] array of images, i.e., n images of size [h w]
%       LIGHTDIRS - [n 3] array of unit normals for the light directions
%
%   Output:
%        ALBEDOIMAGE - [h w] image specifying albedos
%        SURFACENORMALS - [h w 3] array of unit normals for each pixel
%
% Author: Subhransu Maji
%
% Acknowledgement: Based on a similar homework by Lana Lazebnik
[h, w, n] = size(imArray);
imArray = reshape(imArray, h*w, n);
% imArray = imArray';
g = lightDirs \ imArray';
g = reshape(g',w*h,1,3);
reshapeG = reshape(g,h,w,3);
albedoImage = sqrt(reshapeG(:,:,1).^2 + reshapeG(:,:,2).^2 + reshapeG(:,:,3).^2);
surfaceNormals = bsxfun(@rdivide, reshapeG, albedoImage);
















