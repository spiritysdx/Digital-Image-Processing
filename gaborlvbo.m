function varargout = gaborlvbo(varargin)
% GABORLVBO M-file for gaborlvbo.fig
%      GABORLVBO, by itself, creates a new GABORLVBO or raises the existing
%      singleton*.
%      H = GABORLVBO returns the handle to a new GABORLVBO or the handle to
%      the existing singleton*.
%      GABORLVBO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GABORLVBO.M with the given input arguments.
%      GABORLVBO('Property','Value',...) creates a new GABORLVBO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gaborlvbo_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gaborlvbo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Copyright 2002-2003 The MathWorks, Inc.
% Edit the above text to modify the response to help gaborlvbo
% Last Modified by GUIDE v2.5 28-May-2010 15:43:51
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gaborlvbo_OpeningFcn, ...
                   'gui_OutputFcn',  @gaborlvbo_OutputFcn, ...
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


% --- Executes just before gaborlvbo is made visible.
function gaborlvbo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gaborlvbo (see VARARGIN)
setappdata(handles.figure_gabor,'img_src',0);
setappdata(handles.figure_gabor,'thea',0);
% Choose default command line output for gaborlvbo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gaborlvbo wait for user response (see UIRESUME)


% --- Outputs from this function are returned to the command line.
function varargout = gaborlvbo_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.bmp;*.jpg;*.png;*.jpeg', 'Image Files (*.bmp, *.jpg, *.png,*.jpeg)'; ...
    '*.*',                   'All Files (*.*)'}, ...
    'Pick an image');

if isequal(filename,0) || isequal(pathname,0),
    return;
end

axes(handles.axes_src);
fpath=[pathname filename];
img_src=imread(fpath);
img_src=rgb2gray(img_src);
imshow(img_src);
setappdata(handles.figure_gabor,'img_src',img_src);

% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close(handles.figure_gabor);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 axes(handles.axes_dst);
 b1=[0 1 0
     1 1 1
     0 1 0];
b2=[0 0 1 0 0
    0 1 1 1 0
    1 1 1 1 1
    0 1 1 1 0
    0 0 1 0 0];
b31=[0 0 0
     1 1 1
     0 0 0];
b32=[0 0 1
     0 1 0
     1 0 0];
b33=[0 1 0
     0 1 0
     0 1 0];
b34=[1 0 0
     0 1 0
     0 0 1];
 I = getappdata(handles.figure_gabor,'img_src');
 I=double(I);
 
xs1=size(I,1);
xs2=size(I,2);
K1=sum(sum(I));
M1=K1/(xs1*xs2);
M2=ones(xs1,xs2);
M0=M2*M1;
M3=zeros(xs1,xs2);
for i=1:xs1
    for j=1:xs2
        M3(i,j)=(I(i,j)-M0(i,j))^2;   %求一个平均值 
    end
end
K2=sum(sum(M3));
V0=K2/(xs1*xs2);
P1=ones(fix(xs1/15),fix(xs2/15));
P2=ones(15,15);
P3=ones(fix(xs1/15),fix(xs2/15));
for i=1:xs1
    for j=1:xs2
        a=mod(i,15);
        b=mod(j,15);
        if a==0
            a=15;
        end
        if b==0
            b=15;
        end
        P2(a,b)=I(i,j);
        if a==15&&b==15
            PK1=sum(sum(P2));
            PM1=PK1/(15*15);
            PM2=ones(15,15);
            PM0=PM2*PM1;
            PM3=zeros(15,15);
            for m=1:15
                for n=1:15
                    PM3(m,n)=(PM2(m,n)-PM0(m,n))^2;
                end
            end
            PK2=sum(sum(PM3));
            PV0=PK2/(15*15);
            P1(fix(i/15),fix(j/15))=PM1;
            P3(fix(i/15),fix(j/15))=PV0;
        end        
    end
end

I_n=zeros(xs1,xs2);
for i=1:xs1
    for j=1:xs2
        m=ceil(i/15);
        n=ceil(j/15);
        if I(i,j)>M0(i,j)&&m~=ceil(xs1/15)&&n~=ceil(xs2/15)
            I_n(i,j)=M0(i,j)+sqrt(V0*(I(i,j)-P1(m,n))^2/P3(m,n));
        end
        if I(i,j)<=M0(i,j)&&m~=ceil(xs1/15)&&n~=ceil(xs2/15)
            I_n(i,j)=M0(i,j)-sqrt(V0*(P1(m,n)-I(i,j))^2/P3(m,n));
        end
    end
end

I=I_n;
img_src_I=I;
setappdata(handles.figure_gabor,'img_src_I',img_src_I);
 
bw1= I;
vertical=[ 1  2  1
           0  0  0
          -1  -2  -1];

horizontal=[ -1  0  1
             -2  0  2
             -1  0  1];

fx=conv2(bw1,vertical,'same');
fy=conv2(bw1,horizontal,'same');
mubanver=15;mubanhor=15;  %模板的垂直和水平大小
