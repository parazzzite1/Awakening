require "windowView" 

-- Room

window = room {
	nam = 'window',
	disp = 'Окно',
	
	obj = {
		'transitionWindowView',
		'investigateFrame'
	};
	
	enter = function(s,f)
		if f.nam ~= 'windowView' then
			p [[Вы подходите к окну.]];

		end
	end;

	way = { 'nearBed' };
};

-- Objects

latch = obj {
	nam = 'latch',

	locked = false,

	dsc = function(s)
		if s.locked then
			p [[{^^Шпингалет} опущен.]];
		else
			p [[{^^Шпингалет} поднят.]]
		end
	end;

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

	dsc = [[Из окна открывается {вид} на дальние луга и холмы.]],
	
	act = function(s)
		walk('windowView');
	end;
};

-- Actions

investigateFrame = obj {
	nam = 'investigateWindow',

	dsc = "^^{Изучить окно}",
	
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

		s.obj:del(openCloseFrame);
		s.obj:del(latch);
		
		s.obj:add(openCloseFrame);
		s.obj:add(latch);

	end;

};

openCloseFrame = obj {
	nam = 'openCloseFrame',

	dsc = function(s)
		if frame.shut then
			p "^^{Открыть окно}";
		else
			p "^^{Закрыть окно}";
		end
	end;
	
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

