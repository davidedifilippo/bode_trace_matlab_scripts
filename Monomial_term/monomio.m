 w = 0.01:0.01:10^3;
 GdB = 20*log10(w);
 PH = 360/(2*pi)*angle(w*i);


h = figure(1);
title('Risposta in ampiezza o guadagno');
xlabel('Log10(w)');
ylabel('dB');
hold on;
grid on;

plot(log10(w), GdB, 'b','linewidth',2);

h = figure(2);
title('Risposta di fase');
xlabel('Log10(w)');
ylabel('Fase');
hold on;
grid on;

plot(log10(w), PH, 'r','linewidth',2);


