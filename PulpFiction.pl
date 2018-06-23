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

acataOrden(Jefe, Empleado):-       % Punto 5
    trabajaPara(Jefe, Empleado).

acataOrden(Jefe, Empleado):-
    acataOrden(Jefe, Empleado).