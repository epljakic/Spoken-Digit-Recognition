clc, clear, close all
%% Klasifikacija pomocu neuralne mreze

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
number_of_samples = 20;
number_of_words = 100;
fs = 16000;
T = 1/fs;
p = 12;

%% Priprema trening podataka pred klasifikaciju
lpc_zero = cell(1,number_of_words);
lpc_one = cell(1,number_of_words);
lpc_two = cell(1,number_of_words);
lpc_three = cell(1,number_of_words);

for i = 1:number_of_words
    % Zero - 0
    zero = [];
    if number_of_samples == length(lpc_zero_tr{1,i})
        for j = 1:number_of_samples           
            zero = [zero, lpc_zero_tr{1,i}(j,:)];
        end
    else
        ratio = size(lpc_zero_tr{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            zero = [zero, lpc_zero_tr{1,i}(ind,:)];
        end
    end
    lpc_zero{1,i} = zero';
    
    % One - 1
    one = [];
    if number_of_samples == length(lpc_one_tr{1,i})
        for j = 1:number_of_samples           
            one = [one, lpc_one_tr{1,i}(j,:)];
        end
    else
        ratio = size(lpc_one_tr{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            one = [one, lpc_one_tr{1,i}(ind,:)];
        end
    end
    lpc_one{1,i} = one';
    
    % Two - 2
    two = [];
    if number_of_samples == length(lpc_two_tr{1,i})
        for j = 1:number_of_samples           
            two = [two, lpc_two_tr{1,i}(j,:)];
        end
    else
        ratio = size(lpc_two_tr{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            two = [two, lpc_two_tr{1,i}(ind,:)];
        end
    end
    lpc_two{1,i} = two';
    
    % Three - 3
    three = [];
    if number_of_samples == length(lpc_three_tr{1,i})
        for j = 1:number_of_samples           
            three = [three, lpc_three_tr{1,i}(j,:)];
        end
    else
        vel = size(lpc_three_tr{1,i});
        ratio = size(lpc_three_tr{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            three = [three, lpc_three_tr{1,i}(ind,:)];
        end
    end
    lpc_three{1,i} = three';
end

%% Priprema test podataka pred klasifikaciju
lpc_zero_t = cell(1,number_of_words_test);
lpc_one_t = cell(1,number_of_words_test);
lpc_two_t = cell(1,number_of_words_test);
lpc_three_t = cell(1,number_of_words_test);

for i = 1:number_of_words_test
    
    % Zero - 0
    zero = [];
    if number_of_samples == length(lpc_zero_te{1,i})
        for j = 1:number_of_samples           
            zero = [zero, lpc_zero_te{1,i}(j,:)];
        end
    else
        ratio = size(lpc_zero_te{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            zero = [zero, lpc_zero_te{1,i}(ind,:)];
        end
    end
    lpc_zero_t{1,i} = zero';
    
    %One - 1
    one = [];
    if number_of_samples == length(lpc_one_te{1,i})
        for j = 1:number_of_samples           
            one = [one, lpc_one_te{1,i}(j,:)];
        end
    else
        ratio = size(lpc_one_te{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            one = [one, lpc_one_te{1,i}(ind,:)];
        end
    end
    lpc_one_t{1,i} = one';
    
    % Two - 2
    two = [];
    if number_of_samples == length(lpc_two_te{1,i})
        for j = 1:number_of_samples           
            two = [two, lpc_two_te{1,i}(j,:)];
        end
    else
        ratio = size(lpc_two_te{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            two = [two, lpc_two_te{1,i}(ind,:)];
        end
    end
    lpc_two_t{1,i} = two';
    
    % Three - 3
    three = [];
    if number_of_samples == length(lpc_three_te{1,i})
        for j = 1:number_of_samples           
            three = [three, lpc_three_te{1,i}(j,:)];
        end
    else
        ratio = size(lpc_three_te{1,i},1)/number_of_samples;
        for j = 1:number_of_samples
            if round(j*ratio) == 0
                ind = 1;
            else
                ind = round(j*ratio);
            end
            three = [three, lpc_three_te{1,i}(ind,:)];
        end
    end
    lpc_three_t{1,i} = three';
end

%% Formiranje ulaza i izlaza test skupa
clear zero_te one_te two_te three_te
zero_te = zeros(number_of_samples*p, number_of_words_test);
one_te = zeros(number_of_samples*p, number_of_words_test);
two_te = zeros(number_of_samples*p, number_of_words_test);
three_te = zeros(number_of_samples*p, number_of_words_test);

for i = 1:number_of_words_test
    zero_te(:,i) = lpc_zero_t{1,i};
    one_te(:,i) = lpc_one_t{1,i};
    two_te(:,i) = lpc_two_t{1,i};
    three_te(:,i) = lpc_three_t{1,i};
end

ulaz = [zero_te, one_te, two_te, three_te];
val = size(ulaz);
N = val(2);

izlaz = zeros(4, N);
izlaz(1, 1:20) = 1;
izlaz(2, 21:40) = 1;
izlaz(3, 41:60) = 1;
izlaz(4, 61:80) = 1;

% Mesanje indeksa
ind = randperm(N);
ulaz_test = ulaz(:, ind);
izlaz_test = izlaz(:, ind);

%% Formiranje ulaza i izlaza trening skupa
clear zero_tr one_tr two_tr three_tr
zero_tr = zeros(number_of_samples*p, number_of_words);
one_tr = zeros(number_of_samples*p, number_of_words);
two_tr = zeros(number_of_samples*p, number_of_words);
three_tr = zeros(number_of_samples*p, number_of_words);

for i = 1:number_of_words
    zero_tr(:,i) = lpc_zero{1,i};
    one_tr(:,i) = lpc_one{1,i};
    two_tr(:,i) = lpc_two{1,i};
    three_tr(:,i) = lpc_three{1,i};
end

ulaz = [zero_tr, one_tr, two_tr, three_tr];
val = size(ulaz);
N = val(2);

izlaz = zeros(4, N);
izlaz(1, 1:100) = 1;
izlaz(2, 101:200) = 1;
izlaz(3, 201:300) = 1;
izlaz(4, 301:400) = 1;

% Podela trenirajuceg skupa na trening i validacioni skup
ind = randperm(N);
ind_trening = ind(1:0.9*N);
ind_val = ind(0.9*N+1:N);

ulaz_trening = ulaz(:, ind_trening);
izlaz_trening = izlaz(:, ind_trening);
ulaz_val = ulaz(:, ind_val);
izlaz_val = izlaz(:, ind_val);

ulaz_sve = [ulaz_trening, ulaz_val];
izlaz_sve = [izlaz_trening, izlaz_val];

%% Pronalazenje najboljih parametara za neuralnu mrezu
arh = 30;
Abest = 0;
for lr = [0.01, 0.05, 0.1]
    for reg = [0.2, 0.3, 0.4]
        for mom = [0.7, 0.8, 0.9]
            %klasifikacija
            net = patternnet(arh);
            
            %akf fje u slojevima u skrivene relu, izlazni sloj sofmax,
            net.layers{1}.transferFcn = 'poslin';
            %net.layers{2}.transferFcn = 'poslin';
            
            net.trainFcn = 'traingdm';
            
            % Zastita od preobucavanja
            net.divideFcn = 'divideind';
            net.divideParam.trainInd = 1:0.9*N;
            net.divideParam.valInd = 0.9*N+1:N; 
            net.divideParam.testInd = []; % prazan za test!
            
            % Momentum
            net.trainParam.mc = mom;
            net.trainParam.lr = lr;
            net.performParam.regularization = reg;
            
            net.trainParam.epochs = 2000;
            net.trainParam.goal = 1e-4;
            net.trainParam.min_grad = 1e-5;
            net.trainParam.max_fail = 20;
            
            net.trainParam.showWindow = false;
            net.trainParam.showCommandLine = true;
            
            [net, tr] = train(net, ulaz_sve, izlaz_sve);
            
            pred_val = net(ulaz_val);
            [e, ~] = confusion(izlaz_val, pred_val);
            A = 1 - e;
            
            % A - accuracy
            disp(A)
            if A > Abest 
                Abest = A;
                lrBest = lr;
                momBest = mom;
                regBest = reg;
              
                epBest = tr.best_epoch; 
                
                net_best = net;
                save net_best.mat net_best
            end
        end
    end
end

%% Testiranje najbolje pronadjene nm-e iz prethodnog koraka
moje = load('net_90.mat');
pred_test = moje.net_best(ulaz_test);
figure
plotconfusion(izlaz_test, pred_test);

%% Finalna neuralna mreza sa tim parametrima
momBest = 0.9;
lrBest = 0.1;
regBest = 0.3;
epBest = 2000;

arh = 40;
net = patternnet(arh);

net.layers{1}.transferFcn = 'poslin';

% net.trainFcn = 'traingdm';
net.trainFcn = 'traingdm';
            
net.divideFcn = 'dividerand';
net.divideParam.testRatio = 0;
net.divideParam.trainRatio = 0.9;
net.divideParam.valRatio = 0.1;
          
% Momentum
net.trainParam.mc = momBest;
net.trainParam.lr = lrBest;
% net.performParam.regularization = regBest;
            
net.trainParam.epochs = epBest;
net.trainParam.goal = 1e-4;
net.trainParam.min_grad = 1e-5;
net.trainParam.max_fail = 20;
            
net.trainParam.showWindow = true;
net.trainParam.showCommandLine = false; 
            
[net, tr] = train(net, ulaz_sve, izlaz_sve);

%% Testiranje neuralne mreze
pred_test = net(ulaz_test);
figure
plotconfusion(izlaz_test, pred_test);

%% Cuvanje neuralne mreze
net_best = net;
% save net_90.mat net_best
