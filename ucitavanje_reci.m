clc, clear, close all
%% Ucitavanje reci koje ce se nalaziti u trening skupu

% Rec/broj "zero-0"
number_of_words = 100;
zero_trening = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [zero_trening{1,k}, zero_trening{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Rec/broj "one-1"
one_trening = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [one_trening{1,k}, one_trening{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Rec/broj "two-2"
two_trening = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [two_trening{1,k}, two_trening{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Rec/broj "three-3"
three_trening = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [three_trening{1,k}, three_trening{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Ucitavanje reci koje ce se nalaziti u test skupu
% Rec/broj "zero-0"
number_of_words = 20;
zero_test = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [zero_test{1,k}, zero_test{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Rec/broj "one-1"
one_test = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [one_test{1,k}, one_test{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Rec/broj "two-2"
two_test = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [two_test{1,k}, two_test{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Rec/broj "three-3"
three_test = cell(2, number_of_words);
k = 1;
files_down = dir;
for i = 1:length(files_down)
    if length(files_down(i).name) > 4 && files_down(i).name(end-3:end) == ".wav"
        [three_test{1,k}, three_test{2,k}] = audioread(files_down(i).name);
        k = k + 1;
    end
end

%% Cuvanje ucitanih reci
reci_trening = cell(1, 4);
reci_test = cell(1,4);

% Trening skup
reci_trening{1,1} = zero_trening;
reci_trening{1,2} = one_trening;
reci_trening{1,3} = two_trening;
reci_trening{1,4} = three_trening;

% Test skup
reci_test{1,1} = zero_test;
reci_test{1,2} = one_test;
reci_test{1,3} = two_test;
reci_test{1,4} = three_test;

% Cuvanje
% save reci_trening.mat reci_trening
% save reci_test.mat reci_test
