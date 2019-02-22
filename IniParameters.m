function [hObject, handles] = IniParameters( hObject, handles )
%INIPARAMETERS Summary of this function goes here
%   Detailed explanation goes here

%以下是默认的检测参数与默认的模型系数

handles.Para.Start = 200000;
handles.Para.End = 201000;
handles.Para.PWP = 0.2;
handles.Para.PWT = 50;
handles.Para.ECGP = 0.2;
handles.Para.ECGT = 50;
handles.Para.ECGTH = 1e-5;
handles.outPWTT = '';
handles.outHR = '';
handles.Para.a0 = 0.0015;
handles.Para.a1 = 0.5384;
handles.Para.a2 = 173.1892;
handles.Para.b0 = 0.00057926;
handles.Para.b1 = 0.7027;
handles.Para.b2 = -57.5344;
handles.FinalResult.index =1;

set(handles.edit_Start,'string', handles.Para.Start);
set(handles.edit_End,'string', handles.Para.End );
set(handles.edit_PWP,'string', handles.Para.PWP);
set(handles.edit_PWT,'string', handles.Para.PWT);
set(handles.edit_ECGP,'string', handles.Para.ECGP);
set(handles.edit_ECGT,'string', handles.Para.ECGT);
set(handles.edit_ECGTH,'string', handles.Para.ECGTH);
set(handles.edit_a0,'string', handles.Para.a0);
set(handles.edit_a1,'string', handles.Para.a1);
set(handles.edit_a2,'string', handles.Para.a2);
set(handles.edit_b0,'string', handles.Para.b0);
set(handles.edit_b1,'string', handles.Para.b1);
set(handles.edit_b2,'string', handles.Para.b2);

%guidata(hObject, handles);
end

