p_f = 0:0.1:100;%press�o no freio
v_car = 0:0.1:100;%velocidade do carro
v_r = 0:0.1:100;%velocidade da roda
%tomar um n�mero aleat�rio dos vetores x e y
p_f1 = p_f(randi(numel(p_f)))%valor aleat�rio - press�o no freio
v1_car = v_car(randi(numel(v_car)))%valor - aleat�rio velocidade do carro
v1_r = v_r(randi(numel(v_r)))%valor aleat�rio - velocidade da roda

%Infer�ncia Nebulosa de acordo com os slides

%valores alto, m�dio e baixo para a press�o no freio

%alto
if(p_f1 >= 50)
    pfalto = (p_f1/50)-1;
else
    pfalto = 0;
end

%m�dio
if(p_f1 >= 30 && p_f1 <= 50)
    pfmedio = (p_f1/30)-1;
else(p_f1 >= 50 && p_f1 <= 70)
    pfmedio = (((p_f-30)/20)-1);
end

if(p_f1 >= 70)
    pfmedio=0;
end

%baixo
if(p_f1 <= 50)
    pfbaixo = (p_f1/50);
else
    pfbaixo=0;
end

%valores devagar, m�dio e r�pido para a velocidade da roda

%devagar
if(v1_r >= 0 && v1_r <= 60)
    vrs = ((-v1_r)/60)+1;
else
    vrs = 0;
end

%m�dio
if(v1_r >= 20 && v1_r <=80)
    vrm = (v1_r/30)-1;
else
    vrm = 0;
end

%r�pido
if(v1_r >= 40)
    vrr = (v1_r-40)/60;
else
    vrr = 0;
end

%valores devagar, m�dio e r�pido para a velocidade do carro

%devagar
if(v1_car >= 0 && v1_car <= 60)
    vcard = 0;
end

%m�dio
if(v1_car >= 20 && v1_car <=80)
    vcarm = 0;
end

%r�pido
if(v1_car >= 40)
    vcarf = (v1_car - 40)/60;
end

%regras - infer�ncia neulosa

%apertar freio - regra 1 e 2
r2 = [pfalto, vcarf, vrr];
inferencia_1 = pfmedio + min(r2);

%soltar freio - regra 3 e 4
r3 = [pfalto, vcarf, vrr];
inferencia_2 = pfbaixo + min(r3);

num = 0;
den = 0;
passo = 5;
while(passo <= 100)
    info = passo/100;
    if(info < inferencia_2)
        num = num +(passo*inferencia_2);
        den = den + inferencia_2;
    elseif(info > inferencia_1)
        num = num +(passo*inferencia_1);
        den = den + inferencia_1;
    else
        num = num + (passo*info);
        den = den + info;
    end
    passo = passo + 5;
end

%c�lculo centr�ide
centroide = num/den;
centroide      