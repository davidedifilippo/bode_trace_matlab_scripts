w = 0.01:0.01:10^3;
wn = 10;
z = 0.3;

RE_TRINOMIO = 1-(w./wn).^2;
IM_TRINOMIO = 2*z*(w./wn);


TRINOMIO = RE_TRINOMIO+IM_TRINOMIO*i;

GdB = 20*log10(abs(TRINOMIO));
PH = 360/(2*pi)*angle(TRINOMIO);

h = figure(1);


title('Risposta in ampiezza o guadagno');

xlabel('Log10(w)');
ylabel('dB');
hold on;
grid on;

plot(log10(w), -GdB, 'r','linewidth',2);

h = figure(2);


title('Risposta di fase');

xlabel('Log10(w)');
ylabel('Fase');
hold on;
grid on;

plot(log10(w), -PH, 'b','linewidth',2);