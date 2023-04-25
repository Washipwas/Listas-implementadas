unit uListaEstaticaQueSimulaDinamicaej;


interface

uses
  uElementoIntej;

CONST
  INI = 1;
  FIN = 10;

TYPE
  TNodo=RECORD
    info:TElemento;
    sig:Integer;
  end;

  TLista=RECORD
    datos:Array[INI..FIN] of TNodo;
    ocupados:Integer;
    libres:Integer;
  end;

  {Constructoras Generadoras}
  PROCEDURE CrearVacia (VAR l:TLista);
  PROCEDURE Construir(VAR l:TLista;e:TElemento);

  {Observadoras selectoras}
  PROCEDURE Primero (l:TLista;VAR e:TElemento);
  PROCEDURE Resto (VAR l:TLista);

  {Observadora no selectoras}
  FUNCTION EsVacia(l:TLista):Boolean;
  FUNCTION Longitud (l:TLista):Integer;
  PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
  FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;

  {Contructura no generadora}
  PROCEDURE MostrarLista(l:TLista);
  PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista);
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal(VAR l:TLista);
  PROCEDURE Copia(VAR c:TLista;l:TLista);
  PROCEDURE Destruir(VAR l:TLista);

implementation

PROCEDURE CrearVacia (VAR l:TLista);
VAR
  i:Integer;
BEGIN
  l.ocupados:=INI-1;
  l.libres:=INI;
  FOR i:=INI TO FIN-1 DO
      l.datos[i].sig:=i+1;
  l.datos[FIN].sig:=-1;
END;

PROCEDURE Construir(VAR l:TLista;e:TElemento);
VAR
  aux:Integer;
BEGIN
  IF EsVacia(l) THEN
    BEGIN
      l.libres:=l.datos[l.libres].sig;
      l.ocupados:=INI;
      Asignar(l.datos[l.ocupados].info,e);
      l.datos[l.ocupados].sig:=-1;
    END
  ELSE
    BEGIN
      aux:=l.libres;
      Asignar(l.datos[aux].info,e);
      l.libres:=l.datos[l.libres].sig;
      l.datos[aux].sig:=l.ocupados;
      l.ocupados:=aux;
    END;
END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  Asignar(e,l.datos[l.ocupados].info);
END;

PROCEDURE Resto (VAR l:TLista);
VAR
  aux:Integer;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      aux:=l.ocupados;
      l.ocupados:=l.datos[aux].sig;
      l.datos[aux].sig:=l.libres;
      l.libres:=aux;
    END;
END;

FUNCTION EsVacia(l:TLista):Boolean;
BEGIN
  EsVacia:=l.ocupados = 0;
END;

FUNCTION Longitud (l:TLista):Integer;
VAR
  contador:Integer;
BEGIN
  contador:=0;
  IF NOT EsVacia(l) THEN
    BEGIN
      WHILE l.datos[l.ocupados].sig<>-1 DO
        BEGIN
          l.ocupados:=l.datos[l.ocupados].sig;
          contador:=contador+1;
        END;
      contador:=contador+1;
    END;
  Longitud:=contador;
END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      WHILE l.datos[l.ocupados].sig<>-1 DO
          l.ocupados:=l.datos[l.ocupados].sig;
      Asignar(e,l.datos[l.ocupados].info);
    END;
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
  encontrado:Boolean;
BEGIN
  encontrado:=False;
  IF NOT EsVacia(l) THEN
    BEGIN
      WHILE l.datos[l.ocupados].sig<>-1 DO
        BEGIN
          IF EsIgual(l.datos[l.ocupados].info,e) THEN
            encontrado:=True;
          l.ocupados:=l.datos[l.ocupados].sig;
        END;
      IF EsIgual(l.datos[l.ocupados].info,e) THEN
        encontrado:=True;
    END;
  Pertenece:=encontrado;
END;

{PROCEDURE MostrarLista(l:TLista);
VAR
  e:TElemento;
BEGIN
  WHILE NOT EsVacia(l) DO
    BEGIN
    Asignar(e,l.datos[l.ocupados].info);
    Mostrar(e);
    Resto(l);
    END;
END;}

PROCEDURE MostrarLista(l:TLista);
VAR
  e:TElemento;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      WHILE l.datos[l.ocupados].sig<>-1 DO
        BEGIN
          Asignar(e,l.datos[l.ocupados].info);
          Mostrar(e);
          l.ocupados:=l.datos[l.ocupados].sig;
        END;
      Asignar(e,l.datos[l.ocupados].info);
      Mostrar(e);
    END;
END;

PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista);
BEGIN
  IF NOT EsVacia(l1) AND NOT EsVacia(l2) THEN
    BEGIN
      CrearVacia(l);
      WHILE l1.datos[l1.ocupados].sig<>-1 DO
        BEGIN
          InsertarFinal(l,l1.datos[l1.ocupados].info);
          l1.ocupados:=l1.datos[l1.ocupados].sig;
        END;
      InsertarFinal(l,l1.datos[l1.ocupados].info);
      WHILE l2.datos[l2.ocupados].sig<>-1 DO
        BEGIN
          InsertarFinal(l,l2.datos[l2.ocupados].info);
          l2.ocupados:=l2.datos[l2.ocupados].sig;
        END;
      InsertarFinal(l,l2.datos[l2.ocupados].info);
    END;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
  aux,aux2:Integer;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      IF (EsIgual(e,l.datos[l.ocupados].info)) AND (l.datos[l.ocupados].sig=-1) THEN
        BEGIN
          l.datos[l.ocupados].sig:=l.libres;
          l.libres:=l.ocupados;
          l.ocupados:=0;
        END
      ELSE IF (EsIgual(e,l.datos[l.ocupados].info)) THEN
        BEGIN
          aux:=l.ocupados;
          l.ocupados:=l.datos[aux].sig;
          l.datos[aux].sig:=l.libres;
          l.libres:=aux;
        END
      ELSE
        BEGIN
          aux:=l.ocupados;
          aux2:=l.datos[l.ocupados].sig;
          WHILE (NOT EsIgual(l.datos[aux2].info,e)) AND (l.datos[aux2].sig<>-1) DO
            BEGIN
              aux:=aux2;
              aux2:=l.datos[aux2].sig;
            END;
          IF EsIgual(l.datos[aux2].info,e) THEN
            l.datos[aux].sig:=l.datos[aux2].sig;
        END;
    END;
END;

PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
VAR
  aux,aux2:Integer;
BEGIN
  IF EsVacia(l) THEN
    BEGIN
      l.libres:=l.datos[l.libres].sig;
      l.ocupados:=INI;
      Asignar(l.datos[l.ocupados].info,e);
      l.datos[l.ocupados].sig:=-1;
    END
  ELSE
    BEGIN
      aux:=l.ocupados;
      WHILE l.datos[aux].sig<>-1 DO
          aux:=l.datos[aux].sig;
      aux2:=l.libres;
      Asignar(l.datos[aux2].info,e);
      l.libres:=l.datos[aux2].sig;
      l.datos[aux].sig:=aux2;
      l.datos[aux2].sig:=-1;
    END;
END;

PROCEDURE BorrarFinal(VAR l:TLista);
VAR
  aux,aux2:Integer;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      IF l.datos[l.ocupados].sig=-1 THEN
        BEGIN
          l.datos[l.ocupados].sig:=l.libres;
          l.libres:=l.ocupados;
          l.ocupados:=0;
        END
      ELSE
        BEGIN
          aux:=l.ocupados;
          aux2:=l.datos[aux].sig;
          WHILE l.datos[aux2].sig<>-1 DO
            BEGIN
              aux:=aux2;
              aux2:=l.datos[aux2].sig;
            END;
          l.datos[aux2].sig:=l.libres;
          l.libres:=aux2;
          l.datos[aux].sig:=-1;
        END;
    END;
END;

PROCEDURE Copia(VAR c:TLista;l:TLista);
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      CrearVacia(c);
      WHILE l.datos[l.ocupados].sig<>-1 DO
        BEGIN
          InsertarFinal(c,l.datos[l.ocupados].info);
          l.ocupados:=l.datos[l.ocupados].sig;
        END;
      InsertarFinal(c,l.datos[l.ocupados].info);
    END;
END;

PROCEDURE Destruir(VAR l:TLista);
BEGIN
  WHILE NOT EsVacia(l) DO
    Resto(l);
END;

end.

