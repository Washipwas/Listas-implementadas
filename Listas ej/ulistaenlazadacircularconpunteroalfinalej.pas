unit uListaEnlazadaCircularConPunteroAlFinalej;

interface

uses
  uElementoInt;

TYPE
  TLista=^TNodo;
  TNodo=RECORD
    info:TElemento;
    sig:^TNodo;
  end;

  {Constructoras generedadoras}
  PROCEDURE CrearVacia(VAR l:TLista);
  PROCEDURE Construir(VAR l:TLista;e:TElemento);

  {Observadoras selectoras}
  PROCEDURE Primero (l:TLista;VAR e:TElemento);
  PROCEDURE Resto (VAR l:TLista);

  {Observadoras no selectoras}
  FUNCTION EsVacia(l:TLista):Boolean;
  FUNCTION Longitud(l:TLista):Integer;
  PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
  FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;

  {Constructoras no generadoras}
  PROCEDURE MostrarLista(l:TLista);
  PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista);
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal(VAR l:TLista);
  PROCEDURE Copia(VAR c:TLista;l:TLista);
  PROCEDURE Destruir(VAR l:TLista);


implementation
PROCEDURE CrearVacia(VAR l:TLista);
BEGIN
  l:=NIL;
END;

PROCEDURE Construir(VAR l:TLista;e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  new(aux);
  Asignar(aux^.info,e);
  IF EsVacia(l) THEN
   BEGIN
     l:=aux;
     l^.sig:=l;
   END
  ELSE
  BEGIN
    aux^.sig:=l^.sig;
    l^.sig:=aux;
  END;
END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    Asignar(e,l^.sig^.info);
END;

PROCEDURE Resto (VAR l:TLista);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l^.sig;
     l^.sig:=aux^.sig;
     dispose(aux);
     aux:=NIL;
   END;
END;

FUNCTION EsVacia(l:TLista):Boolean;
BEGIN
  EsVacia:=l = NIL;
END;

FUNCTION Longitud(l:TLista):Integer;
VAR
  contador:Integer;
  aux:^TNodo;
BEGIN
  contador:=0;
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l^.sig;
     WHILE l<>aux DO
       BEGIN
         contador:=contador+1;
         aux:=aux^.sig;
       END;
     contador:=contador+1;
   END;
  Longitud:=contador;
END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
   Asignar(e,l^.info);
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
  aux:^TNodo;
  encontrado:Boolean;
BEGIN
  encontrado:=False;
  IF NOT EsVacia(l) THEN
   BEGIN
     IF EsIgual(e,l^.info) THEN
      encontrado:=True;
     aux:=l^.sig;
     WHILE (NOT encontrado) AND (aux<>l) DO
       BEGIN
         IF EsIgual(e,aux^.info) THEN
          encontrado:=True;
         aux:=aux^.sig;
       END;
   END;
  Pertenece:=encontrado;
END;

PROCEDURE MostrarLista(l:TLista);
VAR
  aux:^TNodo;
  e:TElemento;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
      aux:=l^.sig;
      WHILE (l<>aux) DO
        BEGIN
          Asignar(e,aux^.info);
          writeln(e);
          aux:=aux^.sig;
        END;
      Asignar(e,aux^.info);
      writeln(e);
   END;
END;

PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista);
VAR
  aux:^TNodo;
BEGIN
  CrearVacia(l);
  IF (NOT EsVacia(l1)) AND (NOT EsVacia(l2)) THEN
   BEGIN
     aux:=l1^.sig;
     WHILE (aux<>l1) DO
       BEGIN
         InsertarFinal(l,aux^.info);
         aux:=aux^.sig;
       END;
     InsertarFinal(l,l1^.info);

     aux:=l2^.sig;
     WHILE (aux<>l2) DO
       BEGIN
         InsertarFinal(l,aux^.info);
         aux:=aux^.sig;
       END;
     InsertarFinal(l,l2^.info);
   END;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
  aux,aux2:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l;
     aux2:=l^.sig;;
     WHILE (NOT EsIgual(e,aux2^.info)) AND (aux2<>l) DO
      BEGIN
        aux:=aux2;
        aux2:=aux2^.sig;
      END;
     IF EsIgual(e,aux2^.info) THEN
      BEGIN
        aux^.sig:=aux2^.sig;
        IF EsIgual(e,l^.info) THEN
         l:=aux;
        dispose(aux2);
        aux2:=NIL;
      END;
   END;
END;

PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
      new(aux);
      Asignar(aux^.info,e);
      aux^.sig:=l^.sig;
      l^.sig:=aux;
      l:=aux;
   END
  ElSE
  Construir(l,e);
END;

PROCEDURE BorrarFinal(VAR l:TLista);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l^.sig;
     IF (aux = l) THEN
       BEGIN
         dispose(l);
         l:=NIL;
       END
     ELSE
       BEGIN
         WHILE (aux^.sig<>l) DO
          aux:=aux^.sig;
         aux^.sig:=l^.sig;
         dispose(l);
         l:=NIL;
         l:=aux;
       END;
   END;
END;

PROCEDURE Copia(VAR c:TLista;l:TLista);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l^.sig;
     WHILE (aux<>l) DO
      BEGIN
        InsertarFinal(c,aux^.info);
        aux:=aux^.sig;
      END;
     InsertarFinal(c,l^.info);
   END;
END;

PROCEDURE Destruir(VAR l:TLista);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l^.sig;
     WHILE (l<>aux) DO
      BEGIN
      aux:=aux^.sig;
      Resto(l);
      END;
     BorrarFinal(l);
   END;
END;

END.

