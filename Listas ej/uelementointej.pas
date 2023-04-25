unit uElementoIntej;



interface

   TYPE
     TElemento = Integer;

   PROCEDURE Asignar(VAR e1:TElemento;e2:TElemento);
   PROCEDURE Mostrar(e:TElemento);
   PROCEDURE InsertarElemento(VAR e:TElemento; i :Integer);
   FUNCTION EsIgual(e1:TElemento;e2:TElemento):Boolean;
   FUNCTION Menor(e1:TElemento;e2:TElemento):Boolean;

implementation
   PROCEDURE Asignar(VAR e1:TElemento;e2:TElemento);
   BEGIN
     e1:= e2;
   END;

   PROCEDURE Mostrar(e:TElemento);
   BEGIN
     writeln(e);
   END;

   PROCEDURE InsertarElemento (VAR e:TElemento; i :Integer);
   BEGIN
     e:= i;
   END;

   FUNCTION EsIgual(e1:TElemento;e2:TElemento):Boolean;
   BEGIN
     EsIgual:= e1 = e2;
   END;

   FUNCTION Menor(e1:TElemento;e2:TElemento):Boolean;
   BEGIN
     Menor:=e2<e1;
   END;

end.

