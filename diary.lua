
-- Objects

diary = obj {
	is_opened = false;
	records = {};
	notes = {};

	nam = 'diary';

	disp = function(s)
		if s.is_opened then
			return fmt.u("Дневник");
		end

		return "Дневник";
	end;

	inv = function(s)
		diary_toggle(s);
		if s.is_opened and s.obj:empty() then
			p [[Нет записей.]];
		end
	end;

	used = function(s,w)
		if w.is_note_looking then
			return note_looking_usage(s, w);
		elseif is_pot_with_kerosene(w) then
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
		if s.is_opened then
			diary_re_open(s);
		end

		return true;
	end
	return false;
end

function add_new_record(d, r)
	table.insert(d.records, r);
	if d.is_opened then
		diary_re_open(d);
	end
end

function diary_open(d)
	if d.is_opened then
		return;
	end

	d.is_opened = true;

	for i, record in ipairs(d.records) do
		d.obj:add(record);
	end

	for i, note in ipairs(d.notes) do
		d.obj:add(note);
	end
end

function diary_close(d)
	if not d.is_opened then
		return;
	end

	d.is_opened = false;

	d.obj:zap();
end

function diary_re_open(d)
	diary_close(d);
	diary_open(d);
end

function diary_toggle(d)
	if d.is_opened then
		diary_close(d);
	else
		diary_open(d);
	end
end

function note_in_diary(n, d)
	for i, note in ipairs(d.notes) do
		if note == n then
			return true;
		end
	end

	return false;
end
