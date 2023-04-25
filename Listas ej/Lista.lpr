program Lista;

uses uElementoIntej, uListaEstaticaQueSimulaDinamicaej;

VAR
  l,l2,l3,c:TLista;
  e:TElemento;

BEGIN
  CrearVacia(l);
  readln(e);
  Construir(l,e);
  readln(e);
  Construir(l,e);
  readln(e);
  Construir(l,e);
  readln(e);
  Construir(l,e);
  readln(e);
  Construir(l,e);
  writeln('lista1:');
  MostrarLista(l);
  readln;

  {writeln('Primero');
  Primero(l,e);
  writeln(e);
  readln;

  writeln('Resto');
  Resto(l);
  writeln('lista1:');
  MostrarLista(l);
  readln;

  writeln('Longitud');
  writeln(Longitud(l));
  readln;

  writeln('Ultimo');
  Ultimo(l,e);
  writeln(e);
  readln;

  writeln('Pertenece');
  readln(e);
  writeln(Pertenece(l,e));
  readln;}


  {CrearVacia(l2);
  readln(e);
  Construir(l2,e);
  readln(e);
  Construir(l2,e);
  readln(e);
  Construir(l2,e);
  readln(e);
  Construir(l2,e);
  readln(e);
  Construir(l2,e);
  writeln('lista2:');
  MostrarLista(l2);
  readln;

  writeln('Lista3');
  Concatenar(l3,l,l2);
  MostrarLista(l3);
  readln;}

  {writeln('BorrarElemento');
  readln(e);
  BorrarElemento(l,e);
  MostrarLista(l);
  readln;

  writeln('BorrarFinal');
  BorrarFinal(l);
  MostrarLista(l);
  readln;}

  writeln('Copia');
  Copia(c,l);
  MostrarLista(c);
  readln;

  writeln('BorrarLista/Destruir');
  Destruir(l);
  MostrarLista(l);
  readln;

END.
