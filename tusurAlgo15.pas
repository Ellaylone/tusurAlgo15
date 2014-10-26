Program lr5;
type
	PNode = ^TNode;
	Tnode = record
		Value: integer; {Значение элемента}
		Next: PNode; {Указатель на следующий элемент}
	end;
var
	First: PNode; {Первый элемент}
	Temp: PNode; {Список}
	v: integer; {Вспомогательная переменная}
procedure nodeError(code: Shortint); {Вывод ошибки по коду}
begin
	if (code=1) then begin {В списке только один элемент, невозможно выполнить операцию}
		writeln('Only one element in node');
	end else if(code=2) then begin {Список пуст}
		writeln('Node is empty');
	end;
end;
function checkNode(shout: Boolean): Boolean; {Проверка на возможность выполнения операции над списком}
begin
	if First=NIL then begin 
		if shout then nodeError(2); {список пуст}
		checkNode := false;
	end else checkNode := true;
end;
procedure makeNode(); {Создание и наполнение списка}
begin
	First := nil; {Создание пустого списка}
	repeat
		writeln('Enter new value (0 to stop)');
		readln(v); {Ввод значений}
		if v=0 then break; {Если 0 - окончить ввод}
		if First=NIL then {Если список пуст}
			begin
				new(Temp); {Создаем первый элемент}
				First:=Temp;
			end
		else
		begin
			New(Temp^.Next); {Создаем на основе предыдущего, чтобы сохранилась связь между элементами}
			Temp:=Temp^.Next;
		end;
		Temp^.Value:=v; {Записываем значение}
	until false;
	if checkNode(false) then Temp^.Next:=NIL; {В последнем элементе нет ссылки на следующий элемент}
end;
function walkNode(show: Boolean): integer; {Проход по всем элементам списка}
var
	tempValue: integer;
begin
	tempValue := 0;
	Temp := First;
	while Temp<>NIL do
	begin
		tempValue := Temp^.Value;
		if show=true then write(tempValue); {Вывод}
		Temp := Temp^.Next;
	end;
	if show=true then writeln();
	walkNode := tempValue; {Возвращаем значение последнего элемента}
end;
procedure showNode(); {Вывести список в консоль}
begin
	if checkNode(true) then walkNode(true); {Сначала вызываем проверку списка}
end;
procedure disposeLast(); {Удалить последний элемент списка}
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
procedure moveLastToFirst(); {Замещаем первый элемент последним}
var
	TempFirst: PNode;
begin
	if checkNode(false) then
		if First^.Next<>NIL then begin
			new(TempFirst);
			TempFirst^.value := walkNode(false);
			TempFirst^.Next := First;
			First := TempFirst;
			Temp := First;
			disposeLast(); {Удаляем последний элемент}
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