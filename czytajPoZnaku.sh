#!/usr/bin/env bash

# Program, który napiszę tekst znajdujący jako argument programu, a następnie powie go po literce 
# UWAGA: program wymaga pakietu 'espeak'
#
# aby użyć programu należy wykonać:
# ./tekst_po_litercie.sh TEKST
# gdzie TEKST to tekst który ma czytać komputer po litercie


# wypiszanie całego tekstu i ilości słów
echo Tekst: $@
echo Ilość Słów: $#

# tablice
tekst=($@)	# przechowóje cały tekst

# zmienne
jezyk=pl	# ustawia język do mówiena przez program
timer=.3	# ustawienia ile czasu ma cziekać komputer, przed powiedzieniem kolejniej literki


# sprawdźnienie czy program espeak jest zainstalowany, jeśli go nie ma to wyłącz program
[ ! -e /bin/espeak ] && echo BŁĄD: brak pakietu espeak && exit 1


# pętla for wykonuje się tyle razy ile jest słów w tablicy 'tekst'
for (( i=0; i<${#tekst[*]}; i++ ))
do
	#echo ---
	#echo ${tekst[i]}
	#echo slowo -\> $slowo

	# ustawia zawartość zmiennej 'slowo' na zawartość i-ntej pozycji w tablicy 'tekst'
	slowo=${tekst[i]}

	#echo !slowo -\> "${#slowo}"
	
	# pętla for wykonuje się tyle razy ile jest liter w słowie przechowiwanym w zmiennej 'slowo'
	for (( l=0; l<${#slowo}; l++ ))
	do
		# ustawienie zmiennej 'litera' na l-tą literę słowa 'slowo'
		litera=${slowo:$l:1}
		#echo ${litery[*]}

		# wypiszanie i powiedzienie tekstu
		echo -en $litera
		echo -en $litera | espeak -v $jezyk
		sleep $timer

	done

	# dodanie odstępu między słowami
	echo -en \\t

	# usuwanie zawartości tablicy
	unset litery[*]
done

# dodanie entera, by był odstęp od znaku zachęty od tekstu wypisaniego przez ten program 
echo -e \\n

