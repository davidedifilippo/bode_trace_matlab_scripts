## Diagramma di Bode per il termine binomio 

### Frquenze di interesse

Supponiamo di voler osservare il comportamento del sistema nell'intervallo 0.1 radianti/s e 10000 radianti al secondo:

    w = 0.1:0.01:10^4;

La precedente comando crea un vettore di numeri che vanno da 0.1 a 10000 con passi da 0.01 radianti/s

### Costante di tempo

Supponiamo che la costante di tempo sia di 0.01 secondi:

    tau = 0.01;

### Risposta in frequenza del sistema binomio

Possiamo ora calcolare i valori assunti dalla risposta in frequenza per i diversi valori di w:

    G = 1+w*tau*i;

G è un vettore di 100.000 numeri complessi uno per ogni pulsazione w. Calcolo il modulo e il modulo in decibel

    G = abs(1+w*tau*i);

    GdB = 20*log10(G);

La risposta di fase si calcola semplicemente calcolando la fase di G:

    PH = 360/(2*pi)*angle(1+w*tau*i);

dove:

    angle(1+w*tau*i);

restituirebbe gli angoli in radianti. Anche PH è un vettore di 100.000 valori di angolo in gradi per i vari valori di w

### Diagramma di Bode del modulo 

![This is an image](./binomial_term/binomio_ampiezza_db.png)

Si creano una finestra con titolo ed etichette per i due assi:

    h = figure(1);

    title('Risposta in ampiezza o guadagno');
    xlabel('Log10(w)');
    ylabel('dB');
    hold on;
    grid on;


Il seguente comando traccia il grafico della risposta in ampiezza:

    plot(log10(w), -GdB, 'b','linewidth',2);

Il segno -GdB si deve aggiungere se si suppone che il termine sia al denominatore.

### Diagramma di Bode della fase

![This is an image](./binomio/Binomial_term.png)

    h = figure(2);
    title('Risposta di fase');
    xlabel('Log10(w)');
    ylabel('Fase');
    hold on;
    grid on;

    plot(log10(w), -PH, 'r','linewidth',2);

Il segno -PH si deve aggiungere se si suppone che il termine sia al denominatore.
