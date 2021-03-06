
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
			p [[
				"... и врут календaри ..." В лампе нет керосина.
				Надо наполнить ее, пережде чем использовать.
			]];
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
		if is_pot_with_kerosene(w) then
			p [[Вы пытаетесь засунуть лампу в банку с керосином, но тщетно.]];
		end

		return false;
	end;

	used = function(s, w)
		if is_pot(w) then
			if not s.is_filled and is_pot_with_kerosene(w) then
				s.is_filled = true;
				w.substance = nil;

				p [[Вы наполняете керосиновую лампу. Да будет свет!]];

				return true
			elseif is_investigated_empty_pot(w) then
					p [[Вы наполняете лампу пустотой.
						Ну то есть, ничем вы ее не наполняете. Да.
					]];
					if s.is_filled then
						p [[Кстати, лампа и так полная.]];
					end

					return true
			end
		elseif w.nam == 'hummer' then
			p [[Лампа еще пригодится.]];
			return true;
		end

		return  "Лучше не стоит", false;
	end;
};
