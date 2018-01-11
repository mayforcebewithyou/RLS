N=input('length of sequence N = ');
t=[0:N-1];
M=400;
s=decimate(s,10);
noi=decimate(noi,10);
s=s./max(s);
noi=noi./max(noi);
w=zeros(M,1); 
a=zeros(M,1);
lambda=0.98;
delta=0.9988;
p=(power(delta,-1))*eye(M,M);
for i=1:N
  for k=M:-1:2
 a(k)=a(k-1);
  end;
  a(1)=noi(i)
  pi=p*a;
  k=pi./(lambda+a'*pi);
  e(i) = s(i) -w'*a;  
 w = w + k*e(i);
 p=power(lambda,-1)*p-power(lambda,-1)*(k'*a)'*p;
   end;
subplot(221),plot(t,s),ylabel('input Signal+Noise'),
subplot(222),plot(t,noi),ylabel('noise signal')
subplot(223),plot(t,e),ylabel('Error-desired output');

z=buffer(s,2000,1600);
y=buffer(e,2000,1600);
for i=1:312
    j(i) = var(z(:,i));
    l(i) = var(y(:,i));
end
k=mean(j);
o=mean(l);
NF=10*log10(k/o);