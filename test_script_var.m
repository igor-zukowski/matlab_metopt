dane_wejsciowe;
[wynik_1,wynik_2,cel] = model(R_i(1),R_0(1),A(1),Z(1),F(1));

disp(wynik_1);
disp(wynik_2);
disp(cel);

masa_sprzegla=0;
czas_zatrzymania=0;

f_top = Inf;
zmienne_top = [];

N=50000;


for i = 1:N
    rand_prom_zew = R_i(randi(length(R_i)));
    rand_prom_wew = R_0(randi(length(R_0)));
    rand_grub = A(randi(length(A)));
    rand_ilosc = Z(randi(length(Z)));
    rand_sila = F(randi(length(F)));
    

    if rand_prom_zew - rand_prom_wew < delta_R
        continue;
    end

    [p_masa_sprzegla, p_czas_zatrzymania,cel] = model(rand_prom_zew, rand_prom_wew, rand_grub, rand_ilosc, rand_sila);
    
    if  ~(rand_prom_zew >= R_i_min && ...
        R_0_max >= rand_prom_wew && ...
        rand_prom_zew - rand_prom_wew >= delta_R && ... 
        rand_grub >= A_min && ... 
        A_max >= rand_grub && ...
        L_max >= (rand_ilosc+1)*(rand_grub + delta) && ... 
        Z_max >= (rand_ilosc+1) && ...
        rand_ilosc >= 1 && ...
        % p_dop >= p_rz && ...
        % p_dop * V_smax >= p_rz * rand_sila/S && ...
        V_smax >= V_sr && ...
        t_max >= p_czas_zatrzymania && ...
        M_h >= k * M_s * V_sr && ...
        p_czas_zatrzymania >= 0 && ...
        rand_sila >= 0 && ...
        F_max >= rand_sila)

        continue;
    end

    f_wkryt = p_masa_sprzegla * 1 + p_czas_zatrzymania * 1;

    if f_wkryt < f_top
        f_top = f_wkryt;
        zmienne_top = [rand_prom_zew, rand_prom_wew, rand_grub, rand_ilosc, rand_sila];
        masa_sprzegla = p_masa_sprzegla;
        czas_zatrzymania = p_czas_zatrzymania;
    end
    
end

if isempty(zmienne_top)
    fprintf("Ni mo\n");

else
    fprintf('\n--- NAJLEPSZE ZNALEZIONE ROZWIĄZANIE ---\n');
    fprintf('Promień zewnętrzny: %.2f mm\n', zmienne_top(1));
    fprintf('Promień wewnętrzny: %.2f mm\n', zmienne_top(2));
    fprintf('Grubość tarczy: %.2f mm\n', zmienne_top(3));
    fprintf('Ilość tarcz: %d\n', zmienne_top(4));
    fprintf('Siła włączająca: %.2f N\n', zmienne_top(5));
    fprintf('Masa sprzęgła: %.6f kg\n', masa_sprzegla);
    fprintf('Czas zatrzymania: %.4f s\n', czas_zatrzymania);

end
