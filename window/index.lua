
-- Room

window = room {
	nam = 'window',
	disp = 'Окно',
	
	decor = function(s)
		if s.obj:srch('transitionWindowView') then
			p [[Из окна открывается {transitionWindowView|вид} на дальние луга и холмы.]];
		end

		if s.obj:srch('investigateFrame') then
			p [[^^{investigateFrame|Изучить окно}]];
		end

		if s.obj:srch('openCloseFrame') then
			if frame.is_shut then
				p [[^^{openCloseFrame|Открыть окно}]];
			else
				p [[^^{openCloseFrame|Закрыть окно}]];
			end
		end

		if s.obj:srch('latch') then
			if latch.is_locked then
				p [[^^{latch|Шпингалет} опущен.]];
			else
				p [[^^{latch|Шпингалет} поднят.]];
			end
		end
	end;

	obj = {
		'transitionWindowView',
		'investigateFrame'
	};
	
	onenter = function(s,f)
		if f.nam ~= 'windowView' then
			p [[Вы подходите к окну.]];

		end
	end;

	way = { 
		'nearBed',
		'desk',
		'workbench'
	};
};

-- Objects

require "window.objects"

-- Transitions

require "windowView" 

transitionWindowView = obj {
	nam = 'transitionWindowView',

	act = function(s)
		walk('windowView');
	end;
};

-- Actions

require "window.actions"

