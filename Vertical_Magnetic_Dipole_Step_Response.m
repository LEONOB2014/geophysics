%% ......function description
% function name :Vertical_Magnetic_Dipole_Step_Response
% @u0������еĴŵ���
% @rou����ص�����
% @m��������Ȧ�ž�
% @xr�����ܵ�x������
% @yr�����ܵ�y������
% @zr�����ܵ�z������
% @Tob���۲�ʱ��
% @step_response_H01������Ծ��Ӧ
% @step_response_H10������Ծ��Ӧ
% @impluse_response_H����������Ӧ
% @step_response_E������Ծ��Ӧ
% ����Ծ�͸���Ծ���Ǽ򵥵ķ����෴�Ĺ�ϵ
function [step_response_H01,step_response_H10,impluse_response_H,step_response_E10,step_response_Hr10] = Vertical_Magnetic_Dipole_Step_Response(u0,rou,m,xr,yr,zr,Tob)
r = (xr.^2+yr.^2+zr.^2).^0.5;
% alph = (u0./rou).^0.5.*r;
sita = (u0./rou./Tob).^(0.5)./2;
temp = sita.*r;
Hcoeff = -m./4./pi./r^3;
Hrcoeff = m.*temp.^2./2./pi./r.^3;
Ecoeff = -m.*rou./2./pi./r^4;
step_response_H01 = Hcoeff.*(erf(temp).*9./2./temp.^2+erfc(temp)-exp(-temp.^2)./pi^0.5.*(4.*temp+9./temp));
step_response_H01 = [0 step_response_H01(1:length(Tob)-1) ];
step_response_H10 = -Hcoeff.*(erf(temp).*9./2./temp.^2-erf(temp)-exp(-temp.^2)./pi^0.5.*(4.*temp+9./temp));
step_response_H10 = [Hcoeff  step_response_H10(1:length(Tob)-1) ];
impluse_response_H = m.*rou./(2*pi*u0*r.^5).*(9.*erf(temp)-2.*temp./pi.^0.5.*(9+6.*temp.^2+4.*temp.^4).*exp(-temp.^2));
impluse_response_H = [0 impluse_response_H(1:length(Tob)-1) ];
step_response_E01 = Ecoeff.*(3.*erf(temp)-2.*temp.*(3+2.*temp.^2).*exp(-temp.^2)./pi^0.5);
step_response_E01 = [ 3*Ecoeff  step_response_E01(1:length(Tob)-1)];
 step_response_E10 =- step_response_E01;
I1 = besseli(1,(temp.^2)/2);
I2 = besseli(2,(temp.^2)/2);
step_response_Hr10 = Hrcoeff.*exp(-(temp.^2)/2).*(I1-I2);
step_response_Hr10 = [0 step_response_Hr10(1:length(Tob)-1)];
end