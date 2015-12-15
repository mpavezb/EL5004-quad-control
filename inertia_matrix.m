
clear all;
clc;

%% defs
% obs: center of mass positions are measured relative to the quad frame,
% using an "x" configuration

% -- mass --
m_mot = 18;  % [g]  single motor mass
m_esc = 10;  % TODO  [g]  ESC and wires
m_arm = 10;  % TODO  [g]  single arm mass, without motor and esc
m_hub = 60;  % TODO  [g]  hub, does not consider arms, batteries, ..
m_bat = 192; % TODO  [g]  battery mass


% -- geometry --
alpha = 70; % [deg] arm rotation in X-Y

% motor
r_m  =  11.5; % [mm] motor radius
h_m  =  17.0; % [mm] motor height
dx_m =  77.0; % [mm] center of mass position on x axis
dy_m = 101.0; % [mm] center of mass position on y axis

% esc
a_e  =  20.0; % [mm] esc width  (x axis)
b_e  =  50.0; % [mm] esc length (y axis)
dx_e =  60.0; % [mm] center of mass position on x axis
dy_e =  54.0; % [mm] center of mass position on y axis

% arm
a_a  =  25.0; % [mm] arm width  (x axis)
b_a  =  11.5; % [mm] arm length (y axis)
dx_a =  65.0; % [mm] center of mass position on x axis
dy_a =  65.0; % [mm] center of mass position on y axis

% hub
d_h = 185.0; % [mm] hub depth  (x axis)
w_h =  45.0; % [mm] hub width  (y axis)
h_h =  45.0; % [mm] hub height (z axis)

% battery
d_b = 103.0; % [mm] battery depth  (x axis)
w_b =  34.0; % [mm] battery width  (y axis)
h_b =  26.0; % [mm] battery height (z axis)

%% preparation

% - mass [g] -> [kg]
m_mot = m_mot/1000; m_esc = m_esc/1000; m_arm = m_arm/1000;
m_hub = m_hub/1000; m_bat = m_bat/1000;

% - geometry: [mm] -> [m]^2
% motor 
r_m  = (r_m/1000) ^2; h_m  = (h_m/1000) ^2;
dx_m = (dx_m/1000)^2; dy_m = (dy_m/1000)^2;

% esc
a_e  = (a_e/1000) ^2; b_e  = (b_e/1000) ^2;
dx_e = (dx_e/1000)^2; dy_e = (dy_e/1000)^2;

% arm
a_a  = (a_a/1000) ^2; b_a  = (b_a/1000) ^2;
dx_a = (dx_a/1000)^2; dy_a = (dy_a/1000)^2;

% hub
d_h = (d_h/1000)^2; w_h = (w_h/1000)^2; h_h = (h_h/1000)^2;

% battery
d_b = (d_b/1000)^2; w_b = (w_b/1000)^2; h_b = (h_b/1000)^2;

% angles
beta = (90 - alpha)*pi/180;
sin_b = sin(beta)^2;
cos_b = cos(beta)^2;

%% Inertia Matrix

% component: motor
Jxm = 4*m_mot*(r_m/4 + h_m/3 + dy_m);
Jym = 4*m_mot*(r_m/4 + h_m/3 + dx_m);
Jzm = 4*m_mot*(r_m/2 + dx_m + dy_m);
Jm = zeros(3);
Jm(1,1) = Jxm; Jm(2,2) = Jym; Jm(3,3) = Jzm;
clear m_mot r_m h_m dx_m dy_m Jxm Jym Jzm;

% component: ESC
Jxe = 4*m_esc*(b_e*cos_b + a_e*sin_b)/12 + 4*m_esc*dy_e;
Jye = 4*m_esc*(b_e*sin_b + a_e*cos_b)/12 + 4*m_esc*dx_e;
Jze = 4*m_esc*(a_e + b_e)/12             + 4*m_esc*(dx_e + dy_e);
Je = zeros(3);
Je(1,1) = Jxe; Je(2,2) = Jye; Je(3,3) = Jze;
clear m_esc a_e b_e dx_e dy_e Jxe Jye Jze;

% component: arm
Jxa = 4*m_arm*(b_a*cos_b + a_a*sin_b)/12 + 4*m_arm*dy_a;
Jya = 4*m_arm*(b_a*sin_b + a_a*cos_b)/12 + 4*m_arm*dx_a;
Jza = 4*m_arm*(a_a + b_a)/12             + 4*m_arm*dx_a + dy_a;
Ja = zeros(3);
Ja(1,1) = Jxa; Ja(2,2) = Jya; Ja(3,3) = Jza;
clear m_arm a_a b_a dx_a dy_a Jxa Jya Jza;

% component: hub
Jxh = m_hub*(w_h + h_h)/12 + m_hub/4;
Jyh = m_hub*(d_h + h_h)/12 + m_hub/4;
Jzh = m_hub*(w_h + d_h)/12;
Jh = zeros(3);
Jh(1,1) = Jxh; Jh(2,2) = Jyh; Jh(3,3) = Jzh;
clear m_hub w_h d_h Jxh Jyh Jzh;

% component: battery
dz_b = (sqrt(h_h) + sqrt(h_b)/2)^2;
Jxb = m_bat*(w_b + h_b)/12 + m_bat*dz_b;
Jyb = m_bat*(d_b + h_b)/12 + m_bat*dz_b;
Jzb = m_bat*(w_b + d_b)/12;
Jb = zeros(3);
Jb(1,1) = Jxb; Jb(2,2) = Jyb; Jb(3,3) = Jzb;
clear m_bat w_b d_b h_b h_h Jxb Jyb Jzb dz_b;
clear alpha beta cos_b sin_b


J = Jm + Je + Ja + Jh + Jb;
fprintf('Inertia Matrix: \n')
disp(J)

%fprintf('Jm\n'); disp(Jm);
%fprintf('Je\n'); disp(Je);
%fprintf('Ja\n'); disp(Ja);
%fprintf('Jh\n'); disp(Jh);
%fprintf('Jb\n'); disp(Jb);
