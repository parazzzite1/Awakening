-- Room

underBed = room {
	nam = 'underBed',

	disp = 'Под кроватью',

	decor = function(s)
		local l = inv():srch('lamp');
		if l and l.is_on then
			p [[Свет лампы разгоняет тьму.]];
		else
			p [[Под кроватью очень темно. Ничего не видно.]];
		end

		p [[^^{leaveUnderBed|Вылезти из-под кровати}]];
	end;

	obj = {
		'leaveUnderBed',
	};

	way = {
		'nearBed',
	};
};

-- Transitions

leaveUnderBed = obj {
	nam = 'leaveUnderBed',

	act = function(s)
		p [[Вы выбираетесь из-под кровати.]];
		walk('nearBed');
	end;
};

