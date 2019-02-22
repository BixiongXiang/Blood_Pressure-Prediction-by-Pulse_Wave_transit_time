function new=median1(M,data)%中值滤波去心电基线漂移
for x=1:length(data)
    fluct=medfilt1(data, M);%medfilt1为系统自带函数，提取基线漂移
    new=data-fluct;%带噪声的ECG减去基线漂移
end