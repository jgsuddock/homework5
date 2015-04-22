function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 22-Apr-2015 17:01:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

clear,clc

global active NonActive MeanA MeanN StdevA StdevN

%% Reads input file 1
str = fopen('hw5db1.txt');
c = textscan(str,'%s %s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(str);

%% Remove First 3 columns (Unneeded Data)
c(:,1) = [];
c(:,1) = [];
c(:,1) = [];

%% Converts cell array to 2D matrix
d = cell2mat(c);
active = d(1:1347,:);
NonActive = d(1348:43347,:);

%% Reads input file 2
str = fopen('hw5db2.txt');
e = textscan(str,'%f %f %f %f %f %f %f %f');
fclose(str);

%% Converts cell array to 2D matrix
mat = cell2mat(e);

MeanA = zeros(1,16);
for i = 1:2
    for j = 1:8
        MeanA((i-1)*8 + j) = mat(i,j);
    end
end

MeanN = zeros(1,16);
for i = 1:2
    for j = 1:8
        MeanN((i-1)*8 + j) = mat(i+2,j);
    end
end

StdevA = zeros(1,16);
for i = 1:2
    for j = 1:8
        StdevA((i-1)*8 + j) = mat(i+4,j);
    end
end

StdevN = zeros(1,16);
for i = 1:2
    for j = 1:8
        StdevN((i-1)*8 + j) = mat(i+6,j);
    end
end

%% Active Set
Result1a = zeros(1,2);
Result2a = zeros(1,2);
Result3a = zeros(1,2);
Result4a = zeros(1,2);

for i = 1:1347
    EDA = sqrt(sum((active(i,:)-MeanA(1,:)).^2));
    EDN = sqrt(sum((active(i,:)-MeanN(1,:)).^2));
    if EDA <= EDN
        Result1a(1,1) = Result1a(1,1) + 1;    % Active compounds.
    else
        Result1a(1,2) = Result1a(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:1347
    MDA = sqrt(sum(((active(i,:)-MeanA(1,:))./StdevA(1,:)).^2));
    MDN = sqrt(sum(((active(i,:)-MeanN(1,:))./StdevN(1,:)).^2));
    if MDA <= MDN
        Result2a(1,1) = Result2a(1,1) + 1;    % Active compounds.
    else
        Result2a(1,2) = Result2a(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:1347
    Active3 = 0;
    NonActive3 = 0;
    for j = 1:16 
        P3 = sqrt((active(i,j)-MeanA(1,j))^2);
        Q3 = sqrt((active(i,j)-MeanN(1,j))^2);
        if P3 <= Q3
            Active3 = Active3 + 1;
        else
            NonActive3 = NonActive3 + 1;
        end
    end
    if Active3 >= NonActive3
        Result3a(1,1) = Result3a(1,1) + 1;    % Active compounds.
    else
        Result3a(1,2) = Result3a(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:1347
    Active4 = 0;
    NonActive4 = 0;
    for j = 1:16 
        P4 = sqrt(((active(i,j)-MeanA(1,j))/StdevA(1,j))^2);
        Q4 = sqrt(((active(i,j)-MeanN(1,j))/StdevN(1,j))^2);
        if P4 <= Q4
            Active4 = Active4 + 1;
        else
            NonActive4 = NonActive4 + 1;
        end
    end
    if Active4 >= NonActive4
        Result4a(1,1) = Result4a(1,1) + 1;    % Active compounds.
    else
        Result4a(1,2) = Result4a(1,2) + 1;    % Non-Active compounds.
    end
end

%% Non-Active Set
Result1b = zeros(1,2);
Result2b = zeros(1,2);
Result3b = zeros(1,2);
Result4b = zeros(1,2);

for i = 1:42000
    EDA = sqrt(sum((NonActive(i,:)-MeanA(1,:)).^2));
    EDN = sqrt(sum((NonActive(i,:)-MeanN(1,:)).^2));
    if EDA <= EDN
        Result1b(1,1) = Result1b(1,1) + 1;    % Active compounds.
    else
        Result1b(1,2) = Result1b(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:42000
    MDA = sqrt(sum(((NonActive(i,:)-MeanA(1,:))./StdevA(1,:)).^2));
    MDN = sqrt(sum(((NonActive(i,:)-MeanN(1,:))./StdevN(1,:)).^2));
    if MDA <= MDN
        Result2b(1,1) = Result2b(1,1) + 1;    % Active compounds.
    else
        Result2b(1,2) = Result2b(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:42000
    Active3 = 0;
    NonActive3 = 0;
    for j = 1:16 
        P3 = sqrt((NonActive(i,j)-MeanA(1,j))^2);
        Q3 = sqrt((NonActive(i,j)-MeanN(1,j))^2);
        if P3 <= Q3
            Active3 = Active3 + 1;
        else
            NonActive3 = NonActive3 + 1;
        end
    end
    if Active3 >= NonActive3
        Result3b(1,1) = Result3b(1,1) + 1;    % Active compounds.
    else
        Result3b(1,2) = Result3b(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:42000
    Active4 = 0;
    NonActive4 = 0;
    for j = 1:16 
        P4 = sqrt(((NonActive(i,j)-MeanA(1,j))/StdevA(1,j))^2);
        Q4 = sqrt(((NonActive(i,j)-MeanN(1,j))/StdevN(1,j))^2);
        if P4 <= Q4
            Active4 = Active4 + 1;
        else
            NonActive4 = NonActive4 + 1;
        end
    end
    if Active4 >= NonActive4
        Result4b(1,1) = Result4b(1,1) + 1;    % Active compounds.
    else
        Result4b(1,2) = Result4b(1,2) + 1;    % Non-Active compounds.
    end
end

global N1 N2 N3 N4
N1 = [Result1a(1,1) Result1b(1,1) Result1a(1,2) Result1b(1,2)];
N2 = [Result2a(1,1) Result2b(1,1) Result2a(1,2) Result2b(1,2)];
N3 = [Result3a(1,1) Result3b(1,1) Result3a(1,2) Result3b(1,2)];
N4 = [Result4a(1,1) Result4b(1,1) Result4a(1,2) Result4b(1,2)];

%% Ratios
global Ratio1 Ratio2 Ratio3 Ratio4
Ratio1 = Result1a(1)/Result1b(1);
Ratio2 = Result2a(1)/Result2b(1);
Ratio3 = Result3a(1)/Result3b(1);
Ratio4 = Result4a(1)/Result4b(1);
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global Check
Check = [0,0,0,0];


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in classifier1btn.

function classifier1btn_Callback(hObject, eventdata, handles)
% hObject    handle to classifier1btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global N1 Check Ratio1

Check(1) = 1;
if(Check == [1,1,1,1])
    set(handles.predictionBtn,'Visible','on')
end

text = sprintf('Naa = %s\nNan = %s\nNna = %s\nNnn = %s\nRatio = %.5f',num2str(N1(1)),num2str(N1(2)),num2str(N1(3)),num2str(N1(4)),Ratio1);

set(handles.text5,'String', text);

% --- Executes on button press in classifier2btn.
function classifier2btn_Callback(hObject, eventdata, handles)
% hObject    handle to classifier2btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global N2 Check Ratio2

Check(2) = 1;
if(Check == [1,1,1,1])
    set(handles.predictionBtn,'Visible','on')
end

text = sprintf('Naa = %s\nNan = %s\nNna = %s\nNnn = %s\nRatio = %.5f',num2str(N2(1)),num2str(N2(2)),num2str(N2(3)),num2str(N2(4)),Ratio2);

set(handles.text5,'String', text);


% --- Executes on button press in classifier3btn.
function classifier3btn_Callback(hObject, eventdata, handles)
% hObject    handle to classifier3btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global N3 Check Ratio3

Check(3) = 1;
if(Check == [1,1,1,1])
    set(handles.predictionBtn,'Visible','on')
end

text = sprintf('Naa = %s\nNan = %s\nNna = %s\nNnn = %s\nRatio = %.5f',num2str(N3(1)),num2str(N3(2)),num2str(N3(3)),num2str(N3(4)),Ratio3);

set(handles.text5,'String', text);


% --- Executes on button press in classifier4btn.
function classifier4btn_Callback(hObject, eventdata, handles)
% hObject    handle to classifier4btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global N4 Check Ratio4

Check(4) = 1;
if(Check == [1,1,1,1])
    set(handles.predictionBtn,'Visible','on')
end    

text = sprintf('Naa = %s\nNan = %s\nNna = %s\nNnn = %s\nRatio = %.5f',num2str(N4(1)),num2str(N4(2)),num2str(N4(3)),num2str(N4(4)),Ratio4);

set(handles.text5,'String', text);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in predictionBtn.
function predictionBtn_Callback(hObject, eventdata, handles)
% hObject    handle to predictionBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global active NonActive MeanA MeanN StdevA StdevN Ratio1 Ratio2 Ratio3 Ratio4

set(handles.axes1,'Visible','on')

Result1a = zeros(1,2);
Result2a = zeros(1,2);
Result3a = zeros(1,2);
Result4a = zeros(1,2);

Result1b = zeros(1,2);
Result2b = zeros(1,2);
Result3b = zeros(1,2);
Result4b = zeros(1,2);

tmpactive = active;
tmpNonActive = NonActive;
tmpMeanA = MeanA;
tmpMeanN = MeanN;
tmpStdevA = StdevA;
tmpStdevN = StdevN;

arr = [13,9,8,6,4]; 

for int=1:5
        tmpactive(:,arr(int)) = []; 
        tmpNonActive(:,arr(int)) = [];
        tmpMeanA(:,arr(int)) = [];
        tmpMeanN(:,arr(int)) = [];
        tmpStdevA(:,arr(int)) = [];
        tmpStdevN(:,arr(int)) = [];
end

%% Active Set

for i = 1:1347
    EDA = sqrt(sum((tmpactive(i,:)-tmpMeanA(1,:)).^2));
    EDN = sqrt(sum((tmpactive(i,:)-tmpMeanN(1,:)).^2));
    if EDA <= EDN
            Result1a(1,1) = Result1a(1,1) + 1;    % Active compounds.
    else
            Result1a(1,2) = Result1a(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:1347
    MDA = sqrt(sum(((tmpactive(i,:)-tmpMeanA(1,:))./tmpStdevA(1,:)).^2));
    MDN = sqrt(sum(((tmpactive(i,:)-tmpMeanN(1,:))./tmpStdevN(1,:)).^2));
    if MDA <= MDN
            Result2a(1,1) = Result2a(1,1) + 1;    % Active compounds.
    else
            Result2a(1,2) = Result2a(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:1347
    Active3 = 0;
    NonActive3 = 0;
    for j = 1:11 
            P3 = sqrt((tmpactive(i,j)-tmpMeanA(1,j))^2);
            Q3 = sqrt((tmpactive(i,j)-tmpMeanN(1,j))^2);
            if P3 <= Q3
            Active3 = Active3 + 1;
            else
            NonActive3 = NonActive3 + 1;
            end
    end
    if Active3 >= NonActive3
            Result3a(1,1) = Result3a(1,1) + 1;    % Active compounds.
    else
            Result3a(1,2) = Result3a(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:1347
    Active4 = 0;
    NonActive4 = 0;
    for j = 1:11 
            P4 = sqrt(((tmpactive(i,j)-tmpMeanA(1,j))/tmpStdevA(1,j))^2);
            Q4 = sqrt(((tmpactive(i,j)-tmpMeanN(1,j))/tmpStdevN(1,j))^2);
            if P4 <= Q4
            Active4 = Active4 + 1;
            else
            NonActive4 = NonActive4 + 1;
            end
    end
    if Active4 >= NonActive4
            Result4a(1,1) = Result4a(1,1) + 1;    % Active compounds.
    else
            Result4a(1,2) = Result4a(1,2) + 1;    % Non-Active compounds.
    end
end

%% Non-Active Set

for i = 1:42000
    EDA = sqrt(sum((tmpNonActive(i,:)-tmpMeanA(1,:)).^2));
    EDN = sqrt(sum((tmpNonActive(i,:)-tmpMeanN(1,:)).^2));
    if EDA <= EDN
            Result1b(1,1) = Result1b(1,1) + 1;    % Active compounds.
    else
            Result1b(1,2) = Result1b(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:42000
    MDA = sqrt(sum(((tmpNonActive(i,:)-tmpMeanA(1,:))./tmpStdevA(1,:)).^2));
    MDN = sqrt(sum(((tmpNonActive(i,:)-tmpMeanN(1,:))./tmpStdevN(1,:)).^2));
    if MDA <= MDN
            Result2b(1,1) = Result2b(1,1) + 1;    % Active compounds.
    else
            Result2b(1,2) = Result2b(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:42000
    Active3 = 0;
    NonActive3 = 0;
    for j = 1:11 
            P3 = sqrt((tmpNonActive(i,j)-tmpMeanA(1,j))^2);
            Q3 = sqrt((tmpNonActive(i,j)-tmpMeanN(1,j))^2);
            if P3 <= Q3
            Active3 = Active3 + 1;
            else
            NonActive3 = NonActive3 + 1;
            end
    end
    if Active3 >= NonActive3
            Result3b(1,1) = Result3b(1,1) + 1;    % Active compounds.
    else
            Result3b(1,2) = Result3b(1,2) + 1;    % Non-Active compounds.
    end
end

for i = 1:42000
    Active4 = 0;
    NonActive4 = 0;
    for j = 1:11 
            P4 = sqrt(((tmpNonActive(i,j)-tmpMeanA(1,j))/tmpStdevA(1,j))^2);
            Q4 = sqrt(((tmpNonActive(i,j)-tmpMeanN(1,j))/tmpStdevN(1,j))^2);
            if P4 <= Q4
            Active4 = Active4 + 1;
            else
            NonActive4 = NonActive4 + 1;
            end
    end
    if Active4 >= NonActive4
            Result4b(1,1) = Result4b(1,1) + 1;    % Active compounds.
    else
            Result4b(1,2) = Result4b(1,2) + 1;    % Non-Active compounds.
    end
end

%% Ratios

Ratios(1) = Result1a(1,1)/Result1b(1,1);
Ratios(2) = Result2a(1,1)/Result2b(1,1);
Ratios(3) = Result3a(1,1)/Result3b(1,1);
Ratios(4) = Result4a(1,1)/Result4b(1,1);

FinalRatio = mean(Ratios);

text = sprintf('Ratio = %.5f', FinalRatio);

set(handles.text5,'String',text)

Answer = [0 Ratio1 Ratio2 Ratio3 Ratio4 FinalRatio 0];


x = 0:1:6;
y = Answer;
m = stem(x,y);
title('Drug Discovery Graph')
xlabel('Classifier')
ylabel('Ratio = Naa/Nan')

set(m);
