require "windowView" 

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

latch = obj {
	nam = 'latch',

	is_locked = false,
	
	act = function(s)
		p [[Старый немного проржавевший шпингалет ]];
		if s.is_locked then
			p [[^^Чтобы поднять его, понадобится какой-нибудь подходящий инструмент.]];
		else
			p [[^^Чтобы опустить его, понадобится какой-нибудь подходящий инструмент.]];
		end
	end;

	used = function(s, w)
		if w.nam == 'hummer' then
			s.is_locked = not s.is_locked;
			if s.is_locked then
				p [[Один точный удар молотка, и шпингалет опущен.]];
			else
				p [[Вы используете рукоять молотка как рычаг, чтобы поднять шпингалет. Голова!]];
			end

			return true;
		end

		return false;
	end;
};

frame = obj {
	is_shut = true,
	nam = 'frame',
};

-- Transitions

transitionWindowView = obj {
	nam = 'transitionWindowView',

	act = function(s)
		walk('windowView');
	end;
};

-- Actions

investigateFrame = obj {
	nam = 'investigateFrame',
	
	act = function(s)
		if frame.is_shut then
			if latch.is_locked then
				p [[Оконные створки надежно закрыты, шпингалет опущен. Чтобы открыть окно нужно сначала поднять шпингалет.]];
			else
				p [[Оконные створки закрыты, но болтаются, т.к. шпингалет поднят. Любой сильный порыв ветра может с легкостью распахнуть их.]];
			end
		else
			if latch.is_locked then
				p [[Окно распахнуто настежь. Пока шпингалет опущен, створки не закрыть.]];
			else
				p [[Окно распахнуто настежь, шпингалет поднят.]];
			end
		end

		window.obj:del(openCloseFrame);
		window.obj:del(latch);
		
		window.obj:add(openCloseFrame);
		window.obj:add(latch);

	end;

};

openCloseFrame = obj {
	nam = 'openCloseFrame',
	
	act = function(s)
		if latch.is_locked then
			if frame.is_shut then
				p [[Пока шпингалет опущен, створки не открыть.]];
			else
				p [[Пока шпингалет опущен, створки не закрыть.]];
			end
			
			return false;
		end
		
		frame.is_shut = not frame.is_shut;
		if frame.is_shut then
			p [[Вы закрыли окно.]];
		else
			p [[Вы открыли окно окно.]];
		end

		return true;
	end;
};

