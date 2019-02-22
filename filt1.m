function [new_data]=filt1(N,data)
%N是差分的阶数,data是原始数据。例：ecg_low = filt1(N,ecg);
a = N*[1,-1];
b = [1,zeros(1,N-1),-1];
new_data = filter(b,a,data);

end