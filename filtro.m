close all;
clear all;
data=csvread("dados_voo_anita.csv");
pkg load signal;
pkg load control;

%filter design
fc = 1.2; %%cut-off frequency [Hz]
fs=1000./mean(diff(data(:,1)));
n=60;
Wn=fc/fs;
f=fir1(n,Wn);

t=(1:length(data(:,2)));%./fs;
%Space
s=filter(f,1,data(:,2));
s2=filter(f,1,s);
figure(1);
hold on;plot(t,.1.*[ones(n,1)*data(1,2);data(1:length(data(:,2))-n,2)]); plot(t,.1.*s2); grid;

%Velocity
v1=diff(s2)*fs;


plot(t(2:length(t)),v1);grid;
%aceleration
a1=diff(v1)*fs;

plot(t(3:length(t)),a1); grid; 
legend("Altura(dam)","Altura filtrada(dam)","Velocidade(m/s)","Aceleracao(m/s^2)");
