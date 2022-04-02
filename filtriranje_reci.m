clc, clear, close all
%% Filtriranje izgovorenih reci

% Ucitavanje izgovorenih reci
reci_trening = load('reci_trening.mat');
reci_test = load('reci_test.mat');

% Trening skup
zero_tr = reci_trening.reci_trening{1,1};
one_tr = reci_trening.reci_trening{1,2};
two_tr = reci_trening.reci_trening{1,3};
three_tr = reci_trening.reci_trening{1,4};

% Test skup
zero_te = reci_test.reci_test{1,1};
one_te = reci_test.reci_test{1,2};
two_te = reci_test.reci_test{1,3};
three_te = reci_test.reci_test{1,4};

% Parametri
number_of_words_test = 20;
number_of_words = 100;
fs = 16000;
T = 1/fs;

%% Filtriranje reci

% Trening
zero_tr_new = cell(1, number_of_words);
one_tr_new = cell(1, number_of_words);
two_tr_new = cell(1, number_of_words);
three_tr_new = cell(1, number_of_words);

% Filtar propusnig opsega
nord = 6;
Wn = [300 fs/2-2000]/(fs/2);
[B, A] = butter(nord, Wn, 'bandpass');

% Filtriranje
for i = 1:number_of_words
    zero_tr_new{1,i} = filter(B, A, zero_tr{1,i});
    one_tr_new{1,i} = filter(B, A, one_tr{1,i});
    two_tr_new{1,i} = filter(B, A, two_tr{1,i});
    three_tr_new{1,i} = filter(B, A, three_tr{1,i});
end

% Test
zero_te_new = cell(1, number_of_words_test);
one_te_new = cell(1, number_of_words_test);
two_te_new = cell(1, number_of_words_test);
three_te_new = cell(1, number_of_words_test);

% Filtriranje
for i = 1:number_of_words_test
    zero_te_new{1,i} = filter(B, A, zero_te{1,i});
    one_te_new{1,i} = filter(B, A, one_te{1,i});
    two_te_new{1,i} = filter(B, A, two_te{1,i});
    three_te_new{1,i} = filter(B, A, three_te{1,i});
end

%% Cuvanje filtriranih reci

% Trening
reci_trening_filtrirane = cell(1, 4);
reci_trening_filtrirane{1,1} = zero_tr_new;
reci_trening_filtrirane{1,2} = one_tr_new;
reci_trening_filtrirane{1,3} = two_tr_new;
reci_trening_filtrirane{1,4} = three_tr_new;

% Test
reci_test_filtrirane = cell(1, 4);
reci_test_filtrirane{1,1} = zero_te_new;
reci_test_filtrirane{1,2} = one_te_new;
reci_test_filtrirane{1,3} = two_te_new;
reci_test_filtrirane{1,4} = three_te_new;

% Cuvanje
% save reci_trening_filtrirane.mat reci_trening_filtrirane
% save reci_test_filtrirane.mat reci_test_filtrirane

%% Iscrtavanje signala pre i posle filtriranja

% Pre filtriranja
figure
subplot(2,2,1)
plot(1:length(zero_tr{1,7}), zero_tr{1,7}, 'b');
title("Zero - 0");
subplot(2,2,2)
plot(1:length(one_tr{1,45}), one_tr{1,45}, 'b');
title("One - 1");
subplot(2,2,3)
plot(1:length(two_tr{1,7}), two_tr{1,7}, 'b');
title("Two - 2");
subplot(2,2,4)
plot(1:length(three_tr{1,8}), three_tr{1,8}, 'b');
title("Three - 3");

% Posle filtriranja
figure
subplot(2,2,1)
plot(1:length(zero_tr_new{1,7}), zero_tr_new{1,7}, 'b');
title("Zero - 0");
subplot(2,2,2)
plot(1:length(one_tr_new{1,45}), one_tr_new{1,45}, 'b');
title("One - 1");
subplot(2,2,3)
plot(1:length(two_tr_new{1,7}), two_tr_new{1,7}, 'b');
title("Two - 2");
subplot(2,2,4)
plot(1:length(three_tr_new{1,8}), three_tr_new{1,8}, 'b');
title("Three - 3");
