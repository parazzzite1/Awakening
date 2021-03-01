
-- Room

desk = room {
	nam = 'desk',
	disp = "Письменный стол",
	way = {
		'nearBed',
		'window'
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
			p [[Больше в ящике нет ничего интересного.]];
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
	inv = "Скрепки для бумаги. Ими можно скреплять не только бумагу.",
	use = function(s, w)
		if w.nam == 'papers' then
			p [[Действительно, почему бы не скрепить скрепками для бумаги бумагу? Но может быть попытаться использовать их как-то иначе?]];
			return false;
		elseif w.nam == 'folder' then
			p [[С помощью скрепок вам удается превратить старую папку в что-то на подобие книжного преплета.]];
			remove(s);
			remove(w);
			take('binding');
			return true;
		end
		
		return false;
	end;
};

lamp = obj {
	nam = 'lamp',

	filled = false,
	on = false,

	tak = "Вы взяли керасиновую лампу.",

	disp = function(s)
		if s.on then
			return "Лампа (горит)"
		else
			return "Лампа (не горит)"
		end
	end;


	inv = function(s)
		if not lamp.filled then
			p [["... и врут календaри ..." В лампе нет керасина. Надо наполнить ее, пережде чем использовать.]];
		else
			if not s.on then
				p [[Вы включаете лампу и из нее тут же начинает струиться теплый свет.]];
				s.on = true;
			else
				p [[Вы выключаете лампу.]];
				s.on = false;
			end
		end
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
		p [[То, что надо. Теперь у вас есть что-то на подобие дневника для записей.]];
		remove(s);
		remove(w);
		take('diary');
		return true;
	end

	return false
end;

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
		return noteLookingUsage(s,w);
	end;
};

function noteLookingUsage(s, w)
	if w.noteLooking and not noteInDiary(w, s) then
		remove(w);
		table.insert(s.notes, w);
		if s.state then
			s.obj:add(w);
		end

		return true;
	end
	return false;
end

function noteInDiary(n, d)
	for i, note in ipairs(d.notes) do
		if note == n then
			return true;
		end
	end

	return false;
end

-- Transitions

-- Actions

