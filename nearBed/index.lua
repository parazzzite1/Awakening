-- Room

nearBed = room {
	nam = 'nearBed',
	disp = 'Кровать',

	decor = function(s)
		p [[Недалеко от себя вы видите {chair|стул}.]];
		if chair.obj:srch('clothes') then
			p [[На стуле висит {clothes|одежда}.]];
		end

		p [[^^{lieOnBed|Лечь на кровать}]];
		p [[^^{goUnderBed|Залезть под кровать}]];
		p [[^^{lookAtCeiling|Осмотреть потолок}]];
	end;

	obj = { 
		'chair',
		'lieOnBed',
		'lookAtCeiling',
		'goUnderBed',
	};

	way = {
		'window',
		'desk',
		'workbench'
	};

	onexit = function(s,t)
		if me().dressed or t.nam == 'main' or t.nam == 'ceiling' or t.nam == 'underBed' then
			return true;
		else
			return [[Сначала неплохо бы одеться.]], false;
		end
	end;
};

-- Objects

require "nearBed.objects.index"

-- Transitions

require "ceiling.index"
require "window.index"
require "desk.index"
require "workbench.index"
require "underBed"

lieOnBed = obj {
	nam = 'lieOnBed',
	
	act = function()
		if me().dressed then
			p [[Вы плюхаетесь на кровать прямо в одежде.]];
		else
			p [[И снова под одеяло.]];
		end

		me().standing = false;
		
		walk('main');
	end;	
};

goUnderBed = obj {
	nam = 'goUnderBed',

	act = function()
		p [[Вы лезете под кровать.]];
		walk('underBed');
	end;
};

