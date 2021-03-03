-- Room

workbench = room {
	nam = 'workbench',

	disp = 'Верстак',

	way = {
		'desk',
		'window',
		'nearBed'
	};

	decor = function(s)
		p [[Перед вами крепкий столярный верстак.]];
		if s.obj:srch('hummer') then
			p [[^^Среди интрументов вы подмечаете {hummer|молоток}.]];
		end

		if s.obj:srch('pot') then
			p [[^^Над верстаком на полке стоит плотно закрытая жестяная {pot|банка}.]];
		end

		if s.obj:empty() then
			p [[Кажется, здесь больше нет ничего интересного.]];
		end
	end;

	obj = {
		'hummer',
		'pot'
	};
};

-- Objects

hammer = obj {
	nam = 'hummer',
	disp = 'Молоток',

	tak = "Вы взяли молоток",

	inv = "Увесистый такой, пригодится."
};

kerosene = obj {
	is_substance = true,

	nam = 'kerosene';
	disp = 'керосин';
};

pot = obj {
	is_investigated = false,
	substance = kerosene,

	nam = 'pot',

	disp = function(s)
		if not s.is_investigated and s.substance then
			return  "Банка (с чем-то)";
		else
			if not s.substance then
				return "Банка (пусто)";
			else
				return string.format("Банка (%s)", std.dispof(s.substance));
			end
		end
	end;

	tak = function(s)
		if not s.is_investigated and s.substance then
			return p [[Вы взяли банку. В ней что-то плещется.]];
		elseif s.substance then
			return string.format("Вы взяли банку. В ней - %s.", std.dispof(s.substance));
		else
			return p [[Вы взяли банку. В ней ничего нет.]]
		end
	end;

	inv = function(s)
		if not s.is_investigated and s.substance then
			s.is_investigated = true;
			return string.format("Вы открываете банку и изучаете содержимое - в ней %s.", std.dispof(s.substance));
		elseif s.substance then
			return string.format("В банке %s.%s", std.dispof(s.substance), pot_extra_inv_msg(s));
		else
			return "Пустая банка. Может пригодиться.";
		end
	end;


	use = function(s, w)
		if not s.is_investigated then
			-- Если вы не знаете, что в банке, то ее никак не использовать
			p[[Сначал надо понять что в банке.]];
			return false;
		end

		if not s.substance and w.is_substance then
			-- Позволяем набрать в банку любую субстанцию, если она (банка) пустая
			s.substance = w;
			return true;
		elseif s.substance and w.is_fillable or w.is_wettable then
			-- Позволяем наполнить/намочить любой подходящий объект (если в банке что-то есть).
			-- Станет ли при этом банка пустой, решается в объекте, на который банка применяется.
			return true;
		else
			return false;
		end
	end;

	used = function(s, w)
		if w.nam == 'hummer' then
			if not s.is_investigated then
				p [[Сначала надо узнать что в банке - вдруг там нитроглицерин?]];
				return true;
			elseif s.is_investigated and s.substance and s.substance.nam == 'kerosene' then
				p [[На мгновение вас одолевает желание обмокнуть молоток в керосин и поджечь, но ... не время быть богом огня.]]
				return true;
			elseif not s.substance then
				p [[Преисполняясь первобытной радостью, вы с удовольствием колотите молотком по пустой банке - звук гулкий и приятный.]]
				return true;
			end
		end

		return false;
	end;
};

function pot_extra_inv_msg(s)
	if s.substance.nam == 'kerosene' then
		return " Теперь мы можем зажечь.";
	end

	return '';
end;

