function lpc = lpc_estimacija(rxx, p)
% Linear Prediction Coefficients
% lpc - LPC koeficijenti

% Autokorelaciona funkcija je simetricna i sredina se nalazi na polovini
% njene duzine
N = ceil(length(rxx)/2);
R = zeros(p,p);

% Upisivanje odbiraka iz autokorelacione funkcije u odgovarajucu matricu
for k = 1:p
    R(:,k) = rxx(N+1-k:N+p-k);
end

lpc = -inv(R)*transpose(rxx(N+1:N+p));
end