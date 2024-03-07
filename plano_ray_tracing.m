function[theta3,y2,y1TRUE,sag] = plano_ray_tracing(theta1,z1,z2,n1,n2,n3,radius)

%Initial heights without sag
y1 = (z1)*tan(theta1);

%Sag values
sag = radius - sqrt((radius.^2)-(y1.^2));

%Initial heights with sag

for x = 1:max(size(y1))
    if y1(x) >0
        y1TRUE = y1 + sag.*tan(theta1);
    else
        y1TRUE = y1 - sag.*tan(theta1);
    end
end


%Phi 1, angle normal to curve
phi1 = asin(y1TRUE/radius);

%Phi prime, angle into sphere normal from curve
phiPrime = asin((n1*sin(phi1))/n2);

%Theta 2, angle into sphere from horizontal and angle that hits flat edge
theta2 = phiPrime - phi1;

%Height once hits flat surface

for x = 1:max(size(y1TRUE))
    if y1TRUE(x) >0
        y2 = y1TRUE - ((z2-sag)/(tan(theta2)));
    else
        y2 = y1TRUE + ((z2-sag)/(tan(theta2)));
    end
end


%Snell's law to find angle out of flat edge
theta3 = asin((n2*sin(theta2))/(n3));

%%NOT FULLY FUNCTIONAL