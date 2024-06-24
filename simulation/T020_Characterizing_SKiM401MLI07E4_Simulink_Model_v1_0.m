%% Three Level IGBT Characterization
Three_Level_IGBT.Typ_Off.x=[200,400,500];
Three_Level_IGBT.Typ_Off.y=[30,57.5,69];

Three_Level_IGBT.Typ_On.x=[100,200,400,450,500];
Three_Level_IGBT.Typ_On.y=[11.5,20,41.5,50,60];

Three_Level_IGBT.Output_Charc.C25.x=[0,0.7,0.85,0.9,1.4,2,2.46];
Three_Level_IGBT.Output_Charc.C25.y=[0,0.01,25,50,150,300,450];

Three_Level_IGBT.Output_Charc.C90.x=[0,0.6,0.775,0.925,1.53,2.35,2.83];
Three_Level_IGBT.Output_Charc.C90.y=[0,0.01,25,50,150,300,450];

Three_Level_IGBT.Output_Charc.C150.x=[0,0.5,0.7,0.95,1.66,2.5,3.2];
Three_Level_IGBT.Output_Charc.C150.y=[0,0.01,25,50,150,300,450];

%% Managing Variables for Simulink Model
TurnonIGBT.Vcc=600; %V
TurnonIGBT.Tj=[25 90 150]; %Celcius
TurnonIGBT.Eon=[Three_Level_IGBT.Typ_On.y;Three_Level_IGBT.Typ_On.y;Three_Level_IGBT.Typ_On.y];
TurnonIGBT.Ic=Three_Level_IGBT.Typ_On.x; %Ic

TurnoffIGBT.Vcc=600; %V
TurnoffIGBT.Tj=[25 90 150]; %Celcius
TurnoffIGBT.Eoff=[Three_Level_IGBT.Typ_Off.y;Three_Level_IGBT.Typ_Off.y;Three_Level_IGBT.Typ_Off.y];
TurnoffIGBT.Ic=Three_Level_IGBT.Typ_Off.x; %Ic

% Add a row with 0 values for Eon and Eoff
TurnonIGBT.E0_On=zeros(1,length(TurnonIGBT.Eon));
TurnonIGBT.Esw_On(:,:,1)=[TurnonIGBT.E0_On;TurnonIGBT.Eon(1,:)];
TurnonIGBT.Esw_On(:,:,2)=[TurnonIGBT.E0_On;TurnonIGBT.Eon(2,:)];
TurnonIGBT.Esw_On(:,:,3)=[TurnonIGBT.E0_On;TurnonIGBT.Eon(3,:)];
TurnoffIGBT.E0_Off=zeros(1,length(TurnoffIGBT.Eoff));
TurnoffIGBT.Esw_Off(:,:,1)=[TurnoffIGBT.E0_Off;TurnoffIGBT.Eoff(1,:)];
TurnoffIGBT.Esw_Off(:,:,2)=[TurnoffIGBT.E0_Off;TurnoffIGBT.Eoff(2,:)];
TurnoffIGBT.Esw_Off(:,:,3)=[TurnoffIGBT.E0_Off;TurnoffIGBT.Eoff(3,:)];
% Create a two-element vector for Vcc (first value = 0)
TurnonIGBT.Vcc_Esw_On=[0 TurnonIGBT.Vcc];
TurnoffIGBT.Vcc_Esw_Off=[0 TurnoffIGBT.Vcc];

% Conduction Loss Parameters
Cond_Loss_IGBT.Tj=[25 90 150];
Cond_Loss_IGBT.Vce=[Three_Level_IGBT.Output_Charc.C25.x;Three_Level_IGBT.Output_Charc.C90.x;Three_Level_IGBT.Output_Charc.C150.x];
Cond_Loss_IGBT.Ic=Three_Level_IGBT.Output_Charc.C150.y;

%% Three Level Diode Characterization
Three_Level_Diode.Err.x=[100,200,300,400,500];
Three_Level_Diode.Err.y=[12,16.5,19.5,21,21.5];

Three_Level_Diode.Diode_For_Char.C25.x=[0,0.7,1.25,1.7,2.1,2.3,3.2];
Three_Level_Diode.Diode_For_Char.C25.y=[0,0.01,50,100,200,300,600];

Three_Level_Diode.Diode_For_Char.C90.x=[0,0.6,1.075,1.55,1.95,2.3,3.3];
Three_Level_Diode.Diode_For_Char.C90.y=[0,0.01,50,100,200,300,600];

Three_Level_Diode.Diode_For_Char.C150.x=[0,0.5,0.9,1.4,1.8,2.3,3.4];
Three_Level_Diode.Diode_For_Char.C150.y=[0,0.01,50,100,200,300,600];

%% Diode Reverse Recovery Loss
Reverse_Rec_Diode.Vcc_Esw_Erec=600; %V
Reverse_Rec_Diode.Erec=[Three_Level_Diode.Err.y;Three_Level_Diode.Err.y;Three_Level_Diode.Err.y];
Reverse_Rec_Diode.DIODE_If_Erec=Three_Level_Diode.Err.x; %A
Reverse_Rec_Diode.DIODE_Tj_Erec=[25 90 150]; %Celcius

Cond_Diode.Vcc=600; %V
Cond_Diode.Tj=[25 90 150]; %Celcius
Cond_Diode.Esw_Off=[Three_Level_Diode.Diode_For_Char.C25.x;Three_Level_Diode.Diode_For_Char.C90.x;Three_Level_Diode.Diode_For_Char.C150.x];%V
Cond_Diode.Ic=Three_Level_Diode.Diode_For_Char.C25.y; %Ic

% Add a row with 0 values for Erec
Reverse_Rec_Diode.E0_Erec=zeros(1,length(Reverse_Rec_Diode.Erec));
Reverse_Rec_Diode.Esw_Erec(:,:,1)=[Reverse_Rec_Diode.E0_Erec;Reverse_Rec_Diode.Erec(1,:)];
Reverse_Rec_Diode.Esw_Erec(:,:,2)=[Reverse_Rec_Diode.E0_Erec;Reverse_Rec_Diode.Erec(2,:)];
Reverse_Rec_Diode.Esw_Erec(:,:,3)=[Reverse_Rec_Diode.E0_Erec;Reverse_Rec_Diode.Erec(3,:)];
% Create a two-element vector for Vcc (first value = 0)
Reverse_Rec_Diode.Vcc_Esw_Erec=[0 Reverse_Rec_Diode.Vcc_Esw_Erec];

% Conduction Loss Parameters
Cond_Loss_Diode.Tj=[25 90 150];
Cond_Loss_Diode.Vce=[Three_Level_Diode.Diode_For_Char.C25.x;Three_Level_Diode.Diode_For_Char.C90.x;Three_Level_Diode.Diode_For_Char.C150.x];
Cond_Loss_Diode.Ic=Three_Level_Diode.Diode_For_Char.C25.y;