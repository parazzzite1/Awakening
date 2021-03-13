
-- Objects

require "house.desk.objects.drawer.papers"
require "house.desk.objects.drawer.clips"

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
