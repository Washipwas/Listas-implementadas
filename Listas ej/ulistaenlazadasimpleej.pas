unit uListaEnlazadaSimpleEj;


interface

uses
  uElementoInt;

TYPE
  TLista = ^TNodo;
  TNodo = RECORD
    info:TElemento;
    sig:^TNodo;
  END;

  PROCEDURE CrearVacia(VAR l:TLista);

  PROCEDURE Construir (VAR l:TLista;e:TElemento);
  PROCEDURE Primero (l:TLista;VAR e:TElemento);
  PROCEDURE Resto (VAR l:TLista);

  FUNCTION EsVacia(l:TLista):Boolean;
  FUNCTION Longitud (l:TLista):Integer;
  PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
  FUNCTION Pertenece (l:TLista;e:Telemento):Boolean;

  PROCEDURE MostrarLista (l:TLista;e:Telemento);

  PROCEDURE Concatenar (VAR l:TLista;l1,l2:TLista);
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal (VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal(VAR l:TLista);
  PROCEDURE Copia(VAR c:TLista;l:TLista);
  PROCEDURE Destruir (VAR l:TLista);


implementation

PROCEDURE CrearVacia (VAR l:TLista);
BEGIN
  l:=NIL;
END;

PROCEDURE Construir (VAR l:TLista;e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  new(aux);
  Asignar(aux^.info,e);
  aux^.sig:=l;
  l:=aux;
END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    Asignar(e,l^.info);
END;

PROCEDURE Resto (VAR l:TLista);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
    aux:=l;
    l:=l^.sig;
    dispose(aux);
    aux:=NIL;
   END;
END;

FUNCTION EsVacia(l:TLista):Boolean;
BEGIN
  EsVacia:= l = NIL;
END;

FUNCTION Longitud (l:TLista):Integer;
VAR
  cont:Integer;
  aux:^TNodo;
BEGIN
  cont:=0;
  aux:=l;
  WHILE NOT EsVacia(aux) DO
    BEGIN
      cont:=cont+1;
      aux:=aux^.sig;
    END;
  Longitud:=cont;
END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
    aux:=l;
    WHILE NOT EsVacia(aux^.sig) DO
      aux:=aux^.sig;
    Asignar(e,aux^.info);
   END;
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
  aux:^TNodo;
  encontrado:Boolean;
BEGIN
  encontrado:=False;
  IF NOT EsVacia(l) THEN
   BEGIN
    aux:=l;
    WHILE (NOT EsVacia(aux)) AND (NOT EsIgual(e,aux^.info)) DO
      aux:=aux^.sig;
    IF NOT EsVacia(aux) THEN
     encontrado:=True;
   END;
  Pertenece:=encontrado;
END;

PROCEDURE MostrarLista (l:TLista;e:Telemento);
VAR
  aux:^TNodo;
BEGIN
  aux:=l;
  WHILE NOT EsVacia(aux) DO
   BEGIN
     Asignar(e,aux^.info);
     Mostrar(e);
     aux:=aux^.sig;
   END;
END;

PROCEDURE Concatenar (VAR l:TLista;l1,l2:TLista);
BEGIN
  WHILE NOT EsVacia(l1) DO
   BEGIN
     InsertarFinal(l,l1^.info);
     l1:=l1^.sig;
   END;
  WHILE NOT EsVacia(l2) DO
   BEGIN
     InsertarFinal(l,l2^.info);
     l2:=l2^.sig;
   END;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
  aux,aux2:^TNodo;
  encontrado:Boolean;
BEGIN
  encontrado:=False;
  aux:=l;
  aux2:=aux^.sig;
  WHILE (NOT EsVacia(aux2)) AND (NOT encontrado) DO
    BEGIN
      IF EsIgual(aux2^.info,e) THEN
         encontrado:=True;
      aux:=aux2;
      aux2:=aux2^.sig;
    END;
  IF encontrado THEN
   BEGIN
    aux^.sig:=aux2^.sig;
    dispose(aux2);
    aux2:=NIL;
   END;
END;

PROCEDURE InsertarFinal (VAR l:TLista;e:TElemento);
VAR
  aux,aux2:^TNodo;
BEGIN
  new(aux2);
  Asignar(aux2^.info,e);
  aux2^.sig:=NIL;
  aux:=l;
  IF EsVacia(l) THEN
    l:=aux2
  ELSE
   BEGIN
     WHILE NOT EsVacia(aux^.sig) DO
       aux:=aux^.sig;
     aux^.sig:=aux2;
   END;
END;

PROCEDURE BorrarFinal(VAR l:TLista);
VAR
  aux,aux2:^TNodo;
BEGIN
  aux:=l;
  aux2:=aux^.sig;
  WHILE NOT EsVacia(aux2^.sig) DO
    BEGIN
      aux:=aux2;
      aux2:=aux2^.sig;
    END;
  aux^.sig:=NIL;
  dispose(aux2);
  aux2:=NIL;
END;

PROCEDURE Copia(VAR c:TLista;l:TLista);
VAR
  aux:^TNodo;
BEGIN
  aux:=l;
  WHILE NOT EsVacia(aux) DO
    BEGIN
      InsertarFinal(c,aux^.info);
      aux:=aux^.sig;
    END;
END;

PROCEDURE Destruir (VAR l:TLista);
BEGIN
  WHILE NOT EsVacia(l) DO
    Resto(l);
END;

end.

