function [masa_sprzegla,czas_zatrzymania] = model(prom_zew,prom_wew, grubosc, ilosc)
    %MODEL Model sprzegla plytkowego
    %   Detailed explanation goes here
    dane_wejsciowe;

    masa_sprzegla = pi .* ((prom_zew.*prom_zew) - (prom_wew .* prom_wew)) .* grubosc .* (ilosc + 1) .* ro;

    M_h = (2/3) .* mikro_u .* F .* Z .* (((prom_zew .^ 3) - (prom_wew .^ 3)) / ((prom_zew .^ 2) - (prom_wew .^ 2)));
    pred_kat = pi * n / 30;

    moment_inerc = 1
    moment_tarcia = 1
    
    czas_zatrzymania = (moment_inerc * pred_kat) / (M_h + moment_tarcia)
end