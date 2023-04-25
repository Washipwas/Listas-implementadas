unit uListaDoblementeEnlazadaej;

interface

uses
  uElementoInt;

TYPE
  TLista=^TNodo;
  TNodo=RECORD
    info:TElemento;
    ant:^TNodo;
    sig:^TNodo;
  END;

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
  PROCEDURE Concatenar2(VAR l:TLista;l1,l2:TLista);   //Mas sencillo
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal(VAR l:TLista);
  PROCEDURE Copia(VAR c:TLista;l:TLista);
  PROCEDURE Destruir(VAR l:TLista);

implementation
PROCEDURE CrearVacia (VAR l:TLista);
BEGIN
  l:=NIL;
END;

PROCEDURE Construir(VAR l:TLista;e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  new(aux);
  Asignar(aux^.info,e);
  IF NOT EsVacia(l) THEN
    l^.ant:=aux;
  aux^.sig:=l;
  aux^.ant:=NIL;
  l:=aux;
END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    Asignar(e,l^.info)
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
  contador:Integer;
BEGIN
  contador:=0;
  WHILE NOT EsVacia(l) DO
     BEGIN
     contador:=contador+1;
     l:=l^.sig;
     END;
  Longitud:=contador;

END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
    WHILE NOT Esvacia(l^.sig) DO
      l:=l^.sig;
    Asignar(e,l^.info);
    END;
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
  encontrado:Boolean;
BEGIN
  encontrado:=False;
  IF NOT EsVacia(l) THEN
    WHILE (NOT EsVacia(l)) AND (NOT encontrado) DO
      BEGIN
        IF EsIgual(l^.info,e) THEN
          encontrado:=TRUE;
        l:=l^.sig;
      END;
  Pertenece:=encontrado;
END;

PROCEDURE MostrarLista(l:TLista);
VAR
  e:TElemento;
BEGIN
  WHILE NOT Esvacia(l) DO
    BEGIN
    Asignar(e,l^.info);
    Mostrar(e);
    l:=l^.sig;
    END;
END;

PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista);
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

PROCEDURE Concatenar2(VAR l:TLista;l1,l2:TLista);
BEGIN
  IF NOT EsVacia(l1) AND NOT EsVacia(l2) THEN
    BEGIN
    l:=l2;
    WHILE NOT EsVacia(l2^.sig) DO
      l2:=l2^.sig;
    l2^.sig:=l1;
    l1^.ant:=l2;
    END;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
  aux,aux2,aux3:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l;
     aux2:=l^.sig;
     IF EsIgual(aux^.info,e) THEN
      Resto(l)
     ELSE
        BEGIN
          WHILE (NOT EsVacia(aux2)) AND (NOT EsIgual(aux2^.info,e)) DO
            BEGIN
            aux:=aux2;
            aux2:=aux2^.sig;
            END;
          IF EsIgual(aux2^.info,e) THEN
            BEGIN
            aux^.sig:=aux2^.sig;
            aux3:=aux2^.sig;
            aux3^.ant:=aux;
            dispose(aux2);
            aux2:=NIL;
            END;
        END;
   END;
END;

PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
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
      aux2^.ant:=aux;
      END;
END;

PROCEDURE BorrarFinal(VAR l:TLista);
VAR
  aux,aux2:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
   aux:=l;
   aux2:=l^.sig;
   WHILE NOT EsVacia(aux2) DO
     BEGIN
       aux:=aux2;
       aux2:=aux2^.sig;
     END;
   aux2:=aux^.ant;
   aux2^.sig:=NIL;
   dispose(aux);
   aux:=NIL
   END;
END;

PROCEDURE Copia(VAR c:TLista;l:TLista);
BEGIN
  CrearVacia(c);
  WHILE NOT EsVacia(l) DO
    BEGIN
      InsertarFinal(c,l^.info);
      l:=l^.sig;
    END;
END;

PROCEDURE Destruir(VAR l:TLista);
BEGIN
  WHILE NOT EsVacia(l) DO
    Resto(l);
END;

end.

