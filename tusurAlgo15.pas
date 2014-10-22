Program lr5;
type
	PNode = ^TNode;
	Tnode = record
		Value: integer; {Значение элемента}
		Next: PNode; {Указатель на следующий элемент}
	end;
var
	First: PNode;
	Temp: PNode;
	v: integer;
procedure nodeError(code: Shortint);
begin
	if (code=1) then begin {}
		writeln('Only one element in node');
	end else if(code=2) then begin {Исчерпание очереди}
		writeln('Node is empty');
	end;
end;
function checkNode(shout: Boolean): Boolean;
begin
	if First=NIL then begin 
		if shout then nodeError(2);
		checkNode := false;
	end else checkNode := true;
end;
procedure makeNode();
begin
	First := nil;
	repeat
		writeln('Enter new value (0 to stop)');
		readln(v);
		if v=0 then break; {Если 0 - окончим ввод элементов}
		//TODO check if integer
		if First=NIL then
			begin
				new(Temp); {Создали первый элемент. Его адрес в Temp}
				First:=Temp;
			end
		else
		begin
			New(Temp^.Next); {Создаем на основе предыдущего, чтобы сохранилась связь между элементами}
			Temp:=Temp^.Next;
		end;
		Temp^.Value:=v;
	until false;
	if checkNode(false) then Temp^.Next:=NIL; {В последнем элементе нет ссылки на следующий элемент}
end;
function walkNode(show: Boolean): integer;
var
	tempValue: integer;
begin
	tempValue := 0;
	Temp := First;
	while Temp<>NIL do
	begin
	tempValue := Temp^.Value;
		if show=true then write(tempValue);
		Temp := Temp^.Next;
	end;
	if show=true then writeln();
	walkNode := tempValue;
end;
procedure showNode();
begin
	if checkNode(false) then	walkNode(true);
end;
procedure disposeLast();
var
	Temp2: PNode;
begin
	while Temp^.Next<>NIL do
	begin
		Temp2 := Temp;
		Temp := Temp^.Next;
	end;
	Temp2^.Next := nil;
	Temp := Temp2;
end;
procedure moveLastToFirst();
begin
	if checkNode(false) then
		if First^.Next<>NIL then begin		
			First^.Value := walkNode(false);
			Temp := First;
			disposeLast();
		end else nodeError(1);
end;
begin
	makeNode(); {Наполняем список}
	if checkNode(true) then begin
		showNode(); {Выводим созданный список}
		moveLastToFirst(); {Переставляем последний элемент в начало списка}
		showNode(); {Выводим список}
		moveLastToFirst(); {Переставляем последний элемент в начало списка}
		showNode(); {Выводим список}
	end;
	writeln('Done!');
	readln();
end.