unit uListaEstaticaCircularej;


interface

uses
  uElementoIntej;

CONST
  INI = 1;
  FIN = 10;

TYPE
  TLista=RECORD
  info:ARRAY [INI..FIN] of Integer;
  tope:Integer;
  i:Integer;
  f:Integer;
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
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal(VAR l:TLista);
  PROCEDURE Copia(VAR c:TLista;l:TLista);
  PROCEDURE Destruir(VAR l:TLista);

implementation

PROCEDURE CrearVacia (VAR l:TLista);
BEGIN
  l.tope:=0;
  l.i:=INI-1;
  l.f:=INI-1;
END;

PROCEDURE Construir(VAR l:TLista;e:TElemento);
BEGIN
  l.i:=(l.i mod FIN) +1;
  l.tope:=l.tope+1;
  Asignar(l.info[l.i],e);
  IF l.tope=1 THEN
  l.f:=l.i;
END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  IF NOT EsVacia(l) THEN
    Asignar(e,l.info[l.i]);
END;

PROCEDURE Resto (VAR l:TLista);
BEGIN
 IF NOT EsVacia(l) THEN
   BEGIN
     l.i:=l.i-1;
     l.tope:=l.tope-1;
     IF l.i<INI THEN
       l.i:=FIN;
   END;
END;

FUNCTION EsVacia(l:TLista):Boolean;
BEGIN
 EsVacia:= l.tope = 0;
END;

FUNCTION Longitud (l:TLista):Integer;
BEGIN
 Longitud:=l.tope;
END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
BEGIN
 IF NOT EsVacia(l) THEN
   Asignar(e,l.f);
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
  encontrado:Boolean;
BEGIN
 encontrado:=False;
 IF NOT EsVacia(l) THEN
   BEGIN
     IF EsIgual(l.info[l.f],e) THEN
       encontrado:=True;
     WHILE (l.i<>l.f) AND (NOT encontrado)DO
       BEGIN
         IF EsIgual(l.info[l.i],e) THEN
           encontrado:=True;
         l.i:=l.i-1;
         IF l.i<INI THEN
           l.i:=FIN;
       END;
     END;
 Pertenece:=encontrado;
END;

PROCEDURE MostrarLista(l:TLista);
VAR
  e:TElemento;
  i:Integer;
BEGIN
 IF NOT EsVacia(l) THEN
   BEGIN
     FOR i:=INI TO l.tope DO
       BEGIN
         Asignar(e,l.info[l.i]);
         Mostrar(e);
         l.i:=l.i-1;
         IF l.i<INI THEN
           l.i:=FIN;
       END;
   END;
END;

PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista);
VAR
  i:Integer;
BEGIN
 CrearVacia(l);
 IF (NOT EsVacia(l1)) AND (NOT EsVacia(l2)) THEN
   BEGIN
     FOR i:=INI TO l1.tope DO
       BEGIN
         InsertarFinal(l,l1.info[l1.i]);
         l1.i:=l1.i-1;
         IF l1.i<INI THEN
           l1.i:=FIN
       END;
     FOR i:=INI TO l2.tope DO
       BEGIN
         InsertarFinal(l,l2.info[l2.i]);
         l2.i:=l2.i-1;
         IF l2.i<INI THEN
           l2.i:=FIN
       END;
   END;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
  aux,aux2:Integer;
BEGIN
 IF NOT EsVacia(l) THEN
   BEGIN
     aux:=l.i;
     IF EsIgual(l.info[l.f],e) THEN
       BEGIN
         l.tope:=l.tope-1;
       END
     ELSE
       BEGIN
         WHILE (aux<>l.f) AND (NOT EsIgual(l.info[aux],e)) DO
           BEGIN
             aux:=aux-1;
             IF aux<INI THEN
               aux:=FIN;
           END;
         IF EsIgual(l.info[aux],e) THEN
           BEGIN
             l.tope:=l.tope-1;
             WHILE aux<>l.f DO
               BEGIN
                 aux2:=aux-1;
                 IF aux2<INI THEN
                   aux2:=FIN;
                 Asignar(l.info[aux],l.info[aux2]);
                 aux:=aux-1;
                 aux2:=aux2-1;
                 IF aux2<INI THEN
                   aux2:=FIN;
                 IF aux<INI THEN
                   aux:=FIN;
               END;
           END;
       END;
   END;
END;

PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
BEGIN
     l.tope:=l.tope+1;
     l.f:=l.f-1;
     IF l.f<INI THEN
       l.f:=FIN;
     Asignar(l.info[l.f],e);
     IF l.tope=1 THEN
       l.i:=l.f;
END;

PROCEDURE BorrarFinal(VAR l:TLista);
BEGIN
 IF NOT EsVacia(l) THEN
   BEGIN
     l.tope:=l.tope-1;
     l.f:=l.f+1;
     IF l.f>FIN THEN
       l.f:=INI;
   END;
END;

PROCEDURE Copia(VAR c:TLista;l:TLista);
VAR
  i:Integer;
BEGIN
 CrearVacia(c);
 IF NOT EsVacia(l) THEN
   BEGIN
     WHILE l.i<>l.f DO
       BEGIN
         InsertarFinal(c,l.info[l.i]);
         l.i:=l.i-1;
         IF l.i<INI THEN
           l.i:=FIN;
       END;
     InsertarFinal(c,l.info[l.f]);
   END;
END;
PROCEDURE Destruir(VAR l:TLista);
BEGIN
 IF NOT EsVacia(l) THEN
   BEGIN
     WHILE l.i<>l.f DO
       Resto(l);
     Resto(l);
   END;
END;

end.

