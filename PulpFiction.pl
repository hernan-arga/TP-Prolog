% Información base 		(parte 2)
% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).		% Hasta aca es todo para la parte 2

pareja(marsellus, mia).
pareja(pumkin, honeyBunny).
pareja(bernardo, bianca).                % Punto 2
pareja(bernardo, charo).

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(Alguien, bernardo):-        % Punto 3
    trabajaPara(marsellus, Alguien),
    Alguien\=jules.
trabajaPara(Alguien, george):-
    pareja(bernardo, Alguien).


saleCon(Persona1, Persona2):-           % Punto 1
    pareja(Persona1, Persona2).
saleCon(Persona1, Persona2):-
    pareja(Persona2, Persona1).

esFiel(Alguien):-                       % Punto 4
    tienePareja(Alguien),
    not(saleConMasde1(Alguien)).

tienePareja(Alguien):-
    pareja(Alguien, _).
tienePareja(Alguien):-
    pareja(_, Alguien).

saleConMasde1(Alguien):-
    pareja(Alguien, Persona1), 
    pareja(Alguien, Persona2), 
    Persona1\=Persona2.

acataOrden(Jefe,Empleado):-						% Punto 5 (Mas acertado :3)
  forall(trabajaPara(Jefe,Alguien),trabajaPara(Alguien,Empleado)).
  
acataOrden(Jefe,Empleado):-
  trabajaPara(Jefe,Empleado),
  Jefe\=Empleado.