
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

