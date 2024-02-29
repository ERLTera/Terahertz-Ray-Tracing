%Testing function

close all
clear
clc

thetaLimit = 0.7854; %(about 45 degrees)             %upper angle limit
z1 = 25;                                             %distance from emitter to curve peak
z2 = 5;                                              %thickness of lens (from curve peak to flat side)
rays = 101;                                          %number of rays
n1 = 1;                                              %index of refraction when entering (air)
n2 = 1.517;                                          %index of refraction when inside (lens)
n3 = 1;                                              %index of refraction when leaving (air)
radius = 26.2467;                                    %rad of curvature


%Initial angles
thetaIn = linspace(thetaLimit,-1*thetaLimit,rays);
y1 = z1*tan(thetaIn);                                %Initial heights
[theta3,y2,sag] = plano_ray_tracing(y1,thetaIn,z2,n1,n2,n3,radius);

%Focus distance
focus = abs((y2/(tan(theta3))));


%Height of focal point
y3 = focus * tan(theta3);




%%SECOND LENS

z1s = focus+z1+z2;                                             %distance from emitter to curve peak
z2s = 5;                                              %thickness of lens (from curve peak to flat side)
n1s = 1;                                              %index of refraction when entering (air)
n2s = 1.8;                                            %index of refraction when inside (lens)
n3s = 1;                                              %index of refraction when leaving (air)
radiuss = 29;

[theta3s,y2s] = plano_ray_tracing(y3,theta3,z1s,z2s,n1s,n2s,n3s); 

y1s = y3;

%Focus distance
focuss = abs((y2s/(tan(theta3s))));


%Height of focal point
y3s = focuss * tan(theta3s);


%%Ray Plots

hold on;
%First lens
for x = 1:max(size(y2))
        %into first lens
        plot([0 z1+sag(x)],[0 y1(x)],'r');  
        %within lens
        plot([z1+sag(x) (z2+z1)],[y1(x) y2(x)],'g');
        %out of first lens
        plot([(z2+z1) (focus+z1+z2)],[y2(x) y3(x)],'b');
end

%Second lens
 for x = 1:max(size(y2))
        %within lens
         plot([z1s+sag(x) (z2s+z1s)],[y1s(x) y2s(x)],'g');
        %out of first lens
         plot([(z2s+z1s) (focuss+z1s+z2s)],[y2s(x) y3s(x)],'b');
 end

hold off


%use lensmakers formula to find distance that would cause output rays to
%horizontal (it breaks lol fix it)

%set z1 to focal length to get horizontal rays, came out weird fix it
%it's because end point is set to 0 fix that

%make github repo