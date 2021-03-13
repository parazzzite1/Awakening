
-- Objects

clothes = obj {
	is_wearing = false,
	is_wettable = true,

	nam = 'clothes',
	disp = function(s)
		if s.is_wearing then
			return "Одежда (надето)"
		else
			return "Одежда"
		end
	end;

	tak = "Вы взяли одежду.",

	inv = function(s)
		local currentRoom = here();
		if s.is_wearing and currentRoom.nam ~= 'near_bed' and currentRoom.nam ~= 'main' then
			p "Лучше не стоит.";
			return false;
		end

		if s.is_wearing then
			p "Вы разделись.";
			me().is_dressed = false;
			s.is_wearing = false;
		else
			p "Вы оделись.";
			me().is_dressed = true;
			s.is_wearing = true;
		end

		if not me().is_standing then
			p [[Вы делали это лежа, так что пришлось повозиться.]];
		end;
	end;

	use = function(s, w)
		if w.nam == 'chair' then
			drop(s);
			if me().is_dressed and s.is_wearing then
				me().is_dressed = false;
				s.is_wearing = false;

				p [[Вы сняли одежду и повесили ее на стул.]];
			else
				s.is_wearing = false;

				p [[Вы повесили одежду на стул.]];
			end

			remove(s);
			w.obj:add(s);

			return true;
		else
			return false;
		end;
	end;

	used = function(s, w)
		if is_pot(w) then
			if is_pot_with_kerosene(w) then
				if s.is_wearing then
					return [[Обливать себя керосином - не самая лучшая идея.]];
				else
					return [[Одежда скорее всего еще понадобится. Да и керосин тоже.]];
				end
			elseif is_investigated_pot_with_something(w) then
				return [[Лучше не стоит.]]
			end
		end

		return false;
	end;
};
