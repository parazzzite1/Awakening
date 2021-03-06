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

-- Records

require "diary.records.old_church"

-- Utils

require "diary.utils"
