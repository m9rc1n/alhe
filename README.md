Algorytmy Heurystyczne
======================
Specyfikacja wstępna

Autorzy: Marcin Urbański, Rafał Stupienko

Treść zadania:
--------------
W ramach projektu należy przygotować implementacje dwóch metaheurystyk (zgodnie z szablonem metody przedstawionym na wykładzie) oraz porównać ich działanie. 

W ramach porównania należy:

  - rozwiązać dwuwymiarowe zadanie optymalizacji funkcji sferycznej (oraz przeanalizować wyniki)
  - rozwiązać dwuwymiarowe zadanie optymalizacji funkcji określonej w zestawie (oraz przeanalizować wyniki)
  - przygotować wizualizację (np. w formie adekwatnego wykresu) pokazującą jakie punkty generowane są w trakcie działania każdej z metod

Nasza interpretecja treści zadania
----------------------------------

Założeniem projektu jest zbadanie jak działają metody heurystyczne w praktyce. W ramach projektu otrzymaliśmy dwa algorytmy, które musimy przeanalizować korzystając z dwóch funkcji celu. Zarówno algorytmy jak i funkcje zostały opisane poniżej. Funkcje celu będą się korzystały z dwóch wymiarów, abyśmy mogli zobaczyć jak się zaimplementowane przez nas metody zachowują na takiej powierzchni. Wizualizację sporządzimy jako wykres lub animację. Posłuży ona nam do przeanalizowania algorytmów i sprawdzenia jak sobie radzą z odmiennymi w działaniu funkcjami celu oraz będzie pomocna w opracowanu wniosków. 

Metody:
-------

Pierwsza z tych metod jest metodą populacyjną, natomiast druga jednopunktową. Ma to znaczenie przy określaniu Roboczo-budżetu, ponieważ w naszym przypadku nie możemy posłużyć się przy jego określaniu liczbą iteracji, ze względu na populację algorytmu ewolucyjnego. Zamiast tego użyjemy liczby obliczeń funkcji celu oraz dokładności bądź błędu minimalizacji (lub maksymalizacji). Budżet otrzymujemy uruchamiając k-razy każdą z metod. Powinnien on generować lepsze rezultaty przy większej liczbie k.

### Algorytm ewolucyjny
Algorytm ewolucyjny jest metodą, której protoplastą jest wariant pośredni pomiędzy stochastycznym algorytmem wspinaczkowym oraz nieklasycznym błądzeniem przypadkowym, dlatego podejrzewamy, że w jego przypadku lepsze rezultaty będą w połączeniu z sferyczną funkcją celu. Implementacja i wizualizacja pozwoli nam sprawdzić nasze przypuszczenia.

Algorytm ewolucyjny (z sukcesją nieelitarną) jest metodą:

  - poinformowaną
  - niedeterministyczną
  - o modelu pamięciowym (wielkość modelu >= 1)
  - której lokalność zależy od mutacji
  - której miękkość selekcji zależy od jej typu
  - o rozmiarze okna historii nieskończonym
  - zupełności asymptotycznej (lub brak)
  
Aby zaimplementować algorytm ewolucyjny musimy wykonać na populacji kilka działań, takich jak: selekcja, krzyżowanie, mutacja oraz sukcesja. W trakcie selekcji (reprodukcji) wybieramy punkty, które zostaną poddane dalszym krokom algorytmu. Krzyżowanie to akcja polegająca na wyborze pewnych określonych cech osobników się krzyżujących, które zostaną przekazane ich potomkowi. Możemy w niej decydować o stopniu danej cechy pochodzącej od konkretnego rodzica. Mutacja jest próbą wprowadzenia pewnych losowych zmian w wygenerowanym wcześniej potomku. Krok sukcesji decyduje, które osobniki z populacji przejdą do następnej generacji.

### Próbkowanie z rozkładem jednostajnym
W tej metodzie czekając odpowiednio długo, punkty w losowy w miarę równomierny sposób powinny zapełniać dziedzinę funkcji.

Próbkowanie z rozkładem jednostajnym jest metodą:
  - niepoinformowaną
  - niedeterministyczną
  - bez modelu
  - o zerowym rozmiarze okna historii
  - o nielokalnym obszarze poszukiwań
  - o nie miękkiej selekcji
  - z zupełnością asymptotyczną


Funkcje celu:
-------------
Korzystając z dwóch odmiennych funkcji celu powyższe metody będą prezentowamy większą lub mniejszą skuteczność, ponieważ te dwie funkcje są kompletnie inne. Pierwsza z nich jest unimodalną, natomiast druga już nie.

### Funkcja sferyczna
W funkcji unimodalnej, jaką jest funkcja sferyczna, występuje jedno minimum lokalne i jest ono minimum globalnym. Przez to strategia, kiedy poruszamy się po największym zboczu(np. algorytm wspinaczkowy) będzie bardziej skuteczna.. 

#### Wykres
![Funkcja sferyczna][1]

#### Formuła
![Formuła funkcji sferycznej][4]

#### Minimum
![Minimum funkcji sferycznej][2]

#### Dziedzina
![Dziedzina funkcji sferycznej][3]

### Funkcja "eggholder"
W tej funkcji istnieje wiele minimów lokalnych. Przez pojawia się problem, kiedy punkt wpadnie w złe minimum i nie będzie mógł z niego wyjść. Według artykułu [a.1] jest to trudna funkcja do zoptymalizowania. 

#### Wykres
![Funkcja eggholder][5]
#### Formuła
![Formuła funkcji eggholder][8]
#### Minimum
![Minimum funkcji eggholder][6]
#### Dziedzina
![Dziedzina funkcji eggholder][7]
#### Alternatywny wykres
![Funkcja eggholder w realnym świecie][9]


Przebieg eksperymentu:
----------------------
Pierwszą metodą, którą będziemy badać to strategia ewolucyjna. W procesie selekcji oraz mutacji otrzymamy minimum funkcji. Podobnie samo stanie się w przypadku użycia próbkowania z rozkładem jednostajnym - tam również otrzymamy to minimum. W obydwu przypadkach przedstawimy ścieżkę dosjścia do minimum (tj. w jakiej kolejności losowały się punkty). Kolejnym krokiem analizy będzie sprawdzenie w ilu iteracjach strategii/próbkowaniu uzyskujemy minimum (jak szybko do niego zbiegamy) oraz zestawienie tych danych na wykresach w celu porównania metod. Zbadać można będzie również wpływ punktu startowego dla startegii ewolucyjnej na szybkośc zbiegania do minimum.

Takie same badania przeporwadzimy na funkcji sferycznej. Dzięki czemu będziemy w stanie porównać która z metod jest lepsza i w jakim stopniu (przy jakich parametrach).

Bibliografia:
------------
[a.1] _Some new test functions for global optimization and performance of repulsive particle swarm method_ Mishra, Sudhanshu

[n.2] _Test functions for optimization_ http://en.wikipedia.org/wiki/Test_functions_for_optimization

[1]: pictures/sphere_function.jpg "Funkcja sferyczna"
[2]: pictures/sphere_minimum.png "Minimum funkcji sferycznej"
[3]: pictures/sphere_domain.png "Dziedzina funkcji sferycznej"
[4]: pictures/sphere_formula.png "Formuła funkcji sferycznej"

[5]: pictures/eggholder_function.jpg "Funkcja eggholder"
[6]: pictures/eggholder_minimum.png "Minimum funkcji eggholder"
[7]: pictures/eggholder_domain.png "Dziedzina funkcji eggholder"
[8]: pictures/eggholder_formula.png "Formuła funkcji eggholder"
[9]: pictures/eggholder_real.jpg "Funkcja eggholder w realnym świecie"