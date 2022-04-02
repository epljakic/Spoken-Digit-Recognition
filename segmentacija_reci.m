clc, clear, close all
%% Segmentacija izgovorenih reci

% Ucitavanje filtriranih reci
reci_trening = load('reci_trening_filtrirane.mat');
reci_test = load('reci_test_filtrirane.mat');

% Trening
zero_tr = reci_trening.reci_trening_filtrirane{1,1};
one_tr = reci_trening.reci_trening_filtrirane{1,2};
two_tr = reci_trening.reci_trening_filtrirane{1,3};
three_tr = reci_trening.reci_trening_filtrirane{1,4};

% Test
zero_te = reci_test.reci_test_filtrirane{1,1};
one_te = reci_test.reci_test_filtrirane{1,2};
two_te = reci_test.reci_test_filtrirane{1,3};
three_te = reci_test.reci_test_filtrirane{1,4};

% Parametri
number_of_words_test = 20;
number_of_words = 100;
fs = 16000;
T = 1/fs;

% Poceci i krajevi segmentiranih reci
pocetak_kraj_zero = cell(2, number_of_words);
pocetak_kraj_one = cell(2, number_of_words);
pocetak_kraj_two = cell(2, number_of_words);
pocetak_kraj_three = cell(2, number_of_words);

pocetak_kraj_zero_t = cell(2, number_of_words_test);
pocetak_kraj_one_t = cell(2, number_of_words_test);
pocetak_kraj_two_t = cell(2, number_of_words_test);
pocetak_kraj_three_t = cell(2, number_of_words_test);

%% Segmentacija za rec/broj "zero-0"

% Velicina prozora 20ms
window = fs*20e-3; 
noverlap = fs*20e-3-1;

for i = 1:number_of_words
    [S, F, T, P] = spectrogram(zero_tr{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_zero{1,i}, pocetak_kraj_zero{2,i}] = segmentacija_tiger_energijom(zero_tr{1,i},ITU,ITL,S,F,Te,P);
end

%% Segmentacija za rec/broj "one-1"
for i = 1:number_of_words
    [S, F, T, P] = spectrogram(one_tr{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_one{1,i}, pocetak_kraj_one{2,i}] = segmentacija_tiger_energijom(one_tr{1,i},ITU,ITL,S,F,Te,P);
end

%% Segmentacija za rec/broj "two-2"
for i = 1:number_of_words
    [S, F, T, P] = spectrogram(two_tr{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_two{1,i}, pocetak_kraj_two{2,i}] = segmentacija_tiger_energijom(two_tr{1,i},ITU,ITL,S,F,Te,P);
end

%% Segmentacija za rec/broj "three-3"
for i = 1:number_of_words
    [S, F, T, P] = spectrogram(three_tr{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_three{1,i}, pocetak_kraj_three{2,i}] = segmentacija_tiger_energijom(three_tr{1,i},ITU,ITL,S,F,Te,P);
end

%% Test skup

% Rec/broj "zero-0"
for i = 1:number_of_words_test
    [S, F, T, P] = spectrogram(zero_te{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_zero_t{1,i}, pocetak_kraj_zero_t{2,i}] = segmentacija_tiger_energijom(zero_te{1,i},ITU,ITL,S,F,Te,P);
end

%% Segmentacija za rec/broj "one-1"
for i = 1:number_of_words_test
    [S, F, T, P] = spectrogram(one_te{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_one_t{1,i}, pocetak_kraj_one_t{2,i}] = segmentacija_tiger_energijom(one_te{1,i},ITU,ITL,S,F,Te,P);
end

%% Segmentacija za rec/broj "two-2"
for i = 1:number_of_words_test
    [S, F, T, P] = spectrogram(two_te{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_two_t{1,i}, pocetak_kraj_two_t{2,i}] = segmentacija_tiger_energijom(two_te{1,i},ITU,ITL,S,F,Te,P);
end

%% Segmentacija za rec/broj "three-3"
for i = 1:number_of_words_test
    [S, F, T, P] = spectrogram(three_te{1,i}, window, noverlap, 128*2, fs, 'yaxis');
    Te = zeros(size(T));
    for t = 1:length(T)
        Te(t) = sum(P(:,t).*(F.^2)); 
    end
    ITU = 0.5*max(Te);
    ITL = 0.001*max(Te);
    [pocetak_kraj_three_t{1,i}, pocetak_kraj_three_t{2,i}] = segmentacija_tiger_energijom(three_te{1,i},ITU,ITL,S,F,Te,P);
end

%% Cuvanje segmentiranih reci

% Trening
zero_tr_new = cell(1, number_of_words);
one_tr_new = cell(1, number_of_words);
two_tr_new = cell(1, number_of_words);
three_tr_new = cell(1, number_of_words);

% Test
zero_te_new = cell(1, number_of_words_test);
one_te_new = cell(1, number_of_words_test);
two_te_new = cell(1, number_of_words_test);
three_te_new = cell(1, number_of_words_test);

% Odsecanje tisine iz govora
for i = 1:number_of_words
    zero_tr_new{1,i} = zero_tr{1,i}(pocetak_kraj_zero{1,i}:pocetak_kraj_zero{2,i});
    one_tr_new{1,i} = one_tr{1,i}(pocetak_kraj_one{1,i}:pocetak_kraj_one{2,i});
    two_tr_new{1,i} = two_tr{1,i}(pocetak_kraj_two{1,i}:pocetak_kraj_two{2,i});
    three_tr_new{1,i} = three_tr{1,i}(pocetak_kraj_three{1,i}:pocetak_kraj_three{2,i});
end

for i = 1:number_of_words_test
    zero_te_new{1,i} = zero_te{1,i}(pocetak_kraj_zero_t{1,i}:pocetak_kraj_zero_t{2,i});
    one_te_new{1,i} = one_te{1,i}(pocetak_kraj_one_t{1,i}:pocetak_kraj_one_t{2,i});
    two_te_new{1,i} = two_te{1,i}(pocetak_kraj_two_t{1,i}:pocetak_kraj_two_t{2,i});
    three_te_new{1,i} = three_te{1,i}(pocetak_kraj_three_t{1,i}:pocetak_kraj_three_t{2,i});
end

% Trening
reci_trening_segmentirane = cell(1, 4);
reci_trening_segmentirane{1,1} = zero_tr_new;
reci_trening_segmentirane{1,2} = one_tr_new;
reci_trening_segmentirane{1,3} = two_tr_new;
reci_trening_segmentirane{1,4} = three_tr_new;

% Test
reci_test_segmentirane = cell(1, 4);
reci_test_segmentirane{1,1} = zero_te_new;
reci_test_segmentirane{1,2} = one_te_new;
reci_test_segmentirane{1,3} = two_te_new;
reci_test_segmentirane{1,4} = three_te_new;

% Cuvanje
% save reci_trening_segmentirane.mat reci_trening_segmentirane
% save reci_test_segmentirane.mat reci_test_segmentirane

%% Iscrtavanje segmentiranih reci

% Zero
reci1 = zeros(length(zero_tr{1,7}), 1);
for i = 1:length(pocetak_kraj_zero{1,7})
    reci1(pocetak_kraj_zero{1,7}:pocetak_kraj_zero{2,7}) = 0.1*max(Te)*ones(pocetak_kraj_zero{2,7}-pocetak_kraj_zero{1,7}+1, 1);
end

% One
reci2 = zeros(length(one_tr{1,45}), 1);
for i = 1:length(pocetak_kraj_one{1,45})
    reci2(pocetak_kraj_one{1,45}:pocetak_kraj_one{2,45}) = 0.5*max(Te)*ones(pocetak_kraj_one{2,45}-pocetak_kraj_one{1,45}+1, 1);
end

% Two
reci3 = zeros(length(two_tr{1,7}), 1);
for i = 1:length(pocetak_kraj_two{1,7})
    reci3(pocetak_kraj_two{1,7}:pocetak_kraj_two{2,7}) = 0.1*max(Te)*ones(pocetak_kraj_two{2,7}-pocetak_kraj_two{1,7}+1, 1);
end

% Three
reci4 = zeros(length(three_tr{1,8}), 1);
for i = 1:length(pocetak_kraj_three{1,8})
    reci4(pocetak_kraj_three{1,8}:pocetak_kraj_three{2,8}) = 0.1*max(Te)*ones(pocetak_kraj_three{2,8}-pocetak_kraj_three{1,8}+1, 1);
end

figure
subplot(2,2,1)
plot(1:length(zero_tr{1,7}), zero_tr{1,7}, 'b', 1:length(zero_tr{1,7}), reci1, 'r');
title("Zero - 0");
subplot(2,2,2)
plot(1:length(one_tr{1,45}), one_tr{1,45}, 'b', 1:length(one_tr{1,45}), reci2, 'r');
title("One - 1");
subplot(2,2,3)
plot(1:length(two_tr{1,7}), two_tr{1,7}, 'b', 1:length(two_tr{1,7}), reci3, 'r');
title("Two - 2");
subplot(2,2,4)
plot(1:length(three_tr{1,8}), three_tr{1,8}, 'b', 1:length(three_tr{1,8}), reci4, 'r');
title("Three - 3");

%% Iscrtavanje spektrograma

% Velicina prozora 20ms
window = fs*20e-3; 
noverlap = fs*20e-3-1;

figure
subplot(2,2,1)
spectrogram(zero_tr{1,7}, window, noverlap, 1024, 'yaxis');
title("Zero - 0");
subplot(2,2,2)
spectrogram(one_tr{1,45}, window, noverlap, 1024, 'yaxis');
title("One - 1");
subplot(2,2,3)
spectrogram(two_tr{1,7}, window, noverlap, 1024, 'yaxis');
title("Two - 2");
subplot(2,2,4)
spectrogram(three_tr{1,8}, window, noverlap, 1024, 'yaxis');
title("Three - 3");
