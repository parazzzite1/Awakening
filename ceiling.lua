-- Room

ceiling = room {
	nam = 'ceiling',
	disp = "Потолок",

	dsc = function()
		p [[На белой штукатурке местами виднеются желтоватые пятна - крыша уже давно протекает во время сильных дождей.]];
		if me().standing ~= true then
			p [[^^Кажется в дальнем углу виднеется старая паутина.]];
		end;
	end;

	obj = {
		'web'
	};

	way = { };
};

-- Transitions

lookAtCeiling = obj {
	nam = 'lookAtCeiling',
	dsc = "^^{Осмотреть потолок}",
	act = function(s)
		me().awoke = true;
		
		if me().standing ~= true then
			p [[Приподняв голову с подушки вы бегло оглядываете потолок. Наверное, лучше встать с кровати чтобы разобрать больше деталей.]];
			ceiling.obj:del('web');
		else
			p [[Вы внимательно осматриваете потолок.]];
			ceiling.obj:add('web');
		end;

		local currentRoom = here();
		ceiling.way:zap();
		ceiling.way:add(currentRoom, 0);
		
		walk('ceiling');

		return true;
	end;
};

-- Objects

web = obj {
	nam = 'web',
	dsc = "В углу разрослась {паутина}.",

	act = function()
		p [[Похоже, что паутина появилась тут недавно.]];
	end;

	obj = {
		'spider',
		'paper'
	};
};

spider = obj {
	nam = 'spider',
	dsc = "В паутине вы замечаете довольно крупного {паука}.",

	act = function()
		p [[Araneus diadematus - крестовик обыкновенный.^^Частый гость в сельских домиках.]];
	end;
};

paper = obj {
	nam = 'paper',

	read = false,
	
	dsc = [[В паутине застрял {кусочек бумаги}.]],

	disp = function(s)
		if s.read then
			p "Бумажка (прочитано)";
		else
			p "Бумажка";
		end
	end;

	inv = function(s)
		p [[На бумажке написано: "Оставь паука в покое".]];
		s.read = true;
	end;

	tak = function()
		if me().standing then
			p [[Вы подпрыгиваете и хватаете бумажку так, что паутина ходит ходуном. Паук напуган.]];
			return true;
		else
			return false;
		end
	end;
};

