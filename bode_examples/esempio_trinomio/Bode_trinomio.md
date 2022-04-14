
## Diagramma di bode asintotico e reale

In matlab possiamo inserire i singoli fattori della FDT scomposta in termini elementari:

	G1 = [1 -1]; 	 termine binomio s-1
	G2 = [1 10]; 	 termine binomio s+10
	G3 = [1 0];  	 termine monomio s
	G4 = [1 1 16]; 	 termine trinomio s^2 + s + 16 

e creare la FDT complessiva:

	G = tf(conv(G1,G2), conv(G3,G4));

dove tf sta per transfer function. conv(G1,G2) calcola il prodotto dei termini al numeratore in s. Stessa cosa per il denominatore.

	G =
 
   		s^2 + 9 s - 10
  		----------------
  		s^3 + s^2 + 16 s

Se si dispone solo della forma non fattorizzata come la precedente si deve porre:

	Numeratore = [1 9 -10];

	Denominatore = [1 1 16];

e poi porre:

	G = tf(Numeratore, Denominatore);

## Calcolo degli zeri della FDT

Tramiter la funzione:

	zero(G)

		ans =
			-10
			1


## Calcolo dei poli della FDT

Tramite la funzione:

	pole(G)

possiamo determinare i poli della FDT:

		ans =

   			 0.0000 + 0.0000i
  			-0.5000 + 3.9686i
  			-0.5000 - 3.9686i

come vediamo la FDT ha due poli complessi coniugati e un polo nell'origine. Il termine trinomio non può essere scomposto.

## Visualizzazione sul piano cartesiano di poli e zeri della FDT

Tramite la funzione:

		pzplot(G);
		grid

è possibile ottenere il posizionamento dei poli e degli zeri sul piano complesso.

![This is an image](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/poli_zeri_example.jpg)



## Diagramma di Bode asintotico e reale
 
Il matlab consente di ottenere solo i diagrammi reali e non quelli asintotici:

		bode(G);
		grid;
		
		


## Diagramma di Bode asintotico e reale

Tuttavia è possibile ottenere il diagramma di Bode asintotico attraverso uno script matlab da inserire nell'editor, salvare con il nome bode_asymp.m e poi renderlo eseguibile dando l'autorizzazione ad includere la cartella tra i percorsi eseguibili. 

Basta ora nella riga di comando scrivere:


		bode_asymp(conv(G1,G2), conv(G3,G4));
		

per ottenere i grafici in figura:


![This is an image](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/Modulo_asint.png)


La linea blu è il reale quella rossa asintotico.

![This is an image](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/Fase_asint.png)

## Script bode_asymp.m per matlab

[bode_asymp.m](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/bode_asymp.m)

## Script bode_asymp.m per octave

[bode_asymp.m](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/bode_asympt.m)


