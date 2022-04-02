clc, clear, close all
%% LPC koeficijenti

% Ucitavanje segmentiranih reci
reci_trening = load('reci_trening_segmentirane.mat');
reci_test = load('reci_test_segmentirane.mat');

zero_tr = reci_trening.reci_trening_segmentirane{1,1};
one_tr = reci_trening.reci_trening_segmentirane{1,2};
two_tr = reci_trening.reci_trening_segmentirane{1,3};
three_tr = reci_trening.reci_trening_segmentirane{1,4};

zero_te = reci_test.reci_test_segmentirane{1,1};
one_te = reci_test.reci_test_segmentirane{1,2};
two_te = reci_test.reci_test_segmentirane{1,3};
three_te = reci_test.reci_test_segmentirane{1,4};

% Parametri
number_of_words_test = 20;
number_of_words = 100;
fs = 16000;
T = 1/fs;

%% Estimacija LPC koeficijenata na osnovu autokorelacione metode - trening skup

% Hammingova prozorska funkcija
wl = fs*30e-3;  
win = hamming(wl);  
num_samples = round(wl);
overlap = 25; % preklapanje
block_overlap = num_samples*overlap/100;

% LPC koeficijenti za reci iz trening skupa
lpc_zero_tr = cell(1, number_of_words);
lpc_one_tr = cell(1, number_of_words);
lpc_two_tr = cell(1, number_of_words);
lpc_three_tr = cell(1, number_of_words);

% Broj LPC koeficijenata
p = 12;

for i = 1:number_of_words
    % LPC koeficijenti za rec/broj "zero-0"
    k_zero = 1;
    for j = wl/2:num_samples-block_overlap:length(zero_tr{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_zero = zero_tr{1,i}(rng).*win;
        rxx_zero = xcorr(x_zero);
        lpc_zero_tr{1,i}(k_zero,:) = lpc_koeficijenti(transpose(rxx_zero), p);
        k_zero = k_zero + 1;
    end
    
    % LPC koeficijenti za rec/broj "one-1"
    k_one = 1;
    for j = wl/2:num_samples-block_overlap:length(one_tr{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_one = one_tr{1,i}(rng).*win;
        rxx_one = xcorr(x_one);
        lpc_one_tr{1,i}(k_one,:) = lpc_koeficijenti(transpose(rxx_one), p);
        k_one = k_one + 1;
    end
    
    % LPC koeficijenti za rec/broj "two-2"
    k_two = 1;
    for j = wl/2:num_samples-block_overlap:length(two_tr{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_two = two_tr{1,i}(rng).*win;
        rxx_two = xcorr(x_two);
        lpc_two_tr{1,i}(k_two,:) = lpc_koeficijenti(transpose(rxx_two), p);
        k_two = k_two + 1;
    end
    
    % LPC koeficijenti za rec/broj "three-3"
    k_three = 1;
    for j = wl/2:num_samples-block_overlap:length(three_tr{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_three = three_tr{1,i}(rng).*win;
        rxx_three = xcorr(x_three);
        lpc_three_tr{1,i}(k_three,:) = lpc_koeficijenti(transpose(rxx_three), p);
        k_three = k_three + 1;
    end
end

%% Estimacija LPC koeficijenata na osnovu autokorelacione metode - test skup

% Celije u kojima ce se cuvati LPC koeficijenti
lpc_zero_te = cell(1, number_of_words_test);
lpc_one_te = cell(1, number_of_words_test);
lpc_two_te = cell(1, number_of_words_test);
lpc_three_te = cell(1, number_of_words_test);

for i = 1:number_of_words_test
    
    % LPC koeficijenti za rec/broj "zero-0"
    k_zero = 1;
    for j = wl/2:num_samples-block_overlap:length(zero_te{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_zero = zero_te{1,i}(rng).*win;
        rxx_zero = xcorr(x_zero);
        lpc_zero_te{1,i}(k_zero,:) = lpc_koeficijenti(transpose(rxx_zero), p);
        k_zero = k_zero + 1;
    end
    
    % LPC koeficijenti za rec/broj "one-1"
    k_one = 1;
    for j = wl/2:num_samples-block_overlap:length(one_te{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_one = one_te{1,i}(rng).*win;
        rxx_one = xcorr(x_one);
        lpc_one_te{1,i}(k_one,:) = lpc_koeficijenti(transpose(rxx_one), p);
        k_one = k_one + 1;
    end
    
    % LPC koeficijenti za rec/broj "two-2"
    k_two = 1;
    for j = wl/2:num_samples-block_overlap:length(two_te{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_two = two_te{1,i}(rng).*win;
        rxx_two = xcorr(x_two);
        lpc_two_te{1,i}(k_two,:) = lpc_koeficijenti(transpose(rxx_two), p);
        k_two = k_two + 1;
    end
    
    % LPC koeficijenti za rec/broj "three-3"
    k_three = 1;
    for j = wl/2:num_samples-block_overlap:length(three_te{1,i})-wl/2
        rng = (j-wl/2+1):(j+wl/2);
        x_three = three_te{1,i}(rng).*win;
        rxx_three = xcorr(x_three);
        lpc_three_te{1,i}(k_three,:) = lpc_koeficijenti(transpose(rxx_three), p);
        k_three = k_three + 1;
    end
end

%% Cuvanje dobijenih LPC koeficijenata 

% Trening
reci_trening_lpc = cell(1, 4);
reci_trening_lpc{1,1} = lpc_zero_tr;
reci_trening_lpc{1,2} = lpc_one_tr;
reci_trening_lpc{1,3} = lpc_two_tr;
reci_trening_lpc{1,4} = lpc_three_tr;

% Test
reci_test_lpc = cell(1, 4);
reci_test_lpc{1,1} = lpc_zero_te;
reci_test_lpc{1,2} = lpc_one_te;
reci_test_lpc{1,3} = lpc_two_te;
reci_test_lpc{1,4} = lpc_three_te;

% Cuvanje
% save reci_trening_lpc.mat reci_trening_lpc
% save reci_test_lpc.mat reci_test_lpc
