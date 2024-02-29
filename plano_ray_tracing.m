function[theta3,y2,sag] = plano_ray_tracing(y1,thetaIn,z2,n1,n2,n3,radius)


%Sag values
sag = radius - sqrt((radius.^2)-(y1.^2));

%Phi 1, angle normal to curve
phi1 = asin(y1/radius);

theta1 = phi1+thetaIn;

%Snell's law to find angle from normal within lens
theta2  = asin((n1*sin(theta1))/n2);

%Phi 2, angle from horizontal
phi2 = theta2 - phi1;

%difference in height from y1 to y2
ydiff = tan(phi2).*(z2-sag);
%Height at the flat side of the lens
y2 = y1 + ydiff;

%Snell's law to get output angles from horizontal
theta3  = asin((n2*sin(phi2))/n3);
