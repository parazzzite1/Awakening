
-- Utils

function note_looking_usage(s, w)
	if w.is_note_looking and not is_note_in_diary(w, s) then
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

function is_player_has_note(n)
	local d = inv():srch('diary');
	if d and is_note_in_diary(n, d) then
		return true;
	end

	if inv():srch(n.nam) then
		return true;
	end

	return false;
end

function is_note_in_diary(n, d)
	for i, note in ipairs(d.notes) do
		if note == n then
			return true;
		end
	end

	return false;
end

function has_unread_records(d)
	for i, r in ipairs(d.records) do
		if not r.is_read then
			return true;
		end
	end

	return false;
end

function add_new_record(d, r)
	table.insert(d.records, r);
	if d.is_opened then
		diary_re_open(d);
	end

  p(fmt.b("^^Добавлена новая запись в дневнике"));
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
