function varargout = BPForcastBasedOnPWV_HR(varargin)
% BPFORCASTBASEDONPWV_HR MATLAB code for BPForcastBasedOnPWV_HR.fig
%      BPFORCASTBASEDONPWV_HR, by itself, creates a new BPFORCASTBASEDONPWV_HR or raises the existing
%      singleton*.
%
%      H = BPFORCASTBASEDONPWV_HR returns the handle to a new BPFORCASTBASEDONPWV_HR or the handle to
%      the existing singleton*.
%
%      BPFORCASTBASEDONPWV_HR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BPFORCASTBASEDONPWV_HR.M with the given input arguments.
%
%      BPFORCASTBASEDONPWV_HR('Property','Value',...) creates a new BPFORCASTBASEDONPWV_HR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BPForcastBasedOnPWV_HR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BPForcastBasedOnPWV_HR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BPForcastBasedOnPWV_HR

% Last Modified by GUIDE v2.5 03-Jun-2018 15:28:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BPForcastBasedOnPWV_HR_OpeningFcn, ...
                   'gui_OutputFcn',  @BPForcastBasedOnPWV_HR_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BPForcastBasedOnPWV_HR is made visible.
function BPForcastBasedOnPWV_HR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BPForcastBasedOnPWV_HR (see VARARGIN)

% Choose default command line output for BPForcastBasedOnPWV_HR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BPForcastBasedOnPWV_HR wait for user response (see UIRESUME)
% uiwait(handles.figure1);

[hObject, handles] = IniParameters( hObject, handles );

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = BPForcastBasedOnPWV_HR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Edit_FeatFileName_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_FeatFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_FeatFileName as text
%        str2double(get(hObject,'String')) returns contents of Edit_FeatFileName as a double


% --- Executes during object creation, after setting all properties.
function Edit_FeatFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_FeatFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_getTrainFile.
function btn_getTrainFile_Callback(hObject, eventdata, handles)
% hObject    handle to btn_getTrainFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName] = uigetfile('*.mat');
handles.FeatFileName = strcat(PathName,FileName);

load(handles.FeatFileName);

axes(handles.axes_PW);
% findpeaks(data(1,datastart(2) : dataend(2) ),'MinPeakDistance',100,'MinPeakHeight' ,0.015);
findpeaks(val(3,:),'MinPeakDistance',50,'MinPeakHeight' ,100);
    hold on
   refline(0, 100)%refline(slope,intercept)
   hold off
[pksPW,locsPW] = findpeaks(val(3,:),'MinPeakDistance',50,'MinPeakHeight' ,100);  %,'MinPeakDistance',0.005,

axes(handles.axes_ECG);
findpeaks(val(1,:),'MinPeakDistance',50,'MinPeakHeight' ,600);
    hold on
   refline(0, 600)%refline(slope,intercept)
   hold off
[pksECG,locsECG] = findpeaks(val(1,:),'MinPeakDistance',50,'MinPeakHeight' ,600);
set(handles.Edit_FeatFileName,'string', handles.FeatFileName);

axes(handles.axes_ABP);
findpeaks(val(2,:),'MinPeakDistance',50,'MinPeakHeight' ,90);

guidata(hObject, handles);


function edit_Start_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Start as text
%        str2double(get(hObject,'String')) returns contents of edit_Start as a double
A = str2double(get(handles.edit_Start,'String'));
handles.Para.Start = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_Start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_End_Callback(hObject, eventdata, handles)
% hObject    handle to edit_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_End as text
%        str2double(get(hObject,'String')) returns contents of edit_End as a double
A = str2double(get(handles.edit_End,'String'));
handles.Para.End = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_End_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PWP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PWP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PWP as text
%        str2double(get(hObject,'String')) returns contents of edit_PWP as a double
A = str2double(get(handles.edit_PWP,'String'));
handles.Para.PWP = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_PWP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PWP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PWT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PWT as text
%        str2double(get(hObject,'String')) returns contents of edit_PWT as a double
A = str2double(get(handles.edit_PWT,'String'));
handles.Para.PWT = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_PWT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ECGP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ECGP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ECGP as text
%        str2double(get(hObject,'String')) returns contents of edit_ECGP as a double
A = str2double(get(handles.edit_ECGP,'String'));
handles.Para.ECGP = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ECGP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ECGP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ECGT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ECGT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ECGT as text
%        str2double(get(hObject,'String')) returns contents of edit_ECGT as a double
A = str2double(get(handles.edit_ECGT,'String'));
handles.Para.ECGT = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ECGT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ECGT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Run.
function btn_Run_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hwait=waitbar(0 ,'加载数据>>>>>>>>');
load(handles.FeatFileName);
clear pksPW locsPW pksECG locsECG

if handles.Para.Start == 0 && handles.Para.End == 0
% waitbar(10/100,hwait ,'血压显示与计算>>>>>>>>');
val(2,:) = preprocess(val(2,:),3,handles.FeatFileName); %标度转换 详情看plotATM中的方法
 
%  hwait=waitbar(0 ,'加载数据>>>>>>>>');
 waitbar(20/100,hwait ,'数据预处理>>>>>>>>');

val(1,:) = preprocess(val(1,:),2,handles.FeatFileName);

val(3,:) = preprocess(val(3,:),1,handles.FeatFileName);

else
    % waitbar(10/100,hwait ,'血压显示与计算>>>>>>>>');
val(2,:) = preprocess(val(2,handles.Para.Start:handles.Para.End),3,handles.FeatFileName); %标度转换 详情看plotATM中的方法
 
%  hwait=waitbar(0 ,'加载数据>>>>>>>>');
 waitbar(20/100,hwait ,'数据预处理>>>>>>>>');

val(1,handles.Para.Start:handles.Para.End) = preprocess(val(1,handles.Para.Start:handles.Para.End),2,handles.FeatFileName);

val(3,handles.Para.Start:handles.Para.End) = preprocess(val(3,handles.Para.Start:handles.Para.End),1,handles.FeatFileName);
end


waitbar(85/100,hwait ,'峰值检测>>>>>>>>');



if get(handles.checkbox_ECGTH,'value') %使用跳变阈值 Threshold 暂未改
        if handles.Para.Start == 0 && handles.Para.End == 0
            axes(handles.axes_PW);
            findpeaks(data(1,datastart(2) : dataend(2) ),'MinPeakDistance',handles.Para.PWT,'MinPeakHeight' ,handles.Para.PWP);
            hold on
           refline(0,handles.Para.PWP)%refline(slope,intercept)
           hold off
            [pksPW,locsPW] = findpeaks(data(1,datastart(2):dataend(2) ),'MinPeakDistance',handles.Para.PWT,'MinPeakHeight' ,handles.Para.PWP);  %,'MinPeakDistance',0.005,

            axes(handles.axes_ECG);
            findpeaks(data(1,datastart(3):dataend(3) ),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP,'Threshold',handles.Para.ECGTH);
                hold on
           refline(0,handles.Para.ECGP)%refline(slope,intercept)
           hold off
            [pksECG,locsECG] = findpeaks(data(1,datastart(3):dataend(3) ),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP,'Threshold',handles.Para.ECGTH,'Threshold',handles.Para.ECGTH);
        else
            axes(handles.axes_PW);
            findpeaks(val(3,:),'MinPeakDistance',handles.Para.PWT,'MinPeakHeight' ,handles.Para.PWP);
                hold on
                refline(0,handles.Para.PWP)%refline(slope,intercept)
                hold off
            [pksPW,locsPW] =     findpeaks(val(3,:),'MinPeakDistance',handles.Para.PWT,'MinPeakHeight' ,handles.Para.PWP);

            axes(handles.axes_ECG);
            findpeaks(val(1,:),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP,'Threshold',handles.Para.ECGTH);
               hold on
           refline(0,handles.Para.ECGP)%refline(slope,intercept)
           hold off
            [pksECG,locsECG] =     findpeaks(val(1,:),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP,'Threshold',handles.Para.ECGTH);
        end
else  %不需要跳变阈值
    if handles.Para.Start == 0 && handles.Para.End == 0
            axes(handles.axes_PW);
            findpeaks(val(3,:),'MinPeakDistance',handles.Para.PWT,'MinPeakHeight' ,handles.Para.PWP);
            hold on
           refline(0,handles.Para.PWP)%refline(slope,intercept)
           hold off
            [pksPW,locsPW] = findpeaks(val(3,:),'MinPeakDistance',handles.Para.PWT,'MinPeakHeight' ,handles.Para.PWP);  %,'MinPeakDistance',0.005,

           axes(handles.axes_ECG);
           findpeaks(val(1,:),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
           hold on
           refline(0,handles.Para.ECGP)%refline(slope,intercept)
           hold off
            [pksECG,locsECG] = findpeaks(val(1,:),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
            
            axes(handles.axes_ABP);
            findpeaks(val(2,:),'MinPeakDistance',50,'MinPeakHeight' ,90);
            %SYSTOLIC PRESSOR 收缩压
            [pksSP,locsABP1] = findpeaks(val(2,:),'MinPeakDistance',50,'MinPeakHeight' ,90);
            [pksDP,locsABP2] = findpeaks(-val(2,:),'MinPeakDistance',50,'MinPeakHeight' ,-90);
            pksDP = -pksDP;
            
        else
            axes(handles.axes_PW);
            findpeaks(val(3,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
            hold on
            refline(0,handles.Para.PWP)%refline(slope,intercept)
            hold off
            [pksPW,locsPW] = findpeaks(val(3,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);

            axes(handles.axes_ECG);
            findpeaks(val(1,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
            hold on
            refline(0,handles.Para.ECGP)%refline(slope,intercept)
            hold off
            [pksECG,locsECG] =     findpeaks(val(1,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
            
            axes(handles.axes_ABP);
            findpeaks(val(2,handles.Para.Start : handles.Para.End),'MinPeakDistance',50,'MinPeakHeight' ,90);
            %SYSTOLIC PRESSOR 收缩压
            [pksSP,locsABP1] = findpeaks(val(2,handles.Para.Start : handles.Para.End),'MinPeakDistance',50,'MinPeakHeight' ,90);
            [pksDP,locsABP2] = findpeaks(-val(2,handles.Para.Start : handles.Para.End),'MinPeakDistance',50,'MinPeakHeight' ,-90);
            pksDP = -pksDP;
            
        end
end

waitbar(95/100,hwait ,'正在计算PWTT HR ABP>>>>>>>>');
samplerate = 125;

%保证ECG信号在前，去掉没用的最前面的PW波
if locsECG(1) > locsPW(1)
    locsPW = locsPW(2:length(locsPW));
end

%保证PW信号在后，去掉没用的最后面的ECG波
if locsECG(length(locsECG)) > locsPW(length(locsPW))
     locsECG = locsECG(1:(length(locsECG)-1));
end
    
 %先有ECG后有PW  ECG多砍后面  PW多 砍前面   
if length(locsPW) - length(locsECG)==1
    locsPW = locsPW(2:length(locsPW));
    
elseif length(locsPW) - length(locsECG)==-1
    locsECG = locsECG(1:(length(locsECG)-1));
    
elseif length(locsPW) - length(locsECG)>1 | length(locsPW) - length(locsECG)<-1
    msgbox('数据错误，请调整后再试');

end

%开始计算
if length(locsPW) == length(locsECG)
    %传递时间计算
    time = (locsPW - locsECG) ./ samplerate;
    handles.Result.PWTT = sum(time) / length(time);%Pulse Wave Transit Time

    set(handles.edit_PWTT,'string', handles.Result.PWTT);

    %心率计算
    HRtmp = 0;
    for i=2:1:length(locsECG)
       HRtmp(i-1) = 60/ ( (locsECG(i) - locsECG(i-1))/ samplerate);  %每次心跳的时间间隔计算出每一个心率
    end
    handles.Result.HR = sum(HRtmp) / length(HRtmp);%求平均值
    
    set(handles.edit_HR,'string', handles.Result.HR);
    
    %平均血压计算
     handles.Result.rSP = sum(pksSP) / length(pksSP);%求平均值
     handles.Result.rDP = sum(pksDP) / length(pksDP);%求平均值

     set(handles.edit_ABPSP,'string', handles.Result.rSP);
     set(handles.edit_ABPDP,'string', handles.Result.rDP);

else
    handles.Result.PWTT = 0;
    handles.Result.HR = 0;
    handles.Result.rSP = 0;
     handles.Result.rDP = 0;
    set(handles.edit_PWTT,'string', '');
    set(handles.edit_HR,'string', '');
    msgbox('两组数据检测的顶点个数不一样，请调整后再试');
end
close(hwait);
guidata(hObject, handles);

function edit_PWTT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PWTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PWTT as text
%        str2double(get(hObject,'String')) returns contents of edit_PWTT as a double


% --- Executes during object creation, after setting all properties.
function edit_PWTT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PWTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_HR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_HR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_HR as text
%        str2double(get(hObject,'String')) returns contents of edit_HR as a double


% --- Executes during object creation, after setting all properties.
function edit_HR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_HR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PWTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PWTT as text
%        str2double(get(hObject,'String')) returns contents of edit_PWTT as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PWTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit_HR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_HR as text
%        str2double(get(hObject,'String')) returns contents of edit_HR as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_HR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Record.
function btn_Record_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.outPWTT = strcat(handles.outPWTT,',' , num2str(handles.Result.PWTT));
if handles.Result.PWTT==0 && handles.Result.HR==0
        msgbox('无有效结果，请调整后再试');
        return;
end
handles.FinalResult.PWTT(handles.FinalResult.index) = handles.Result.PWTT;
handles.FinalResult.HR(handles.FinalResult.index) = handles.Result.HR;

handles.FinalResult.SP(handles.FinalResult.index) = handles.Result.rSP;
handles.FinalResult.DP(handles.FinalResult.index) = handles.Result.rDP;
handles.FinalResult.index = handles.FinalResult.index + 1;

if isempty(handles.outPWTT) && isempty(handles.outHR)
    handles.outPWTT = num2str(handles.Result.PWTT);
    handles.outHR = num2str(handles.Result.HR);
    
    handles.outSP = num2str(handles.Result.rSP);
    handles.outDP = num2str(handles.Result.rDP);
else
    handles.outPWTT = [handles.outPWTT,',' , num2str(handles.Result.PWTT)];
    handles.outHR = strcat(handles.outHR,','  , num2str(handles.Result.HR));
    
    handles.outSP= strcat(handles.outSP,','  , num2str(handles.Result.rSP));
    handles.outDP = strcat(handles.outDP,','  , num2str(handles.Result.rDP));
end

set(handles.edit_ResPWTT,'string', strcat(' PWTT = [',handles.outPWTT, ']' ));
set(handles.edit_ResHR,'string',  strcat(' HR = [',handles.outHR , ']'));

set(handles.edit_ResSP,'string',  strcat(' SP = [',handles.outSP , ']'));
set(handles.edit_ResDP,'string',  strcat(' DP = [',handles.outDP , ']'));

guidata(hObject, handles);

function edit_ResPWTT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ResPWTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ResPWTT as text
%        str2double(get(hObject,'String')) returns contents of edit_ResPWTT as a double


% --- Executes during object creation, after setting all properties.
function edit_ResPWTT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ResPWTT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ResHR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ResHR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ResHR as text
%        str2double(get(hObject,'String')) returns contents of edit_ResHR as a double


% --- Executes during object creation, after setting all properties.
function edit_ResHR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ResHR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b0 as text
%        str2double(get(hObject,'String')) returns contents of edit_b0 as a double
A = str2double(get(handles.edit_b0,'String'));
handles.Para.b0 = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_b0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b1 as text
%        str2double(get(hObject,'String')) returns contents of edit_b1 as a double
A = str2double(get(handles.edit_b1,'String'));
handles.Para.b1 = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b2 as text
%        str2double(get(hObject,'String')) returns contents of edit_b2 as a double
A = str2double(get(handles.edit_b2,'String'));
handles.Para.b2 = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ForcastDP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ForcastDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ForcastDP as text
%        str2double(get(hObject,'String')) returns contents of edit_ForcastDP as a double


% --- Executes during object creation, after setting all properties.
function edit_ForcastDP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ForcastDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Forcast.
function btn_Forcast_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Forcast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.Result.PWTT==0 && handles.Result.HR==0
        msgbox('无有效结果，请调整后再试');
        return;
end
handles.Forcast.SP = handles.Para.a0 + handles.Para.a1 * handles.Result.HR + handles.Para.a2 * handles.Result.PWTT;
handles.Forcast.DP = handles.Para.b0 + handles.Para.b1 * handles.Result.HR + handles.Para.b2 * handles.Result.PWTT;
set(handles.edit_ForcastSP,'string', handles.Forcast.SP);
set(handles.edit_ForcastDP,'string', handles.Forcast.DP);
guidata(hObject, handles);


% --- Executes on button press in btn_FeatModel.
function btn_FeatModel_Callback(hObject, eventdata, handles)
% hObject    handle to btn_FeatModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
% msgbox('敬请期待');
% realTimeBP();
guidata(hObject, handles);



function edit_ECGTH_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ECGTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ECGTH as text
%        str2double(get(hObject,'String')) returns contents of edit_ECGTH as a double
A = str2double(get(handles.edit_ECGTH,'String'));
handles.Para.ECGTH = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_ECGTH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ECGTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_ECGTH.
function checkbox_ECGTH_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ECGTH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ECGTH



function edit_ForcastSP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ForcastSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ForcastSP as text
%        str2double(get(hObject,'String')) returns contents of edit_ForcastSP as a double


% --- Executes during object creation, after setting all properties.
function edit_ForcastSP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ForcastSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a0 as text
%        str2double(get(hObject,'String')) returns contents of edit_a0 as a double
A = str2double(get(handles.edit_a0,'String'));
handles.Para.a0 = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_a0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a1 as text
%        str2double(get(hObject,'String')) returns contents of edit_a1 as a double
A = str2double(get(handles.edit_a1,'String'));
handles.Para.a1 = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a2 as text
%        str2double(get(hObject,'String')) returns contents of edit_a2 as a double
A = str2double(get(handles.edit_a2,'String'));
handles.Para.a2 = A; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
realTimeBP(handles);
guidata(hObject, handles);



function edit_ResSP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ResSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ResSP as text
%        str2double(get(hObject,'String')) returns contents of edit_ResSP as a double


% --- Executes during object creation, after setting all properties.
function edit_ResSP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ResSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ABPSP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ABPSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ABPSP as text
%        str2double(get(hObject,'String')) returns contents of edit_ABPSP as a double


% --- Executes during object creation, after setting all properties.
function edit_ABPSP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ABPSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ABPDP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ABPDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ABPDP as text
%        str2double(get(hObject,'String')) returns contents of edit_ABPDP as a double


% --- Executes during object creation, after setting all properties.
function edit_ABPDP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ABPDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ResDP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ResDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ResDP as text
%        str2double(get(hObject,'String')) returns contents of edit_ResDP as a double


% --- Executes during object creation, after setting all properties.
function edit_ResDP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ResDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_getResult.
function btn_getResult_Callback(hObject, eventdata, handles)
% hObject    handle to btn_getResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hwait=waitbar(0 ,'加载数据>>>>>>>>');
load(handles.FeatFileName);
clear pksPW locsPW pksECG locsECG

index = 1;
indexstart = 1;
% indexend = 50;
indexend = 15;
interval = 1000;
handles.Para.End = handles.Para.Start +interval;

for index = indexstart : indexend
    waitbar(index/indexend ,hwait ,sprintf('数据处理>>>>>>>> 正在处理第%2.0f 个',index)); %sprintf('数据处理>>>>>>>> %f',index/indexend)
        
        if handles.Para.Start == 0 && handles.Para.End == 0
            msgbox('请设定数据起止');
        else
        val(2,:) = preprocess(val(2,handles.Para.Start:handles.Para.End),3,handles.FeatFileName); %标度转换 详情看plotATM中的方法

        val(1,handles.Para.Start:handles.Para.End) = preprocess(val(1,handles.Para.Start:handles.Para.End),2,handles.FeatFileName);

        val(3,handles.Para.Start:handles.Para.End) = preprocess(val(3,handles.Para.Start:handles.Para.End),1,handles.FeatFileName);
        end


        %峰值检测
        % 脉搏波
                    axes(handles.axes_PW);
                    findpeaks(val(3,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
                    hold on
                    refline(0,handles.Para.PWP)%refline(slope,intercept)
                    hold off
                    [pksPW,locsPW] = findpeaks(val(3,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
        % 心电
                    axes(handles.axes_ECG);
                    findpeaks(val(1,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
                    hold on
                    refline(0,handles.Para.ECGP)%refline(slope,intercept)
                    hold off
                    [pksECG,locsECG] =     findpeaks(val(1,handles.Para.Start : handles.Para.End),'MinPeakDistance',handles.Para.ECGT,'MinPeakHeight' , handles.Para.ECGP);
        % 血压            
                    axes(handles.axes_ABP);
                    findpeaks(val(2,handles.Para.Start : handles.Para.End),'MinPeakDistance',50,'MinPeakHeight' ,90);
                    %SYSTOLIC PRESSOR 收缩压
                    [pksSP,locsABP1] = findpeaks(val(2,handles.Para.Start : handles.Para.End),'MinPeakDistance',50,'MinPeakHeight' ,90);
                    [pksDP,locsABP2] = findpeaks(-val(2,handles.Para.Start : handles.Para.End),'MinPeakDistance',50,'MinPeakHeight' ,-90);
                    pksDP = -pksDP;


        % waitbar(95/100,hwait ,'正在计算PWTT HR ABP>>>>>>>>');
        samplerate = 125;

        %保证ECG信号在前，去掉没用的最前面的PW波
        if locsECG(1) > locsPW(1)
            locsPW = locsPW(2:length(locsPW));
        end

        %保证PW信号在后，去掉没用的最后面的ECG波
        if locsECG(length(locsECG)) > locsPW(length(locsPW))
             locsECG = locsECG(1:(length(locsECG)-1));
        end

         %先有ECG后有PW  ECG多砍后面  PW多 砍前面   
        if length(locsPW) - length(locsECG)==1
            locsPW = locsPW(2:length(locsPW));

        elseif length(locsPW) - length(locsECG)==-1
            locsECG = locsECG(1:(length(locsECG)-1));

        elseif length(locsPW) - length(locsECG)>1 | length(locsPW) - length(locsECG)<-1
            msgbox(sprintf('数据错误，第%2.0f 个',index));
            % 数据处理完后进行循环
                index = index + 1;
                handles.Para.Start = handles.Para.Start + interval;
                handles.Para.End = handles.Para.Start +interval;

            continue %跳出循环，进行下一组数据处理
            
        end

        %开始计算
        if length(locsPW) == length(locsECG)
            %传递时间计算
            time = (locsPW - locsECG) ./ samplerate;
            handles.Result.PWTT = sum(time) / length(time);%Pulse Wave Transit Time

            set(handles.edit_PWTT,'string', handles.Result.PWTT);

            %心率计算
            HRtmp = 0;
            for i=2:1:length(locsECG)
               HRtmp(i-1) = 60/ ( (locsECG(i) - locsECG(i-1))/ samplerate);  %每次心跳的时间间隔计算出每一个心率
            end
            handles.Result.HR = sum(HRtmp) / length(HRtmp);%求平均值

            set(handles.edit_HR,'string', handles.Result.HR);

            %平均血压计算
             handles.Result.rSP = sum(pksSP) / length(pksSP);%求平均值
             handles.Result.rDP = sum(pksDP) / length(pksDP);%求平均值

             set(handles.edit_ABPSP,'string', handles.Result.rSP);
             set(handles.edit_ABPDP,'string', handles.Result.rDP);

        else
            handles.Result.PWTT = 0;
            handles.Result.HR = 0;
            handles.Result.rSP = 0;
             handles.Result.rDP = 0;
            set(handles.edit_PWTT,'string', '');
            set(handles.edit_HR,'string', '');
            msgbox('两组数据检测的顶点个数不一样，请调整后再试');
        end

% 进行结果记录
if handles.Result.PWTT==0 && handles.Result.HR==0
        msgbox('无有效结果，请调整后再试');
        return;
end
handles.FinalResult.PWTT(handles.FinalResult.index) = handles.Result.PWTT;
handles.FinalResult.HR(handles.FinalResult.index) = handles.Result.HR;

handles.FinalResult.SP(handles.FinalResult.index) = handles.Result.rSP;
handles.FinalResult.DP(handles.FinalResult.index) = handles.Result.rDP;
handles.FinalResult.index = handles.FinalResult.index + 1;

if isempty(handles.outPWTT) && isempty(handles.outHR)
    handles.outPWTT = num2str(handles.Result.PWTT);
    handles.outHR = num2str(handles.Result.HR);
    
    handles.outSP = num2str(handles.Result.rSP);
    handles.outDP = num2str(handles.Result.rDP);
else
    handles.outPWTT = [handles.outPWTT,',' , num2str(handles.Result.PWTT)];
    handles.outHR = strcat(handles.outHR,','  , num2str(handles.Result.HR));
    
    handles.outSP= strcat(handles.outSP,','  , num2str(handles.Result.rSP));
    handles.outDP = strcat(handles.outDP,','  , num2str(handles.Result.rDP));
end

set(handles.edit_ResPWTT,'string', strcat(' PWTT = [',handles.outPWTT, ']' ));
set(handles.edit_ResHR,'string',  strcat(' HR = [',handles.outHR , ']'));

set(handles.edit_ResSP,'string',  strcat(' SP = [',handles.outSP , ']'));
set(handles.edit_ResDP,'string',  strcat(' DP = [',handles.outDP , ']'));


% 数据处理完后进行循环
index = index + 1;
handles.Para.Start = handles.Para.Start + interval;
handles.Para.End = handles.Para.Start +interval;
end
close(hwait);
guidata(hObject, handles);
