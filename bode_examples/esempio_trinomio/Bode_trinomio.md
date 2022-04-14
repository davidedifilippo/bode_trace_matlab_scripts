
## Diagramma di bode asintotico e reale

In matlab possiamo inserire i singoli fattori della FDT scomposta in termini elementari:

	G1 = [1 -1]; 	 termine binomio s-1
	G2 = [1 10]; 	 termine binomio s+10
	G3 = [1 0];  	 termine monomio s
	G4 = [1 1 16]; 	 termine trinomio s^2 + s + 16 

e creare la FDT complessiva:

	G = tf(conv(G1,G2), conv(G3,G4));

dove tf sta per transfer funztion. conv(G1,G2) calcola il prodotto dei termini al numeratore in s. Stessa cosa per il denominatore.

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

Tuttavia è possibile ottenere il diagramma di Bode asintotico attraverso uno script matlab da inserire nell'editor, salvare con il nome bode_asymp.m e poi rendere eseguibile dando l'autorazzazione ad includere la cartella tra i percorsi eseguibili. Basta ora 
scrivere:


		bode_asymp(conv(G1,G2), conv(G3,G4));
		

per ottenere i grafici in figura:


![This is an image](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/Modulo_asint.png)


La linea blu è il reale quella rossa asintotico.

![This is an image](https://github.com/davidedifilippo/bode_trace_matlab_scripts/blob/main/bode_examples/esempio_trinomio/Fase_asint.png)

## Script bode_asymp.m

	function bode_as(num,den)
	zroots=roots(num);
	proots=roots(den);
	[iz,jz]=find(abs(zroots)==0); 
	numz=length(iz);
	[ip,jp]=find(abs(proots)==0); 
	nump=length(ip);
	pend=numz-nump;
	sz=[1:length(zroots)];
	sp=[1:length(proots)];
	zroots=zroots(setdiff(sz,iz),:);
	proots=proots(setdiff(sp,ip),:);
	zroots2=abs(zroots)-j*real(zroots)./abs(zroots);
	proots2=abs(proots)-j*real(proots)./abs(proots);
	zz=ones(size(zroots2,1),3);
	zz(:,2)=real(zroots2);
	zz(:,3)=imag(zroots2);
	pp=-ones(size(proots2,1),3);
	pp(:,2)=real(proots2);
	pp(:,3)=imag(proots2);
	%tracciamento moduli
	pp_mag=pp;
	zz_mag=zz;
	vect=[zz_mag;pp_mag];
	vect=sortrows(vect,2);
	interval=zeros(1,size(vect,1)+2);
	interval(:,[2:(size(vect,1)+1)])=vect(:,2)';
	try
	interval(1,1)=0.01*vect(1,2);
	interval(1,end)=100*vect(end,2);
	catch
	interval(1,1)=0.01*1;
	interval(1,2)=100*1;
	end
	[g,p]=bode(num,den,interval(1));grid on
	y(1)=20*log10(g);
	indice=2;
	y_old=y(1);
	i_old=interval(1);
	for i=interval(:,[2:length(interval)-1])
    	y(indice)=20*pend*log10(i)+y_old-20*pend*log10(i_old);
    	pend=pend+vect(indice-1,1);
    	i_old=i;
    	y_old=y(indice);
    	indice=indice+1;
	end
	y(indice)=20*pend*log10(interval(end))+y_old-20*pend*log10(i_old);
	subplot(2,1,1)
	semilogx(interval,y,'r');
	hold on;	
	%plot(interval,y,'go');
	grid on
	%grid on;
	indice=1;
	hold on;
	[AAA,BBB,CCC,DDD]=tf2ss(num,den);
	sys=ss(AAA,BBB,CCC,DDD);
	%bodemag(sys);
	[m1,m2,m3]=bode(num,den,{interval(1,1),interval(1,end)});
	hold on;
	plot(m3,20*log10(m1));grid on
	clear interval;
	%tracciamento fasi
	[ii,jj]=find(vect(:,3)<0)
	vect(ii,1)=-(vect(ii,1));
	for i=1:size(vect,1)
	interval(1,indice)=0.1*vect(i,2);
	interval(2,indice)=vect(i,1);
	indice=indice+1;
	interval(1,indice)=vect(i,2);
	interval(2,indice)=0;
	indice=indice+1;
	interval(1,indice)=10*vect(i,2);
	interval(2,indice)=-vect(i,1);
	indice=indice+1;
	end
	try
	interval=interval';
	interval=sortrows(interval,1);
	interval=interval';
	catch
    	interval(:,1)=[0.01*1;0];
	interval(:,2)=[100*1;0];
	interval=interval';
	interval=sortrows(interval,1);
	interval=interval';
	end
	interval=[[0.1*interval(1,1);0] interval [10*interval(1,end);0]];
	[g,p,w3]=bode(num,den,interval(1));grid on
	pp=p;
	x=round(p/90);	
	p=90*x;
	yf(1)=p;
	indice=2;
	yf_old=yf(1);
	i_old=interval(1,1);
	pend=0;
	for i=interval(1,[2:size(interval,2)-1])
    	yf(indice)=45*pend*log10(i)+yf_old-45*pend*log10(i_old);
    	pend=pend+interval(2,indice);
    	i_old=i;
    	yf_old=yf(indice);
    	indice=indice+1;
	end
	yf(indice)=yf_old;
	subplot(2,1,2)
	semilogx(interval(1,:),yf,'r');
	hold on;
	%plot(interval(1,:),yf,'go');
	%grid on;
	[m1,m2,m3]=bode(num,den,{interval(1,1),interval(1,end)});grid on
	diff=m2(1)-pp;
	m2=m2-diff;
	hold on
	semilogx(m3,m2);grid on
