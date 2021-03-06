
-- Room

desk = room {
	nam = 'desk',
	disp = "Письменный стол",
	way = {
		'near_bed',
		'workbench',
		'window',
	};

	decor = function(s)
		p [[Перед вами небольшой письменный стол c дубовой {tabletop|столешницей}.]];
		if s.obj:srch('folder') then
			p [[
				^^На ней валяется пустая {folder|папка} для бумаг
				и несколько исписанных листов.
			]];
		end;

		if s.obj:srch('lamp') then
			p [[В углу стола стоит керасиновая {lamp|лампа}.]];
		end;

		p [[^^Под столешницей есть {drawer|выдвижной ящик}.]];
	end;

	obj = {
		'tabletop',
		'lamp',
		'folder',
		'drawer'
	};
};

-- Objects

require "house.desk.objects.index"
require "diary.index"

-- Transitions

-- Actions
