-- Room

ceiling = room {
	nam = 'ceiling',
	disp = "Потолок",

	dsc = function()
		p [[На белой штукатурке местами виднеются желтоватые пятна - должно быть, крыша протекает во время сильных дождей.]];
		if not me().standing then
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

	act = function(s)
		me().awoke = true;
		
		if not me().standing then
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
		p [[Старая пыльная паутина.]];
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
		p [[Паук-крестовик. Частый гость в сельских домах.]];
	end;
};

paper = obj {
	nam = 'paper',
	
	is_read = false,
	
	-- Признак того, что это записка (и ее можно переместить в дневник, например)
	is_note_looking = true,
	
	dsc = [[В паутине застрял {кусочек бумаги}.]],

	disp = function(s)
		if s.is_read then
			p "Бумажка (прочитано)";
		else
			p "Бумажка";
		end
	end;

	inv = function(s)
		s.is_read = true;
		p [[На бумажке написано: "Оставь паука в покое".]];
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

