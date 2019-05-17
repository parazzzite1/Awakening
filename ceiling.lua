web = obj {
	nam = 'web',
	dsc = "В углу разрослась {паутина}.",
	act = function()
		p [[Похоже, что паутина появилась тут недавно.]];
	end;
};

spider = obj {
	nam = 'spider',
	dsc = "В паутине вы замечаете довольно крупного {паука}.",
	act = function()
		p [[Похоже это Araneus diadematus - крестовик обыкновенный.^^Одному богу известно, как он здесь очутился.]];
	end;
};

paper = obj {
	nam = 'paper',

	read = false,
	
	dsc = [[В паутине заcстрял {кусочек бумаги}.]],
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

ceiling = room {
	nam = 'ceiling',
	disp = "Потолок",
	dsc = function()
		p [[На белой штукатурке местами виднеются желтоватые пятна - крыша уже давно протекает во время сильных дождей.]];
		if me().standing ~= true then
			p [[^^Кажется в дальнем углу виднеется старая паутина.]];
		end;
	end;
	way = { };
};

lookAtCeiling = obj {
	nam = 'lookAtCeiling',
	dsc = "^^{Осмотреть потолок}",
	act = function(s)
		me().awoke = true;
		
		ceiling.obj:zap();
		if me().standing ~= true then
			p [[Приподняв голову с подушки вы пытаетесь разглядеть потолок получше. Наверное, лучше встать с кровати чтобы разобрать больше деталей.]];
		else
			p [[Вы внимательно осматриваете потолок.]];
			ceiling.obj:add(web);
			ceiling.obj:add(spider);
			ceiling.obj:add(paper);
		end;

		local currentRoom = here();
		ceiling.way:zap();
		ceiling.way:add(currentRoom, 0);
		
		walk('ceiling');

		return true;
	end;
};
