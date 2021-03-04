
-- Actions

investigate_frame = obj {
	nam = 'investigate_frame',

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

		window.obj:del(open_close_frame);
		window.obj:del(latch);
		window.obj:del(get_out);

		window.obj:add(open_close_frame);
		window.obj:add(latch);
		if not frame.is_shut then
			window.obj:add(get_out);
		end;

	end;

};

open_close_frame = obj {
	nam = 'open_close_frame',

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
			window.obj:del(get_out);
		else
			p [[Вы открыли окно окно.]];
			window.obj:add(get_out);
		end

		return true;
	end;
};
