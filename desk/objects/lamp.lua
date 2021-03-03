
-- Objects

lamp = obj {
	nam = 'lamp',
	
	is_fillable = true,
	is_filled = false,
	is_on = false,

	tak = "Вы взяли керосиновую лампу.",

	disp = function(s)
		if s.is_on then
			return "Лампа (горит)"
		else
			return "Лампа (не горит)"
		end
	end;


	inv = function(s)
		if not lamp.is_filled then
			p [["... и врут календaри ..." В лампе нет керосина. Надо наполнить ее, пережде чем использовать.]];
		else
			if not s.is_on then
				p [[Вы включаете лампу и из нее начинает струиться теплый свет.]];
				s.is_on = true;
			else
				p [[Вы выключаете лампу.]];
				s.is_on = false;
			end
		end
	end;

	use = function(s, w)
		if w.nam == 'pot' and w.is_investigated and w.substance and w.substance.nam == 'kerosene' then
			p [[Вы пытаетесь засунуть лампу в банку с керосином, но тщетно.]];
		end

		return false;
	end;

	used = function(s, w)
		if w.nam == 'pot' then
			if not s.is_filled and w.is_investigated and w.substance and w.substance.nam == 'kerosene' then
				s.is_filled = true;
				w.substance = nil;

				p [[Вы наполняете керосиновую лампу. Да будет свет!]];
			else
				if not w.is_investigated then
					p [[Надо сначала понять, что в банке.]];
				elseif not w.substance then
					p [[Вы наполняете лампу пустотой. Ну то есть, ничем вы ее не наполняете. Да.]];
				end

				if s.is_filled then
					p [[Кстати, лампа и так полная.]];
				end

			
			end
			
			return true;
		elseif w.nam == 'hummer' then
			p [[Лампа еще пригодится.]];
			return true;
		end

		return false;
	end;
};
