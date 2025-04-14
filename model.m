function [masa_sprzegla, czas_zatrzymania, okreslenie_celu] = model(prom_zewn, prom_wewn, grubosc, ilosc, sila_wlaczajaca)
    %MODEL Model sprzegla plytkowego
    %   Funkcja opisująca zachowanie się sprzęgła wielopłytkowego
    
    % Określenie czy wynik_1 oraz wynik_2 dązy do minimalizacji (0) czy
    % maksymalizacji (1)
    okreslenie_celu = [0, 0];

    % inicjalizacja zmiennych
    dane_wejsciowe;

    masa_sprzegla = pi .* ((prom_zewn .^ 2) - (prom_wewn .^ 2)) .* grubosc .* (ilosc + 1) .* ro;

    M_h = (2/3) .* mikro_u .* sila_wlaczajaca .* ilosc .* (((prom_zewn .^ 3) - (prom_wewn .^ 3)) / ((prom_zewn .^ 2) - (prom_wewn .^ 2)));
    pred_kat = pi .* n / 30;
    
    moment_inerc = ilosc .* (1/2) .* (ro * pi * grubosc * ((prom_zewn .^ 2) - (prom_wewn .^ 2))) .* (((prom_wewn + prom_zewn) / 2).^2);
    
    F_norm = sila_wlaczajaca / ilosc;
    F_tarcia = F_norm .* mikro_u;
    prom_sr = (prom_zewn + prom_wewn) / 2;

    moment_tarcia = F_tarcia * prom_sr * ilosc;

    czas_zatrzymania = (moment_inerc .* pred_kat) / (M_h + moment_tarcia);
end