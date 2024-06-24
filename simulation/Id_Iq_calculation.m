
Rs = 0,036;
Ld = 473e-6;
Lq = 1155e-6;
Fpm = 0.1383;
Iq = zeros (1,27000);
Id = zeros (1,27000);
Iphase = zeros (1,27000);
Vphase = zeros (1,27000);
Torque = 280;
We = 2142.85;

for i = 10000:28000;
    
    Iq(i) = i/100;
    Id(i) = (Torque*2/3/4-Fpm*Iq(i))/(-Lq+Ld)/Iq(i);
    Iphase(i) = sqrt(Iq(i)^2+Id(i)^2);
    Vphase(i) = sqrt((Rs*Iq(i)+We*Fpm+Ld*Id(i)*We)^2+(-We*Iq(i)*Lq+Rs*Id(i))^2)*sqrt(3);
end

plot(Iphase);
hold on;
plot(Vphase);
grid on;