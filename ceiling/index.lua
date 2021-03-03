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

require "ceiling.objects"

