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
			if frame.shut then
				p [[^^{openCloseFrame|Открыть окно}]];
			else
				p [[^^{openCloseFrame|Закрыть окно}]];
			end
		end

		if s.obj:srch('latch') then
			if latch.locked then
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
		'desk'
	};
};

-- Objects

latch = obj {
	nam = 'latch',

	locked = false,
	
	act = function(s)
		p [[Старый немного проржавевший шпингалет ]];
		if s.locked then
			p [[^^Чтобы поднять его, понадобится какой-нибудь подходящий инструмент.]];
		else
			p [[^^Чтобы опустить его, понадобится какой-нибудь подходящий инструмент.]];
		end
	end;
};

frame = obj {
	nam = 'frame',

	shut = true
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
		if frame.shut then
			if latch.locked then
				p [[Оконные створки надежно закрыты, шпингалет опущен. Чтобы открыть окно нужно сначала поднять шпингалет.]];
			else
				p [[Оконные створки закрыты, но болтаются, т.к. шпингалет поднят. Любой сильный порыв ветра может с легкостью распахнуть их.]];
			end
		else
			if latch.locked then
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
		if latch.locked then
			return false;
		end

		if frame.shut then
			frame.shut = false;
			p [[Вы открыли окно.]];
		else
			frame.shut = true;
			p [[Вы закрыли окно.]];
		end

	end;
};

