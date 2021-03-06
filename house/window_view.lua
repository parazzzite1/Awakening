
-- Room

window_view = room {
	nam = 'window_view',
	disp = 'Вид из окна',
	dsc = [[Из окна открывается вид на дальние луга и холмы.]],

	obj = {
		'forest',
		'church'
	};

	way = { 'window' };
};

-- Objects

forest = obj {
	nam = 'forest',
	dsc = [[Один из холмов окоймляет {лес}.]],

	act = function(s)
		p [[Отсюда вы можете разглядеть, что часть деревьев уже "в багрец и золото" одета.]];
	end;
};

church = obj {
	nam = 'church',
	dsc = [[Над лесом возвышается {церковная колокольня}.]],

	act = function(s)
		p [[Церковь находится довольно далеко. Кажется, она заброшена.]];
	end;
};
