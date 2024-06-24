IGBT_Rth_jc=0.051;%Junction-to-Case thermal resistance
IGBT_Cth_j=2.6804;%Joule/Kelvin
DIODE_Rth_jc=0.102;%Junction-to-Case thermal resistance
DIODE_Cth_j=1.3235;%Joule/Kelvin
Tj0=150;
%
Zth_IGBT=[IGBT_Rth_jc IGBT_Cth_j];
Zth_Diode=[DIODE_Rth_jc DIODE_Cth_j];
Rth_IGBT= Zth_IGBT(1);
Cth_IGBT= Zth_IGBT(2);
Rth_Diode= Zth_Diode(1);
Cth_Diode= Zth_Diode(2);
%
Ac_IGBT= -1/(Rth_IGBT*Cth_IGBT);
Bc_IGBT= [ 1/(Rth_IGBT*Cth_IGBT)  1/Cth_IGBT ];
Cc_IGBT= [ 1; 1/Rth_IGBT ];
Dc_IGBT= [ 0  0; -1/Rth_IGBT 0 ];
%
Ac_Diode= -1/(Rth_Diode*Cth_Diode);
Bc_Diode= [ 1/(Rth_Diode*Cth_Diode)  1/Cth_Diode ];
Cc_Diode= [ 1; 1/Rth_Diode ];
Dc_Diode= [ 0  0; -1/Rth_Diode 0 ];
%
x0c=Tj0;
%
%  Conversion to discrete transfer function
nstates = size(Ac_IGBT,1);
invexp = inv(eye(nstates) - (Ts/2)*Ac_IGBT);
Ad_IGBT = invexp*(eye(nstates) + (Ts/2)*Ac_IGBT);
Bd_IGBT = invexp*Bc_IGBT;
Cd_IGBT = Cc_IGBT*invexp*Ts;
Dd_IGBT = Cc_IGBT*invexp*Bc_IGBT*(Ts/2) + Dc_IGBT;
%
x0c=Tj0;
I=eye(size(Ac_IGBT));
x0d=(I-Ac_IGBT*Ts/2)*x0c/Ts;
%
%  Conversion to discrete transfer function
nstates = size(Ac_Diode,1);
invexp = inv(eye(nstates) - (Ts/2)*Ac_Diode);
Ad_Diode = invexp*(eye(nstates) + (Ts/2)*Ac_Diode);
Bd_Diode = invexp*Bc_Diode;
Cd_Diode = Cc_Diode*invexp*Ts;
Dd_Diode = Cc_Diode*invexp*Bc_Diode*(Ts/2) + Dc_Diode;
% 
