
-- Objects

require "desk.objects.binding"

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
