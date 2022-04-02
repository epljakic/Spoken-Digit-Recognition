clc, clear, close all
%% Klasifikacija pomocu DTW-a (Dynamic Time Warping)

% Ucitavanje lpc koeficijenata 
reci_trening = load('reci_trening_lpc.mat');
reci_test = load('reci_test_lpc.mat');

lpc_zero_tr = reci_trening.reci_trening_lpc{1,1};
lpc_one_tr = reci_trening.reci_trening_lpc{1,2};
lpc_two_tr = reci_trening.reci_trening_lpc{1,3};
lpc_three_tr = reci_trening.reci_trening_lpc{1,4};

lpc_zero_te = reci_test.reci_test_lpc{1,1};
lpc_one_te = reci_test.reci_test_lpc{1,2};
lpc_two_te = reci_test.reci_test_lpc{1,3};
lpc_three_te = reci_test.reci_test_lpc{1,4};

% Parametri
number_of_words_test = 20;
number_of_words = 100;
fs = 16000;
T = 1/fs;
p = 12;

%% Priprema trening podataka pred klasifikaciju
lpc_zero = cell(1,20);
lpc_one = cell(1,20);
lpc_two = cell(1,20);
lpc_three = cell(1,20);

k = 1;
for i = 1:5:number_of_words
    % Zero - 0
    zero = [];
    val = size(lpc_zero_tr{1,i});
    for j = 1:val(1)      
        zero = [zero, lpc_zero_tr{1,i}(j,:)];
    end
    lpc_zero{1,k} = zero;
    
    % One - 1
    one = [];
    val = size(lpc_one_tr{1,i});
    for j = 1:val(1)       
        one = [one, lpc_one_tr{1,i}(j,:)];
    end
    lpc_one{1,k} = one;
    
    % Two - 2
    two = [];
    val = size(lpc_two_tr{1,i});
    for j = 1:val(1)      
        two = [two, lpc_two_tr{1,i}(j,:)];
    end
    lpc_two{1,k} = two;
    
    % Three - 3
    three = [];
    val = size(lpc_three_tr{1,i});
    for j = 1:val(1)      
        three = [three, lpc_three_tr{1,i}(j,:)];
    end
    lpc_three{1,k} = three;
    
    k = k + 1;
end

%% Priprema test podataka pred klasifikaciju
lpc_zero_t = cell(1,number_of_words_test);
lpc_one_t = cell(1,number_of_words_test);
lpc_two_t = cell(1,number_of_words_test);
lpc_three_t = cell(1,number_of_words_test);

for i = 1:number_of_words_test
    % Zero - 0 
    zero = [];
    val = size(lpc_zero_te{1,i});
    for j = 1:val(1)    
        zero = [zero, lpc_zero_te{1,i}(j,:)];
    end
    lpc_zero_t{1,i} = zero;
    
    % One - 1
    one = [];
    val = size(lpc_one_te{1,i});
    for j = 1:val(1)     
        one = [one, lpc_one_te{1,i}(j,:)];
    end
    lpc_one_t{1,i} = one;
    
    % Two - 2
    two = [];
    val = size(lpc_two_te{1,i});
    for j = 1:val(1)     
        two = [two, lpc_two_te{1,i}(j,:)];
    end
    lpc_two_t{1,i} = two;
    
    % Three - 3
    three = [];
    val = size(lpc_three_te{1,i});
    for j = 1:val(1)    
        three = [three, lpc_three_te{1,i}(j,:)];
    end
    lpc_three_t{1,i} = three;
end

%% Testiranje DTW algoritma za prepoznavanje govora
good_zero = 0;
good_one = 0;
good_two = 0;
good_three = 0;

% Testiranje za rec/broj "zero-0"
for j = 1:number_of_words_test
    min_zero = 10000; min_one = 10000; min_two = 10000; min_three = 10000;
    for i = 1:20
        [d1,D1] = dtw_distanca(lpc_zero{1,i}, lpc_zero_t{1,j});
        [d2,D2] = dtw_distanca(lpc_one{1,i}, lpc_zero_t{1,j});
        [d3,D3] = dtw_distanca(lpc_two{1,i}, lpc_zero_t{1,j});
        [d4,D4] = dtw_distanca(lpc_three{1,i}, lpc_zero_t{1,j});

        if d1 < min_zero
            min_zero = d1;
        end
        if d2 < min_one
            min_one = d2;
        end
        if d3 < min_two
            min_two = d3;
        end
        if d4 < min_three
            min_three = d4;
        end
        
    end
    clear predikcija
    predikcija = [min_zero, min_one, min_two, min_three];
    [~, ind] = min(predikcija);
    if ind == 1
        good_zero = good_zero + 1;
    end
end

% Testiranje za rec/broj "one-1"
for j = 1:number_of_words_test
    min_zero = 10000; min_one = 10000; min_two = 10000; min_three = 10000;
    for i = 1:20
        [d1,D1] = dtw_distanca(lpc_zero{1,i}, lpc_one_t{1,j});
        [d2,D2] = dtw_distanca(lpc_one{1,i}, lpc_one_t{1,j});
        [d3,D3] = dtw_distanca(lpc_two{1,i}, lpc_one_t{1,j});
        [d4,D4] = dtw_distanca(lpc_three{1,i}, lpc_one_t{1,j});
        
        if d1 < min_zero
            min_zero = d1;
        end
        if d2 < min_one
            min_one = d2;
        end
        if d3 < min_two
            min_two = d3;
        end
        if d4 < min_three
            min_three = d4;
        end
        
    end
    clear predikcija
    predikcija = [min_zero, min_one, min_two, min_three];
    [~, ind] = min(predikcija);
    if ind == 2
        good_one = good_one + 1;
    end
end

% Testiranje za rec/broj "two-2"
for j = 1:number_of_words_test
    min_zero = 10000; min_one = 10000; min_two = 10000; min_three = 10000;
    for i = 1:20
        [d1,D1] = dtw_distanca(lpc_zero{1,i}, lpc_two_t{1,j});
        [d2,D2] = dtw_distanca(lpc_one{1,i}, lpc_two_t{1,j});
        [d3,D3] = dtw_distanca(lpc_two{1,i}, lpc_two_t{1,j});
        [d4,D4] = dtw_distanca(lpc_three{1,i}, lpc_two_t{1,j});

        if d1 < min_zero
            min_zero = d1;
        end
        if d2 < min_one
            min_one = d2;
        end
        if d3 < min_two
            min_two = d3;
        end
        if d4 < min_three
            min_three = d4;
        end
        
    end
    clear predikcija
    predikcija = [min_zero, min_one, min_two, min_three];
    [~, ind] = min(predikcija);
    if ind == 3
        good_two = good_two + 1;
    end
end

% Testiranje za rec/broj "three-3"
for j = 1:number_of_words_test
    min_zero = 10000; min_one = 10000; min_two = 10000; min_three = 10000;
    for i = 1:20
        [d1,D1] = dtw_distanca(lpc_zero{1,i}, lpc_three_t{1,j});
        [d2,D2] = dtw_distanca(lpc_one{1,i}, lpc_three_t{1,j});
        [d3,D3] = dtw_distanca(lpc_two{1,i}, lpc_three_t{1,j});
        [d4,D4] = dtw_distanca(lpc_three{1,i}, lpc_three_t{1,j});

        if d1 < min_zero
            min_zero = d1;
        end
        if d2 < min_one
            min_one = d2;
        end
        if d3 < min_two
            min_two = d3;
        end
        if d4 < min_three
            min_three = d4;
        end
        
    end
    clear predikcija
    predikcija = [min_zero, min_one, min_two, min_three];
    [~, ind] = min(predikcija);
    if ind == 4
        good_three = good_three + 1;
    end
end

%% Rezultat
uspesnost = (good_zero+good_one+good_two+good_three)*100/(80);
poruka =['Uspesnost je = ', num2str(uspesnost),'%.'];
disp(poruka);
