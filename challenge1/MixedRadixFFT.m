function [frequency, amplitude] = MixedRadixFFT(signal, fs)

    n = length(signal);
    y = FFT(signal, -1);
    frequency = (0:n/2-1)*(fs/n);
    amplitude = abs(y(1:n/2))/(n/2);

end