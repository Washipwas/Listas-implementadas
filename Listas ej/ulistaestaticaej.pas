unit uListaEstaticaEj;


interface

uses
  uElementoInt;

CONST
  INI=1;
  FIN=10;

TYPE
  TLista=RECORD
    info:ARRAY[INI..FIN] OF TElemento;
    tope:integer;
  END;

  PROCEDURE CrearVacia(VAR l:TLista);

  PROCEDURE Construir(VAR l:TLista;e:TElemento);
  PROCEDURE Primero (l:TLista;VAR e:TElemento);
  PROCEDURE Resto (VAR l:TLista);

  FUNCTION EsVacia(l:TLista):Boolean;
  FUNCTION Longitud (l:TLista):Integer;
  PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
  FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;

  PROCEDURE MostrarLista(l:TLista);

  PROCEDURE Concatenar (VAR l:TLista;l1,l2:TLista);
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal (VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal (VAR l:TLista);
  PROCEDURE Copia (VAR c:TLista;l:TLista);
  PROCEDURE Destruir (VAR l:TLista);

implementation
PROCEDURE CrearVacia(VAR l:TLista);
  BEGIN
    l.tope:=INI-1;
  END;

PROCEDURE Construir (VAR l:TLista;e:TElemento);
  BEGIN
    l.tope:=l.tope+1;
    Asignar(l.info[l.tope],e);
  END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    Asignar(e,l.info[l.tope]);
END;

PROCEDURE Resto (VAR l:TLista);
BEGIN
  IF NOT EsVacia(l) THEN
    l.tope:=l.tope-1;
END;

FUNCTION EsVacia(l:TLista):Boolean;
BEGIN
  EsVacia:= l.tope < INI;
END;

FUNCTION Longitud (l:TLista):Integer;
BEGIN
  Longitud:=l.tope;
END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
BEGIN
  Asignar(e,l.info[INI]);
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
 encontrado:Boolean;
 i:Integer;
BEGIN
  encontrado:=False;
  i:=INI;
  WHILE i<=l.tope DO
   BEGIN
     IF EsIgual(l.info[i],e) THEN
       encontrado:=True;
     i:=i+1;
   END;
  Pertenece:=encontrado;
END;

PROCEDURE MostrarLista(l:TLista);
VAR
 e:TElemento;
 i:integer;
BEGIN
  i:=l.tope;
  WHILE i>=INI DO
   BEGIN
     Asignar(e,l.info[i]);
     Mostrar(e);
     i:=i-1;
   END;
END;

PROCEDURE Concatenar (VAR l:TLista;l1,l2:TLista);
VAR
 i:Integer;
BEGIN
  i:=INI;
  WHILE i<=l1.tope DO
   BEGIN
    Construir(l,l1.info[i]);
    i:=i+1;
   END;
  i:=INI;
  WHILE i<=l2.tope DO
   BEGIN
    Construir(l,l2.info[i]);
    i:=i+1;
   END;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
 encontrado:Boolean;
 i:Integer;
BEGIN
  i:=INI;
  encontrado:=False;
  WHILE (i<=l.tope) AND (NOT encontrado) DO
   BEGIN
    IF EsIgual(l.info[i],e) THEN
      encontrado:=True;
    i:=i+1;
   END;
  IF encontrado THEN
    BEGIN
      i:=i-1;
      WHILE i<=l.tope DO
       BEGIN
        Asignar(l.info[i],l.info[i+1]);
        i:=i+1;
       END;
      l.tope:=l.tope-1;
    END;
END;

PROCEDURE InsertarFinal (VAR l:TLista;e:TElemento);
VAR
 i:Integer;
BEGIN
  i:=l.tope;
  l.tope:=l.tope+1;
  WHILE i>=INI DO
   BEGIN
    Asignar(l.info[i+1],l.info[i]);
    i:=i-1;
   END;
  Asignar(l.info[INI],e);
END;

PROCEDURE BorrarFinal (VAR l:TLista);
VAR
 i:Integer;
BEGIN
  i:=INI;
  l.tope:=l.tope-1;
  WHILE i<=l.tope DO
   BEGIN
    Asignar(l.info[i],l.info[i+1]);
    i:=i+1;
   END;
END;

PROCEDURE Copia (VAR c:TLista;l:TLista);
VAR
 i:Integer;
BEGIN
  i:=INI;
  WHILE i<=l.tope DO
   BEGIN
    Asignar(c.info[i],l.info[i]);
    i:=i+1;
   END;
  c.tope:=l.tope;
END;

PROCEDURE Destruir (VAR l:TLista);
BEGIN
  WHILE NOT EsVacia(l) DO
   Resto(l);
END;

end.

