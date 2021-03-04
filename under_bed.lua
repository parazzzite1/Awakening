-- Room

under_bed = room {
	nam = 'under_bed',

	disp = 'Под кроватью',

	decor = function(s)
		local l = inv():srch('lamp');
		if l and l.is_on then
			p [[Свет лампы разгоняет тьму.]];

			if s.obj:srch('forgotten_letter') then
				p [[В дальнем углу в пыли вы замечаете маленький {forgotten_letter|клочок бумаги}.]]
			end

			if s.obj:srch('twinkles') then
				p [[Два {twinkles|маленьких огонька} следят за вами. Или это только кажется?]]
			end
		else
			p [[Под кроватью очень темно. Ничего не видно.]];
		end

		p [[^^{leave_under_bed|Вылезти из-под кровати}]];
	end;

	obj = {
		'leave_under_bed',
		'forgotten_letter',
		'twinkles',
	};
};

-- Objects

forgotten_letter = obj {
	is_read = false,

	-- Признак того, что это записка (и ее можно переместить в дневник, например)
	is_note_looking = true,

	nam = 'forgotten_letter',

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
			^^Надеюсь арендованный в этой глуши дом пришелся тебе по вкусу. Церковь, которую мы так долго искали, должны быть видна из окна.
			^^Помни, времени в обрез - нельзя терять ни минуты. Прихвати с собой все самое необходимое и берись за дело.
			^Лучше выйти через окно - так безопаснее.
			^^PS. лампу и молоток рекомендую прихватить с собой."
		]];
	end;

	tak = 'Кое-как вам удается дотянуться и забрать бумажку себе. Кажется, это письмо.',
};

twinkles = obj {
	nam = 'twinkles',

	act = function(s)
		p [[Вы тянете руку к огонькам и слышите тихий писк и шуршание. Видимо где-то в стене под кроватью у мышки норка.]]
		s:remove();
	end;
};

-- Transitions

leave_under_bed = obj {
	nam = 'leave_under_bed',

	act = function(s)
		p [[Вы выбираетесь из-под кровати.]];
		walk('near_bed');
	end;
};
