
-- Objects

require "desk.objects.folder"
require "desk.objects.binding"

papers = obj {
	nam = 'papers',
	disp = "Листы бумаги",
	inv = [[Эта бумага как нельзя лучше подойдет для письма.]],

	use = function(s, w)
		return papers_usage(s, w);
	end;

	used = function(s, w)
		return papers_usage(s, w);
	end;
};

-- Utils

function papers_usage(s, w)
	if w.nam == 'folder' then
		p [[Это не папка, а смех один. Для хранения бумаг стоит найти что-то более подходящее.]];
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