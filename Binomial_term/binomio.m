
w = 0.01:0.01:10^3;
tau = 0.01;


G = abs(1+w*tau*i);

GdB = 20*log10(G);
PH = 360/(2*pi)*angle(1+w*tau*i);

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
