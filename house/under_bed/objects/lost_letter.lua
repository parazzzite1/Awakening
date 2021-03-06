
-- Objects

lost_letter = obj {
	is_read = false,

	-- Признак того, что это записка (и ее можно переместить в дневник, например)
	is_note_looking = true,

	nam = 'lost_letter',

	disp = function(s)
		if s.is_read then
			p "Письмо (прочитано)";
		else
			p "Письмо";
		end
	end;

	inv = function(s)
		s.is_read = true;
		p [[
			Письмо кто-то погрыз, но вам без особых проблем удается разобрать следующее:
			^^"Дорогой друг!
			^^Надеюсь арендованный в этой глуши дом пришелся тебе по вкусу.
			Церковь, которую мы так долго искали, должны быть видна из окна.
			^^Помни, времени в обрез - нельзя терять ни минуты.
			Прихвати с собой все самое необходимое и берись за дело.
			^Лучше выйти через окно, чтобы не привлекать лишнего внимания.
			^^P.S. лампу и молоток рекомендую прихватить с собой."
		]];
	end;

	tak = 'Кое-как вам удается дотянуться и забрать бумажку себе. Кажется, это письмо.',
};
