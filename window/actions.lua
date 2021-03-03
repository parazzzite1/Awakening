
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

