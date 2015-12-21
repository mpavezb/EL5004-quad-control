function [] = quadPlots(yout,tout)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %{
 This simple function plots state variables produced via the quadcopter
 simulation

    Additional quadcopter modeling and simulation materials available at:
    github.com/dch33/Quad-Sim

Copyright (C) 2014 D. Hartman, K. Landis, S. Moreno, J. Kim, M. Mehrer

License:
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU LESSER GENERAL PUBLIC LICENSE
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clc;
[~,column] = size(yout);
if column==26
    PC = true;
else PC = false;
end
A = yout;
T = tout;
t = T;
P = A(:,1); % rad/s for now, converted before plotting
Q = A(:,2);
R = A(:,3);
Phi   = A(:,4); % In radians for now, converted before plotting
Theta = A(:,5);
Psi   = A(:,6);
Phi_cmd = A(:,21);
Theta_cmd = A(:,22);
Psi_cmd = A(:,23);
U = A(:,7);
V = A(:,8);
W = A(:,9);
X = A(:,10);
Y = A(:,11);
Z = A(:,12);
Z_cmd   = A(:,24);
w1 = A(:,13);
w2 = A(:,14);
w3 = A(:,15);
w4 = A(:,16);
mc1 = A(:,17);
mc2 = A(:,18);
mc3 = A(:,19);
mc4 = A(:,20);
if (PC==true)
X_cmd = A(:,25);
Y_cmd = A(:,26);
end

figure
hold on
plot(T,Psi*180/pi,'b')
plot(T,Psi_cmd*180/pi,'r--')
hold off
xlabel('tiempo [s]','Interpreter','latex','FontSize',12);
ylabel('\''angulo [deg]','Interpreter','latex','FontSize',12);
xlim([min(t) max(t)]);
ylim([-20 20]);
legend('simulación','referencia')
title('Simulaci\''on de control de yaw (giro en Z)','Interpreter','latex','FontSize',14);
grid on

%save('pidR_vf','t','T','Psi','Psi_cmd')


figure
hold on
plot(T,Theta*180/pi,'b')
plot(T,Theta_cmd*180/pi,'r--')
hold off
xlabel('tiempo [s]','Interpreter','latex','FontSize',12);
ylabel('\''angulo [deg]','Interpreter','latex','FontSize',12);
xlim([min(t) max(t)]);
ylim([-20 20]);
legend('simulación','referencia')
title('Simulaci\''on de control de pitch (giro en Y)','Interpreter','latex','FontSize',14);
grid on

%save('pidQ_vf','t','T','Theta','Theta_cmd')

figure
hold on
plot(T,Phi*180/pi,'b')
plot(T,Phi_cmd*180/pi,'r--')
hold off
xlabel('tiempo [s]','Interpreter','latex','FontSize',12);
ylabel('\''angulo [deg]','Interpreter','latex','FontSize',12);
xlim([min(t) max(t)]);
ylim([-20 20]);
legend('simulación','referencia')
title('Simulaci\''on de control de roll (giro en X)','Interpreter','latex','FontSize',14);
grid on

%save('pidP_vf','t','T','Phi','Phi_cmd')



% Plots ___________________________________________________________________
figure
subplot(4,3,1)
plot(T,P,'b')
xlabel('Time (s)')
ylabel('Angular Velocity (deg/sec)')
xlim([min(t) max(t)])
title('P')
grid on

subplot(4,3,2)
plot(T,Q,'r')
xlabel('Time (s)')
ylabel('Angular Velocity (deg/sec)')
xlim([min(t) max(t)])
title('Q')
grid on

subplot(4,3,3)
plot(T,R,'g')
xlabel('Time (s)')
ylabel('Angular Velocity (deg/sec)')
xlim([min(t) max(t)])
title('R')
grid on

subplot(4,3,4)
plot(T,Phi*180/pi,'b')
hold on
plot(T,Phi_cmd*180/pi,'k--')
hold off
xlabel('Time (s)')
ylabel('Angle (deg)')
xlim([min(t) max(t)])
title('Phi')
grid on
 
subplot(4,3,5)
plot(T,Theta*180/pi,'r')
hold on
plot(T,Theta_cmd*180/pi,'k--')
hold off
xlabel('Time (s)')
ylabel('Angle(deg)')
xlim([min(t) max(t)])
title('Theta')
grid on

subplot(4,3,6)
plot(T,Psi*180/pi,'g')
hold on
plot(T,Psi_cmd*180/pi,'k--')
hold off
xlabel('Time (s)')
ylabel('Angle (deg)')
xlim([min(t) max(t)])
title('Psi')
grid on

subplot(4,3,7)
plot(T,U,'b')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
xlim([min(t) max(t)])
title('U')
grid on

subplot(4,3,8)
plot(T,V,'r')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
xlim([min(t) max(t)])
title('V')
grid on

subplot(4,3,9)
plot(T,W,'g')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
xlim([min(t) max(t)])
title('W')
grid on

subplot(4,3,10)
plot(T,X,'b')
if (PC==true)
hold on
plot(T,X_cmd,'k--')
hold off
end
xlabel('Time (s)')
ylabel('Position (m)')
xlim([min(t) max(t)])
title('X')
grid on

subplot(4,3,11)
plot(T,Y,'r')
if (PC==true)
hold on
plot(T,Y_cmd,'k--')
hold off
end
xlabel('Time (s)')
ylabel('Position (m)')
xlim([min(t) max(t)])
title('Y')
grid on

subplot(4,3,12)
plot(T,Z,'g')
hold on
plot(T,Z_cmd,'k--')
hold off
xlabel('Time (s)')
ylabel('Position (m)')
xlim([min(t) max(t)])
title('Z')
grid on

figure
plot(T,Z,'b')
hold on
plot(T,Z_cmd,'r--')
hold off
xlabel('tiempo [s]','Interpreter','latex','FontSize',12);
ylabel('altura [m]','Interpreter','latex','FontSize',12);
xlim([min(t) max(t)]);
ylim([0 1.7]);
legend('simulación','referencia')
title('Simulaci\''on de control de altura (eje Z)','Interpreter','latex','FontSize',14);
grid on


%save('pidz_v1','t','T','Z','Z_cmd')

figure
[AX,H1,H2] = plotyy(T,mc1,T,w1);
xlabel('tiempo [s]','Interpreter','latex','FontSize',12)
ylabel(AX(1),'Throttle [\%]','Interpreter','latex','FontSize',12)
ylabel(AX(2),'Velocidad [RPM]','Interpreter','latex','FontSize',12)
xlim(AX(1),[min(T) max(T)])
xlim(AX(2),[min(T) max(T)])
title('Respuesta de motor 1','Interpreter','latex','FontSize',14)
grid on

% Create a new figure for motor speeds
figure
subplot(4,1,1)
[AX,H1,H2] = plotyy(T,mc1,T,w1);
xlabel('tiempo [s]')
ylabel(AX(1),'Throttle [%]')
ylabel(AX(2),'Velocidad [RPM]')
xlim(AX(1),[min(T) max(T)/2])
xlim(AX(2),[min(T) max(T)/2])
title('Motor 1')
grid on

subplot(4,1,2)
[AX,H1,H2] = plotyy(T,mc2,T,w2);
xlabel('tiempo [s]')
ylabel(AX(1),'Throttle [%]')
ylabel(AX(2),'Velocidad [RPM]')
xlim(AX(1),[min(T) max(T)/2])
xlim(AX(2),[min(T) max(T)/2])
title('Motor 2')
grid on

subplot(4,1,3)
[AX,H1,H2] = plotyy(T,mc3,T,w3);
xlabel('tiempo [s]')
ylabel(AX(1),'Throttle [%]')
ylabel(AX(2),'Velocidad [RPM]')
xlim(AX(1),[min(T) max(T)/2])
xlim(AX(2),[min(T) max(T)/2])
title('Motor 3')
grid on

subplot(4,1,4)
[AX,H1,H2] = plotyy(T,mc4,T,w4);
xlabel('tiempo [s]')
ylabel(AX(1),'Throttle [%]')
ylabel(AX(2),'Velocidad [RPM]')
xlim(AX(1),[min(T) max(T)/2])
xlim(AX(2),[min(T) max(T)/2])
title('Motor 4')
grid on
end
