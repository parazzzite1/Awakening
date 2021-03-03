require "diary"
require "workbench"


-- Room

desk = room {
	nam = 'desk',
	disp = "Письменный стол",
	way = {
		'nearBed',
		'window',
		'workbench'
	};

	decor = function(s)
		p [[Перед вами небольшой письменный стол c дубовой столешницей.]];
		if s.obj:srch('folder') then
			p [[^^На ней валяется пустая {folder|папка} для бумаг и несколько исписанных листов.]];
		end;
		
		if s.obj:srch('lamp') then
			p [[В углу стола стоит керасиновая {lamp|лампа}.]];
		end;

		p [[^^Под столешницей есть {drawer|выдвижной ящик}.]];
	end;

	obj = {
		'lamp',
		'folder',
		'drawer'
	};
};

-- Objects

drawer = obj {
	nam = 'drawer',

	act = function(s)
		if s.obj:empty() then
			p [[Больше в ящике нет ничего ценного.]];
		else
			p [[В ящике вы находите скрепки и чистые листы бумаги.]];

			take('papers');
			take('clips');
		end
	end;

	obj = {
		'papers',
		'clips'
	};
};

clips = obj {
	nam = 'clips',
	disp = "Скрепки",
	inv = "Скрепки для бумаги. Или еще чего.",
	use = function(s, w)
		if w.nam == 'papers' then
			p [[Действительно, почему бы не скрепить скрепками для бумаги бумагу? Но может быть попытаться использовать их как-то иначе?]];
			return false;
		elseif w.nam == 'folder' then
			remove(s);
			remove(w);
			take('binding');

			p [[С помощью скрепок вам удается превратить старую папку в что-то на подобие книжного преплета.]];

			return true;
		end
		
		return false;
	end;
};

lamp = obj {
	nam = 'lamp',
	
	is_fillable = true,
	is_filled = false,
	is_on = false,

	tak = "Вы взяли керасиновую лампу.",

	disp = function(s)
		if s.is_on then
			return "Лампа (горит)"
		else
			return "Лампа (не горит)"
		end
	end;


	inv = function(s)
		if not lamp.is_filled then
			p [["... и врут календaри ..." В лампе нет керасина. Надо наполнить ее, пережде чем использовать.]];
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
		if w.nam == 'pot' and w.is_investigated and w.substance.nam == 'kerosene' then
			p [[Вы пытаетесь засунуть лампу в банку с керосином, но тщетно.]];
		end

		return false;
	end;

	used = function(s, w)
		if w.nam == 'pot' then
			if not s.is_filled and w.is_investigated and w.substance and w.substance.nam == 'kerosene' then
				s.is_filled = true;
				w.substance = nil;

				p [[Вы наполняете керасиновую лампу. Да будет свет!]];
			else
				if not w.is_investigated then
					p [[Надо сначала понять, что в банке.]];
				elseif not w.substance then
					p [[Вы наполняете лампу пустотой. Ну то есть, ничем вы ее не наполняете. Да.]];
				end

				if s.is_filled then
					p [[Кстати, лампа и так полная.]];
				end

			
			end
			
			return true;
		elseif w.nam == 'hummer' then
			p [[Лампа еще пригодится.]];
		end

		return false;
	end;
};

folder = obj {
	nam = 'folder',
	disp = "Папка",
	tak = [[Вы берете папку для бумаг.]],
	inv = [[Папка для бумаги. Точнее, то, что от нее осталось после долгих лет использования. Сущий хлам.]]
};

binding = obj {
	nam = 'binding',
	disp = "Переплет",
	inv = [[Самодельный переплет из ... того, что нашлось под рукой. Неказисто, но практично.]]
};

papers = obj {
	nam = 'papers',
	disp = "Листы бумаги",
	inv = [[Эта бумага как нельзя лучше подойдет для письма.]],
	
	use = function(s, w)
		return papersUsage(s, w);
	end;

	used = function(s, w)
		return papersUsage(s, w);
	end;

};

function papersUsage(s, w)
	if w.nam == 'folder' then
		p [[Это не папка, а смех один. Для хранения бумаги стоит найти что-то более подходящее.]];
		return false;
	elseif w.nam == 'binding' then
		remove(s);
		remove(w);
		take('diary');

		p [[То, что надо. Теперь у вас есть что-то на подобие дневника для записей.]];

		return true;
	end

	return false
end;

-- Transitions

-- Actions

