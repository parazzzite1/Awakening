web = obj {
	nam = 'web',
	dsc = "В углу разрослась {паутина}.",
	act = function()
		p [[Не дотянуться.]]
	end;
};

spider = obj {
	nam = 'spider',
	dsc = "В паутине вы замечаете довольно крупного {паука}.",
	act = function()
		p [[Ослик, суслик, пауканн ...]];
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
	nam = 'lookAtCeiling';
	dsc = "^^{Осмотреть потолок}";
	act = function(s)
		me().awoke = true;
		
		ceiling.obj:zap();
		if me().standing ~= true then
			p [[Приподняв голову с подушки вы пытаетесь разглядеть потолок получше. Наверное, лучше встать с кровати чтобы разобрать больше деталей.]];
		else
			p [[Вы внимательно осматриваете потолок.]];
			ceiling.obj:add(web);
			ceiling.obj:add(spider);
		end;

		local currentRoom = here();
		ceiling.way:zap();
		ceiling.way:add(currentRoom, 0);
		
		walk('ceiling');

		return true;
	end;
};
