%Testing function

close all
clear
clc

%%FIRST LENS ThorLabs AL125

thetaLimit = 0.9; %(about 45 degrees)         %upper angle limit
z1 = 30.84;                                   %distance from emitter to curve peak (used lensmakers equation to find)
z2 = 8;                                       %thickness of lens (from curve peak to flat side)
rays = 101;                                   %number of rays
n1 = 1;                                       %index of refraction when entering (air)
n2 = 1.45;                                    %index of refraction when inside (lens)
n3 = 1;                                       %index of refraction when leaving (air)
radius = 13.878;                              %rad of curvature
aspheric = 1;                                 %if lens is aspheric (1 for aspheric, else for regular plano-convex)
k = -0.57699;                                 %Conic constant (for use with aspheric lens) [value from ThorLabs AL125]


%Initial Angles
theta1 = linspace(thetaLimit,-1*thetaLimit,rays);

[theta3,y2,y1TRUE,sag] = plano_ray_tracing(theta1,z1,z2,n1,n2,n3,radius,aspheric,k);


%%SECOND LENS ThorLabs AL115
space = 10;                                   %Distance between flat side of 1st lens and curve point of 2nd lens
space2 = 44.1498;                             %Distance out of the lens before next lens 
                          % (used focal length from lensmaker's equation times 2 so that they rays come horizontal out of the third lens)
z2s = 10;                                     %thickness of lens (from curve peak to flat side)
n1s = 1;                                      %index of refraction when entering (air)
n2s = 1.45;                                   %index of refraction when inside (lens)
n3s = 1;                                      %index of refraction when leaving (air)
radiuss = 9.9337;
aspherics = 1;
ks = -0.57635;


%Initial angles (output angles from previous lens)
 theta1s = theta3;

[theta3s,y2s,y1TRUEs,sags] = plano_ray_tracing(theta1s,space,z2s,n1s,n2s,n3s,radiuss,aspherics,ks); 

focuss = y2s.*tan(theta3s);


%THIRD LENS ThorLabs AL125

space2t = 25;
z2t = 10;                                       %thickness of lens (from curve peak to flat side)
n1t = 1;                                        %index of refraction when entering (air)
n2t = 1.45;                                     %index of refraction when inside (lens)
n3t = 1;                                        %index of refraction when leaving (air)
radiust = 13.878;
aspherict = 1;
kt = -0.57699;


%Initial angles (output angles from previous lens)
theta1t = theta3s;

[theta3t,y2t,y1TRUEt,sagt] = plano_ray_tracing(theta1t,space2,z2t,n1t,n2t,n3t,radiust,aspherict,kt); 

focust = y2t.*tan(theta3t);

%%Ray Plots

hold on;
%First lens
for x = 1:max(size(y2))
    %into first lens
    plot([0 z1+sag(x)],[0 y1TRUE(x)],'r');  
    %within lens
    plot([z1+sag(x) (z2+z1)],[y1TRUE(x) y2(x)],'g');
    %out of first lens
    plot([(z2+z1) (z1+z2+space+sags(x))],[y2(x) y1TRUEs(x)],'b');
end

%Second lens
for x = 1:max(size(y2))
    %within lens
    plot([z1+z2+space+sags(x) (z1+z2+space+z2s)],[y1TRUEs(x) y2s(x)],'g');
    %out of second lens
    plot([(z1+z2+space+z2s) (z1+z2+space+z2s+space2+sagt(x))],[y2s(x) (y1TRUEt(x))],'b');
end

%Third lens
for x = 1:max(size(y2))
    %within lens
    plot([(z1+z2+space+z2s+space2+sagt(x)) (z1+z2+space+z2s+space2+z2t)],[(space2.*tan(theta3s(x))) (y2t(x))],'g');
    %out of second lens
    plot([(z1+z2+space+z2s+space2+z2t) (z1+z2+space+z2s+space2+z2t+space2t)],[(y2t(x)) (space2t.*tan(theta3t(x)))],'b');
end

hold off

%%NOTES
%Lensmaker's equation: 1/f = (n-1)(1/Rf - 1/Rb), found at https://www.azooptics.com/Article.aspx?ArticleID=816
