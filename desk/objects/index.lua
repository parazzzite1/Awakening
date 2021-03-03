
-- Objects

require "desk.objects.lamp"

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

