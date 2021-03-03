-- Room

under_bed = room {
	nam = 'under_bed',

	disp = 'Под кроватью',

	decor = function(s)
		local l = inv():srch('lamp');
		if l and l.is_on then
			p [[Свет лампы разгоняет тьму.]];
		else
			p [[Под кроватью очень темно. Ничего не видно.]];
		end

		p [[^^{leave_under_bed|Вылезти из-под кровати}]];
	end;

	obj = {
		'leave_under_bed',
	};

	way = {
		'near_bed',
	};
};

-- Transitions

leave_under_bed = obj {
	nam = 'leave_under_bed',

	act = function(s)
		p [[Вы выбираетесь из-под кровати.]];
		walk('near_bed');
	end;
};
