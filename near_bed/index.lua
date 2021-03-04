-- Room

near_bed = room {
	nam = 'near_bed',
	disp = 'Кровать',

	decor = function(s)
		p [[Недалеко от себя вы видите {chair|стул}.]];
		if chair.obj:srch('clothes') then
			p [[На стуле висит {clothes|одежда}.]];
		end

		p [[^^{lie_on_bed|Лечь на кровать}]];
		p [[^^{go_under_bed|Залезть под кровать}]];
		p [[^^{look_at_ceiling|Осмотреть потолок}]];
	end;

	obj = {
		'chair',
		'lie_on_bed',
		'look_at_ceiling',
		'go_under_bed',
	};

	way = {
		'desk',
		'workbench',
		'window',
	};

	onexit = function(s, t)
		if is_transition_allowed(t) then
			return true;
		else
			return [[Сначала неплохо бы одеться.]], false;
		end
	end;
};

-- Objects

require "near_bed.objects.index"

-- Transitions

require "ceiling.index"
require "window.index"
require "desk.index"
require "workbench.index"
require "under_bed"

lie_on_bed = obj {
	nam = 'lie_on_bed',

	act = function()
		if me().is_dressed then
			p [[Вы плюхаетесь на кровать прямо в одежде.]];
		else
			p [[И снова под одеяло.]];
		end

		me().is_standing = false;

		walk('main');
	end;
};

go_under_bed = obj {
	nam = 'go_under_bed',

	act = function()
		p [[Вы лезете под кровать.]];
		walk('under_bed');
	end;
};

-- Utils

is_transition_allowed = function(t)
	return me().is_dressed or t.nam == 'main' or t.nam == 'ceiling' or t.nam == 'under_bed';
end;
