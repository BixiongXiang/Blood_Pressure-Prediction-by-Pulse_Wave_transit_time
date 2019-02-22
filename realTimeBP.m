function varargout = realTimeBP(varargin)
% REALTIMEBP MATLAB code for realTimeBP.fig
%      REALTIMEBP, by itself, creates a new REALTIMEBP or raises the existing
%      singleton*.
%
%      H = REALTIMEBP returns the handle to a new REALTIMEBP or the handle to
%      the existing singleton*.
%
%      REALTIMEBP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REALTIMEBP.M with the given input arguments.
%
%      REALTIMEBP('Property','Value',...) creates a new REALTIMEBP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before realTimeBP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to realTimeBP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help realTimeBP

% Last Modified by GUIDE v2.5 19-Apr-2018 14:41:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @realTimeBP_OpeningFcn, ...
                   'gui_OutputFcn',  @realTimeBP_OutputFcn, ...
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


% --- Executes just before realTimeBP is made visible.
function realTimeBP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to realTimeBP (see VARARGIN)

% Choose default command line output for realTimeBP
handles.output = hObject;

global para;  %用para代替handles 存储文件。
para = varargin{1};  %用花括号提取cell
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes realTimeBP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = realTimeBP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global para;
load(para.FeatFileName);
clear pksPW locsPW pksECG locsECG

samplerate = 125;
i = 1;
n = samplerate *4;

datastart(1) = 203000;
datastart(2) = 203000;
datastart(3) = 203000;

dataend = 206000;


% while (datastart(2)+i*n) < length(val(2,:))
while (datastart(2)+i*n) < dataend
% dout =   preprocess(val(1,:),2,handles.FeatFileName);
tmpPW = preprocess(val(3,datastart(2)+n*(i-1) : datastart(2)+i*n ),1,para.FeatFileName); 
tmpECG = preprocess(val(1,datastart(3)+n*(i-1) : datastart(3) + i*n),2,para.FeatFileName); 

axes(handles.axes1);
% plot(tmpPW);
findpeaks(tmpPW,'MinPeakDistance',para.Para.PWT,'MinPeakHeight' ,para.Para.PWP);
axes(handles.axes2);
% plot(tmpECG);
findpeaks(tmpECG,'MinPeakDistance',para.Para.ECGT,'MinPeakHeight' , para.Para.ECGP);

[pksPW,locsPW] = findpeaks(tmpPW,'MinPeakDistance',para.Para.PWT,'MinPeakHeight' ,para.Para.PWP);  
[pksECG,locsECG] = findpeaks(tmpECG,'MinPeakDistance',para.Para.ECGT,'MinPeakHeight' , para.Para.ECGP);

%保证ECG信号在前，去掉没用的最前面的PW波
if locsECG(1) < locsPW(1)
    locsPW = locsPW(2:length(locsPW));
end

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
            msgbox(sprintf('数据错误，第%2.0f 个',i));
            % 数据处理完后进行循环
                i = i + 1;
            continue %跳出循环，进行下一组数据处理
        end
        

if length(locsPW) == length(locsECG)
    %传递时间计算
    time = (locsPW - locsECG) ./ samplerate;
    handles.Result.PWTT = sum(time) / length(time);%Pulse Wave Transit Time

    %心率计算
    HRtmp = 0;
    for j=2:1:length(locsECG)
       HRtmp(j-1) = 60/ ( (locsECG(j) - locsECG(j-1))/ samplerate);  %每次心跳的时间间隔计算出每一个心率
    end


    handles.Result.HR = sum(HRtmp) / length(HRtmp);%求平均值
else
    handles.Result.PWTT = 0;
    handles.Result.HR = 0;
    msgbox('检测失败');
end

handles.Forcast.SP = para.Para.a0 + para.Para.a1 * handles.Result.HR + para.Para.a2 * handles.Result.PWTT;

handles.Forcast.DP = para.Para.b0 + para.Para.b1 * handles.Result.HR + para.Para.b2 * handles.Result.PWTT;

if handles.Forcast.DP < 0
handles.Forcast.DP =0;
end

if handles.Forcast.SP < 0
handles.Forcast.SP =0;
end

set(handles.edit1,'string', handles.Forcast.DP);
set(handles.edit2,'string', handles.Forcast.SP);

i=i+1;
 pause(1);   %应改为4秒
end

guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
