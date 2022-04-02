function [pocetak,kraj]=segmentacija_tiger_energijom(yf,ITU,ITL,S,F,Te,P)
% Teager energija
% pocetak - pocetak detektovane reci
% kraj - kraj detetkovane reci

pocetak_reci = [];
kraj_reci = [];

% Prethodni odbirak manji, a trenutni odbirak veci od gornjeg praga-pocetak
% Prethodni odbirak veci, a trenutni odbirak manji od gornjeg preaga - kraj
for i = 1:length(Te)-1
    if (i == 1) && (Te(i) >= ITU)
        pocetak_reci = [pocetak_reci i];
    elseif (Te(i)<ITU)&&(Te(i+1)>=ITU)
        pocetak_reci = [pocetak_reci i+1];
    end
    if (Te(i)>ITU)&&(Te(i+1)<=ITU)
        kraj_reci = [kraj_reci i+1];
    end
end

% Ukoliko tiger energija neke reci ne padne ispod praga do kraja govora
% moramo obezbediti da se kraj postavi na maksimalnu duzinu te sekvence.
if not(length(pocetak_reci) == length(kraj_reci))
    kraj_reci = [kraj_reci (length(Te)-10)];
end

pocetak = pocetak_reci;
kraj = kraj_reci;

% Uklanjanje dela govora u kome se cuje kliktanje misa. :)
clear ind pocetak_reci kraj_reci
duzina = length(pocetak);
ind = zeros(1, duzina);
for i = 1:duzina
    if (kraj(i)-pocetak(i)) < 100
        ind(i) = 1;
    end
end
k = 1;
for i = 1:duzina
    if not(ind(i) == 1)
        pocetak_reci(k) = pocetak(i);
        kraj_reci(k) = kraj(i);
        k = k + 1;
    end
end
clear pocetak kraj
pocetak = pocetak_reci;
kraj = kraj_reci;

% Pomeranje pocetaka levo, ukoliko je energija veca od donjeg praga
for i = 1:length(pocetak)
    pomeranje = pocetak(i);
    flag = 1;
    brojac = 0;
    while(flag)
        if Te(pomeranje)>ITL
            flag = 1;
            brojac = 0;
        else 
            brojac = brojac+1;
            if brojac>10
                flag = 0;
            else
                flag = 1;
            end
        end
        if pomeranje>1
            pomeranje = pomeranje-1;
        else
            flag = 0;
        end
    end
    pocetak(i) = pomeranje;
end

% Pomeranje kreja desno, ukoliko je energija veca od donjeg praga
for i = 1:length(kraj)
    pomeranje = kraj(i);
    flag = 1;
    brojac = 0;
    while(flag)
        if Te(pomeranje)>ITL
            flag = 1;
            brojac = 0;
        else 
            brojac = brojac+1;
            if brojac>10
                flag = 0;
            else
                flag = 1;
            end
        end
        if pomeranje<length(Te)
            pomeranje = pomeranje+1; 
        else
            flag = 0;
        end
    end
    kraj(i) = pomeranje;
end

% Sredjivanje pocetaka i krajeva reci da ne bi bili duplikatia
clear pocetak1 kraj1

pocetak1(1) = pocetak(1);
k = 1;
for i = 2:length(pocetak)
    if pocetak(i) ~= pocetak1(k) 
        k = k+1;
        pocetak1(k) = pocetak(i);
    end
end

kraj1(1) = kraj(1);
k = 1;
for i = 2:length(kraj)
    if kraj(i) ~= kraj1(k)
        k = k+1;
        kraj1(k) = kraj(i);
    end
end
clear pocetak kraj
pocetak = pocetak1;
kraj = kraj1;

% Spajanje reci ciji su poceci bliski krajevima drugih reci
clear pocetak1 kraj1
pocetak1 = [];
kraj1 = [];
prag = 7000;
duzina = length(pocetak);
pocetak_ = zeros(size(pocetak));
kraj_ = zeros(size(pocetak));

for i = 1 : duzina - 1
    if (pocetak(i+1) - kraj(i) < prag)
        pocetak_(i+1) = 1;
        kraj_(i) = 1;
    end
end

k = 1;
j = 1;
for i = 1 : duzina
    if (pocetak_(i) == 0)
        pocetak1(k) = pocetak(i);
        k = k + 1;
    end
    if (kraj_(i) == 0)
        kraj1(j) = kraj(i);
        j = j + 1;
    end
end

clear kraj pocetak
pocetak = pocetak1;
kraj = kraj1;
end