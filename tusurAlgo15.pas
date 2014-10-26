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
	tempValue: integer; {Переменная для хранения значения последнего элемента}
begin
	tempValue := 0;
	Temp := First; {Проходим список с первого элемента}
	while Temp<>NIL do
	begin
		tempValue := Temp^.Value;
		if show=true then write(tempValue); {Вывод если нужен}
		Temp := Temp^.Next;
	end;
	if show=true then writeln(); {Конец строки}
	walkNode := tempValue; {Возвращаем значение последнего элемента}
end;
procedure showNode(); {Вывести список в консоль}
begin
	if checkNode(true) then walkNode(true); {Сначала вызываем проверку списка}
end;
procedure disposeLast(); {Удалить последний элемент списка}
var
	Temp2: PNode; {Вспомогательная переменная для сохранения предпоследнего элемента}
begin
	while Temp^.Next<>NIL do
	begin
		Temp2 := Temp; {Сохраняем предпоследний элемент}
		Temp := Temp^.Next;
	end;
	Temp2^.Next := nil; {Предпоследний элемент больше не ссылается ни на что}
	Temp := Temp2; {Заменяем предпоследний элемент}
end;
procedure moveLastToFirst(); {Замещаем первый элемент последним}
var
	TempFirst: PNode; {Временный первый элемент}
begin
	if checkNode(false) then begin
		if First^.Next<>NIL then begin {Находим последний элемент}
			new(TempFirst); {Создаем новый пустой элемент}
			TempFirst^.value := walkNode(false); {Присваеваем ему значение последнего элемента списка}
			TempFirst^.Next := First; {Записываем в него ссылку на первый элемент списка}
			First := TempFirst; {Заменяем первый элемент новым}
			Temp := First; {Возвращаем список в начало}
			disposeLast(); {Удаляем последний элемент списка}
		end else nodeError(1);
	end;
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