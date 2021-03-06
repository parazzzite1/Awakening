-- Room

under_bed = room {
	nam = 'under_bed',

	disp = 'Под кроватью',

	decor = function(s)
		local l = inv():srch('lamp');
		if l and l.is_on then
			p [[Свет лампы разгоняет тьму.]];

			if s.obj:srch('lost_letter') then
				p [[В дальнем углу в пыли вы замечаете маленький {lost_letter|клочок бумаги}.]]
			end

			if s.obj:srch('twinkles') then
				p [[Два {twinkles|маленьких огонька} следят за вами. Или это только кажется?]]
			end
		else
			p [[Под кроватью очень темно. Ничего не видно.]];
		end

		p [[^^{leave_under_bed|Вылезти из-под кровати}]];
	end;

	obj = {
		'leave_under_bed',
		'lost_letter',
		'twinkles',
	};
};

-- Objects

require "under_bed.objects.index"

-- Transitions

leave_under_bed = obj {
	nam = 'leave_under_bed',

	act = function(s)
		p [[Вы выбираетесь из-под кровати.]];
		walk('near_bed');
	end;
};
