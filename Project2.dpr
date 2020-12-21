program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  StekElPT=^TStek;

  TStek=record
    Elem:Char;
    Next:StekElPT;
  end;




Procedure AddSteck (var st:StekElPT;value:Char);
var
  x :StekElPT;
begin
  new(x);
  x^.Elem:=value;
  x^.next:=st;
  st:=x;
end;


function GetStek(var st:StekElPT):Char;
begin
  if st<> nil then
  begin
    GEtStek:=st^.Elem;
    st := st^.next;
  end
  else
    GetStek:=#0;
end;


function StekPriority (c:Char):Integer;
begin
  case c of
    '+','-' : Result := 2;
    '*','/' : Result := 4;
    '^' : Result := 5;
    'a'..'z','A'..'Z' : Result := 8;
    '(' : Result := 0;
  else
      Result := 10;
  end;
end;


function InpPriority (c:Char):Integer;
begin
  case c of
    '+','-' : Result := 1;
    '*','/' : Result := 3;
    '^' : Result := 6;
    'a'..'z','A'..'Z' : Result := 7;
    '(' : Result := 9;
    ')' : Result := 0;
  else
    Result := 10;
  end;
end;


function CharRang(c:Char):integer;
begin
  if c in ['a'..'z','A'..'Z'] then
    Result:=1
  else
    Result:=-1;
end;

var
  st:StekElPT;
  input,output:string;
  Rang,i:Integer;
  t:Char;
begin
  st:=nil;
  Rang:=0;
  output:='';

  Write('Инфиксная форма: ');
  Readln(input);

  i:=1;
  while i<=Length(input) do

    if  (st=nil) or (InpPriority(Input[i]) > StekPriority(st^.Elem)) then
    begin
      if Input[i] <> ')' then
        AddSteck(st,input[i]);
      i:=i+1;
    end

    else
    begin
      t:=GetStek(st);
      if t <> '(' then
      begin
        output:=output+t;
        Rang := Rang + CharRang(t);
      end;

    end;


  while not (st = nil) do
  begin
    t:=GetStek(st);
    if t <> '(' then
      output:=output+t;
  end;

  Write('Постфиксная форма: ');
  Writeln(output);
  Write('Ранг выражения:');
  Writeln(Rang);
  Readln;
end.
