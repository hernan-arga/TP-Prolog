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
pareja(bernardo, bianca).                % Punto 2 (parte 1)
pareja(bernardo, charo).

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(Alguien, bernardo):-        % Punto 3 (parte 1)
    trabajaPara(marsellus, Alguien),
    Alguien\=jules.
trabajaPara(Alguien, george):-
    pareja(bernardo, Alguien).


saleCon(Persona1, Persona2):-           % Punto 1 (parte 1)
    pareja(Persona1, Persona2).
saleCon(Persona1, Persona2):-
    pareja(Persona2, Persona1).

esFiel(Alguien):-                       % Punto 4 (parte 1)
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

acataOrden(Jefe,Empleado):-						% Punto 5 (parte 1)
  trabajaPara(Alguien, Empleado),
  acataOrden(Jefe, Alguien).
  
acataOrden(Jefe,Empleado):-
  trabajaPara(Jefe,Empleado),
  Jefe\=Empleado.

esPeligroso(Alguien):-                         % Punto 1 (parte 2)
    realizaActividadPeligrosa(Alguien).
esPeligroso(Alguien):-
    tieneJefePeligroso(Alguien).


% Punto 2 (parte 2)



tieneJefePeligroso(Alguien):-
    acataOrden(Jefe, Alguien),
    esPeligroso(Jefe).

realizaActividadPeligrosa(Alguien):-
    personaje(Alguien, mafioso(maton)).

realizaActividadPeligrosa(Alguien):-
    personaje(Alguien, ladron(Lugares)),
    member(licorerias, Lugares).

nivelRespeto(Alguien, Nivel):-                % Punto 3 (parte 2)
    personaje(Alguien, actriz(Peliculas)),
    length(Peliculas, Cantidad),
    Nivel is Cantidad/10.
nivelRespeto(Alguien, 10):-
    personaje(Alguien, mafioso(resuelveProblemas)).
nivelRespeto(Alguien, 20):-
    personaje(Alguien, mafioso(capo)).
nivelRespeto(vincent, 15).

respetabilidad(Respetables, NoRespetables):- % Punto 4 (parte 2)
    findall(Personaje, (nivelRespeto(Personaje, Nivel), Nivel>9), PersonajesRespetables),
    findall(Personaje, (personaje(Personaje, _), not(member(Personaje, PersonajesRespetables))), PersonajesNoRespetables),
    length(PersonajesRespetables, Respetables),
    length(PersonajesNoRespetables, NoRespetables).

cantidadEncargos(Alguien, Cantidad):-        % Punto 5 (parte 2)
    personaje(Alguien, _),
    findall(Tarea, encargo(_, Alguien, Tarea), Tareas),
    length(Tareas, Cantidad).

masAtareado(Alguien):-
    cantidadEncargos(Alguien, Cantidad),
    forall((personaje(Alguien2, _), Alguien\=Alguien2), (cantidadEncargos(Alguien2, Cantidad2), Cantidad2<Cantidad)).