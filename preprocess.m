function dout = preprocess( din, fnc, fname )
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here

    if fnc ==1 %for pulse wave
        M =100;
%         waitbar(25/100,hwait ,'中值滤波>>>>>>>>');
        din = median1(M,din);

%         waitbar(85/100,hwait ,'归一化>>>>>>>>');
        dout = mapminmax(din);
        
    elseif fnc == 2 %for ECG wave
        N = 5;
        M =10;

%         waitbar(5/100,hwait ,'高频滤波>>>>>>>>');
        din=filt1(N,din);
        
%         waitbar(25/100,hwait ,'中值滤波>>>>>>>>');
        din = median1(M,din);

%         waitbar(85/100,hwait ,'归一化>>>>>>>>');
        dout = mapminmax(din);
        
    elseif fnc == 3  %处理ABP信号，进行幅度变化
        [pathstr,Name,ext] = fileparts(fname);
        
        infoName = strcat(Name, '.info');
        matName = strcat(Name, '.mat');
        
        infopath = [pathstr, '\', Name, '.info'];
        matpath = [pathstr, '\', Name, '.mat'];
        
        Octave = exist('OCTAVE_VERSION');
        load(matpath);
        fid = fopen(infopath, 'rt');
        
        fgetl(fid);
        fgetl(fid);
        fgetl(fid);
        [freqint] = sscanf(fgetl(fid), 'Sampling frequency: %f Hz  Sampling interval: %f sec');
        interval = freqint(2);
        fgetl(fid);

        if(Octave)
            for i = 1:size(val, 1)
               R = strsplit(fgetl(fid), char(9));
               signal{i} = R{2};
               gain(i) = str2num(R{3});
               base(i) = str2num(R{4});
               units{i} = R{5};
            end
        else
            for i = 1:size(val, 1)
              [row(i), signal(i), gain(i), base(i), units(i)]=strread(fgetl(fid),'%d%s%f%f%s','delimiter','\t');
            end
        end

        fclose(fid);
        val(val==-32768) = NaN;

                                for i = 1:size(val, 1)
                                    val(i, :) = (val(i, :) - base(i)) / gain(i);
                                end
                                
%         waitbar(25/100,hwait ,'中值滤波>>>>>>>>');
%         M =10;
%         dout = median1(M, val(2,:));
dout = val(2,:);

	end
   
% close(hwait);
%     guidata(hObject, handles);
end

