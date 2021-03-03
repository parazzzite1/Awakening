
-- Objects

diary = obj {
	state = false;
	notes = {};

	nam = 'diary';

	disp = function(s)
		if s.state then
			return fmt.u("Дневник");
		end

		return "Дневник";
	end;

	inv = function(s)
		s.state = not s.state;
		if s.state then
			for i, note in ipairs(s.notes) do
				s.obj:add(note);
			end
			
			if s.obj:empty() then
				p [[Нет записей.]];
			end
		else
			s.obj:zap();
		end
    	end;

	used = function(s,w)
		if w.is_note_looking then
			return note_looking_usage(s, w);
		elseif w.nam == 'pot' and w.substance and w.substance.nam == 'kerosene' then
			p [[Дневник еще пригодится. Керосин тоже.]];
			return true;
		end

		return false;
	end;
};

function note_looking_usage(s, w)
	if w.is_note_looking and not note_in_diary(w, s) then
		remove(w);
		table.insert(s.notes, w);
		p [[Вы вложили новую записку в дневник.]];
		if s.state then
			s.obj:add(w);
		end

		return true;
	end
	return false;
end

function note_in_diary(n, d)
	for i, note in ipairs(d.notes) do
		if note == n then
			return true;
		end
	end

	return false;
end

