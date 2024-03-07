%Testing function

close all
clear
clc

thetaLimit = 0.78; %(about 45 degrees)             %upper angle limit
z1 = 5;                                             %distance from emitter to curve peak
z2 = 5;                                              %thickness of lens (from curve peak to flat side)
rays = 101;                                          %number of rays
n1 = 1;                                              %index of refraction when entering (air)
n2 = 1.517;                                          %index of refraction when inside (lens)
n3 = 1;                                              %index of refraction when leaving (air)
radius = 30;                                    %rad of curvature



%Initial Angles
theta1 = linspace(thetaLimit,-1*thetaLimit,rays);


[theta3,y2,y1TRUE,sag] = plano_ray_tracing(theta1,z1,z2,n1,n2,n3,radius);


%%SECOND LENS



space = 10;                                               %Distance between flat side of 1st lens and curve point of 2nd lens
z2s = 5;                                              %thickness of lens (from curve peak to flat side)
n1s = 1;                                              %index of refraction when entering (air)
n2s = 1.8;                                            %index of refraction when inside (lens)
n3s = 1;                                              %index of refraction when leaving (air)
radiuss = 29;


%Initial angles (output angles from previous lens)
 theta1s = theta3;

% for x = 1:max(size(theta3))
%     if theta3(x) >0
%         theta1s = abs((pi/2)-theta3);
%     else
%         theta1s = abs((pi/2)+theta3);
%     end
% end


[theta3s,y2s,y1TRUEs,sags] = plano_ray_tracing(theta1s,space,z2s,n1s,n2s,n3s,radiuss); 

focuss = y2s.*tan(theta3s);

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
        %out of first lens
         plot([(z1+z2+space+z2s) (z1+z2+space+z2s+focuss(x))],[y2s(x) 0],'b');
  end

hold off

%%NOT FULLY FUNCTIONAL

%use lensmakers formula to find distance that would cause output rays to
%horizontal (it breaks lol fix it)

%set z1 to focal length to get horizontal rays, came out weird fix it
%it's because end point is set to 0 fix that

%make github repo