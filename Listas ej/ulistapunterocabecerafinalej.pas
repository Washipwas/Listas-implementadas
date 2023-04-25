unit uListaPunteroCabeceraFinalej;

interface

uses uElementoIntej;

TYPE
  TLista=RECORD
    primero:^TNodo;
    ultimo:^TNodo;
  end;

  TNodo=RECORD
    info:TElemento;
    sig:^TNodo;
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
  PROCEDURE Concatenar2(VAR l:TLista;l1,l2:TLista);   //Mas sencillo
  PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
  PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
  PROCEDURE BorrarFinal(VAR l:TLista);
  PROCEDURE Copia(VAR c:TLista;l:TLista);
  PROCEDURE Destruir(VAR l:TLista);

implementation
PROCEDURE CrearVacia (VAR l:TLista);
BEGIN
  l.primero:=NIL;
  l.ultimo:=NIL;
END;

PROCEDURE Construir(VAR l:TLista;e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  new(aux);
  Asignar(aux^.info,e);
  IF EsVacia(l) THEN
    BEGIN
      l.primero:=aux;
      l.ultimo:=aux;
      aux^.sig:=NIL;
    END
  ELSE
   BEGIN
     aux^.sig:=l.primero;
     l.primero:=aux;
   END;
END;

PROCEDURE Primero (l:TLista;VAR e:TElemento);
BEGIN
  Asignar(e,l.primero^.info);
END;

PROCEDURE Resto (VAR l:TLista);
VAR
  aux:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      aux:=l.primero;
      l.primero:=l.primero^.sig;
      dispose(aux);
      aux:=NIL;
    END;
END;

FUNCTION EsVacia(l:TLista):Boolean;
BEGIN
  EsVacia:= l.primero = NIL;
END;

FUNCTION Longitud (l:TLista):Integer;
VAR
  contador:Integer;
BEGIN
  contador:=0;
  IF NOT EsVacia(l) THEN
    BEGIN
      WHILE l.primero<>NIL DO
         BEGIN
         contador:=contador+1;
         l.primero:=l.primero^.sig;
         END;
    END;
  Longitud:=contador;
END;

PROCEDURE Ultimo (l:TLista;VAR e:TElemento);
BEGIN
  Asignar(e,l.ultimo^.info);
END;

FUNCTION Pertenece (l:TLista;e:TElemento):Boolean;
VAR
  encontrado:Boolean;
BEGIN
  encontrado:=False;
  IF NOT EsVacia(l) THEN
    BEGIN
      WHILE (l.primero<>NIL) AND (NOT encontrado) DO
        BEGIN
          IF EsIgual(l.primero^.info,e) THEN
            encontrado:=True;
          l.primero:=l.primero^.sig;
        END;
    END;
  Pertenece:=encontrado;
END;

PROCEDURE MostrarLista(l:TLista);
VAR
  e:TElemento;
BEGIN
  WHILE l.primero<>NIL DO
    BEGIN
      Asignar(e,l.primero^.info);
      Mostrar(e);
      l.primero:=l.primero^.sig;
    END;
END;

PROCEDURE Concatenar(VAR l:TLista;l1,l2:TLista); //Más largo, pero conservas ambas listas
BEGIN
  CrearVacia(l);
  WHILE l1.primero<>NIL DO
    BEGIN
    InsertarFinal(l,l1.primero^.info);
    l1.primero:=l1.primero^.sig;
    END;
  WHILE l2.primero<>NIL DO
    BEGIN
    InsertarFinal(l,l2.primero^.info);
    l2.primero:=l2.primero^.sig;
    END;
END;

PROCEDURE Concatenar2(VAR l:TLista;l1,l2:TLista);//Mas sencillo, pero pierdes las listas(ya que la nueva utiliza los mismos punteros)
BEGIN
  l1.ultimo^.sig:=l2.primero;
  l.primero:=l1.primero;
  l.ultimo:=l2.ultimo;
END;

PROCEDURE BorrarElemento(VAR l:TLista;e:TElemento);
VAR
  aux,aux2:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      aux:=l.primero;
      aux2:=l.primero^.sig;
      IF EsIgual(l.primero^.info,e) THEN
        BEGIN
          l.primero:=aux2;
          dispose(aux);
          aux:=NIL;
        END
      ELSE
        BEGIN
          WHILE (NOT EsIgual(aux2^.info,e)) AND (aux2<>NIL) DO
            BEGIN
            aux:=aux2;
            aux2:=aux2^.sig;
            END;
          IF EsIgual(aux2^.info,e) THEN
            BEGIN
              aux^.sig:=aux2^.sig;
              IF aux2=l.ultimo THEN
                l.ultimo:=aux;
              dispose(aux2);
              aux2:=NIL;
            END;
        END;
    END;
END;

PROCEDURE InsertarFinal(VAR l:TLista;e:TElemento);
VAR
  aux:^TNodo;
BEGIN
  new(aux);
  Asignar(aux^.info,e);
  aux^.sig:=NIL;
  IF EsVacia(l) THEN
    BEGIN
      l.primero:=aux;
      l.ultimo:=aux;
    END
  ELSE
    BEGIN
      l.ultimo^.sig:=aux;
      l.ultimo:=aux;
    END;
END;

PROCEDURE BorrarFinal(VAR l:TLista);
VAR
  aux,aux2:^TNodo;
BEGIN
  IF NOT EsVacia(l) THEN
    BEGIN
      aux:=l.primero;
      aux2:=l.primero^.sig;
      WHILE (aux2^.sig<>NIL) AND (aux2<>NIL) DO
        BEGIN
          aux:=aux2;
          aux2:=aux2^.sig;
        END;
      aux^.sig:=NIL;
      l.ultimo:=aux;
      dispose(aux2);
      aux2:=NIL;
    END;
END;

PROCEDURE Copia(VAR c:TLista;l:TLista);
BEGIN
  CrearVacia(c);
  WHILE l.primero<>NIL DO
    BEGIN
    InsertarFinal(c,l.primero^.info);
    l.primero:=l.primero^.sig;
    END;
END;

PROCEDURE Destruir(VAR l:TLista);
BEGIN
  WHILE NOT EsVacia(l) DO
    Resto(l);
END;

end.

