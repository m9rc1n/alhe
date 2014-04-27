Algorytmy Heurystyczne
======================
Specyfikacja wstępna

Autorzy: Marcin Urbański, Rafał Stupienko

Treść zadania:
--------------
W ramach projektu należy przygotować implementacje dwóch metaheurystyk (zgodnie z szablonem metody przedstawionym na wykładzie) oraz porównać ich działanie. 

W ramach porównania należy:
x rozwiązać dwuwymiarowe zadanie optymalizacji funkcji sferycznej (oraz przeanalizować wyniki)
x rozwiązać dwuwymiarowe zadanie optymalizacji funkcji określonej w zestawie (oraz przeanalizować wyniki)
przygotować wizualizację (np. w formie adekwatnego wykresu) pokazującą jakie punkty generowane są w trakcie działania każdej z metod

Nasza interpretecja treści zadania
----------------------------------

Założeniem projektu jest zobaczenie jak działają metody heurystyczne w praktyce. W ramach projektu dostaliśmy dwa algorytmy, które musimy zbadać na dwóch funkcjach celu. Funkcje celu będą dwuwymiarowe po to, żebyśmy mogli zobaczyć jak się algorytm porusza po takiej powierzchni. Prawdziwe benchmarki rozwiązują zadanie optymalizacji w stu wymiarach. 
Zaimplementować te dwie metody. Na dwóch funkcjach celu zrobić wizualizację jak się poruszają te punkty w dwóch wymiarach. 
Zobaczyć jak różnią się w swoim zachowaniu te metody. Przygotować wizualizację, wykres animację. Porównać z tymi dwiema funkcjami. 

Metody:
-------
### Algorytm ewolucyjny

Algorytm ewoucyjny populacją, która sobie ewoluuje i skacze. 

### Próbkowanie z rozkładem jednostajnym
Rozkład jednostajny - poczakajmy odpowiednio długo, punkty w losowy w miarę równomierny sposób zapełniały dziedzinę funkcji.


Funkcje celu:
-------------
Jak mamy dwie kompletnie odmienne funkcje celu to te dwie metody będą mniej lub bardziej skuteczne.

### Funkcja sferyczna
Unimodalna sferyczna jedno minimum - to strategia kiedy poruszamy się po największym zboczu jest najbardziej skuteczna, najbardziej goni do celu. 

![Funkcja sferyczna][1]
![Minimum funkcji sferycznej][2]
![Dziedzina funkcji sferycznej][3]
![Formuła funkcji sferycznej][4]

### Funkcja "eggholder"
Eggholder - biedny punkcik trafi w dół lejka i stamtąd nie wyjdzie

![Funkcja eggholder][5]
![Minimum funkcji eggholder][6]
![Dziedzina funkcji eggholder][7]
![Formuła funkcji eggholder][8]
![Funkcja eggholder w realnym świecie][9]

Wnioski. To jest cały projekt. Patrząc na wykresy można sobie uzmysłowić, że algorytm ewolucyjny widać mutacje populacja skacze.

Roboczo budźet - liczba iteracji - nie. maksymalna liczba obliczeń funkcji celu. jakość Dokładność błąd mminimalizacji. 20 razy dla każdego budźetu każdą z metod. Jak zwiększając budźe poprawia nam się wynik. 

jedna populacyjna, druga jest jednym punktem. 

[1]: sphere_function.jpg "Funkcja sferyczna"
[2]: sphere_minimum.png "Minimum funkcji sferycznej"
[3]: sphere_domain.png "Dziedzina funkcji sferycznej"
[4]: sphere_formula.png "Formuła funkcji sferycznej"

[5]: eggholder_function.jpg "Funkcja eggholder"
[6]: eggholder_minimum.png "Minimum funkcji eggholder"
[7]: eggholder_domain.png "Dziedzina funkcji eggholder"
[8]: eggholder_formula.png "Formuła funkcji eggholder"
[9]: eggholder_real.jpg "Funkcja eggholder w realnym świecie"