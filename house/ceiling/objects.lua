
-- Objects

web = obj {
	nam = 'web',
	dsc = "В углу разрослась {паутина}.",

	act = function()
		p [[Старая пыльная паутина.]];
	end;

	obj = {
		'spider',
		'paper'
	};
};

spider = obj {
	nam = 'spider',
	dsc = "В паутине вы замечаете довольно крупного {паука}.",

	act = function()
		p [[Паук-крестовик. Частый гость в сельских домах.]];
	end;

	used = function(s, w)
		if w.nam == 'pot' and not pot.substance then
			p [[
				Почуяв неладное, паук спешит забраться повыше.
				Жестяная банка ему явно не по вкусу.
			]];

			return true;
		end

		return false;
	end;
};

paper = obj {
	nam = 'paper',

	is_read = false,

	-- Признак того, что это записка (и ее можно переместить в дневник, например)
	is_note_looking = true,

	dsc = [[В паутине застрял {кусочек бумаги}.]],

	disp = function(s)
		if s.is_read then
			p "Бумажка (прочитано)";
		else
			p "Бумажка";
		end
	end;

	inv = function(s)
		s.is_read = true;
		p [[На бумажке написано: "Оставь паука в покое".]];
	end;

	tak = function()
		if me().is_standing then
			p [[
				Вы подпрыгиваете и хватаете бумажку так, что паутина ходит ходуном.
				Паук напуган.
			]];
			return true;
		else
			return false;
		end
	end;
};
