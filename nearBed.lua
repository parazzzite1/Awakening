require "ceiling" 
require "nearWindow"

nearBed = room {
	nam = 'nearBed',
	disp = 'Около кровати',
	onexit = function(s,f)
		if me().dressed then
			return false
		else
			return true
		end;
	end;
	obj = { 
		'chair',
		'lieOnBed',
		'lookAtCeiling'
	};
	way = {
		'nearWindow'
	};
};

lieOnBed = obj {
	nam = 'lieOnBed',
	dsc = "^^{Лечь на кровать}",
	act = function()
		p [[И снова под одеяло.]];
		if me().dressed then
			p [[В одежде - ну и ладно.]]
		end;
		me().standing = false;
		walk('main');
	end;	
};

chair = obj {
	nam = 'chair',
	dsc = "Недалеко от себя вы видите {стул}.",
	act = function()
		p [[Стул как стул. Если не считать того, что он достался вам от родителей и, должно быть, сильно старше вас.]]
	end;
	obj = {
		'clothes'
	};
};

clothes = obj {
	nam = 'clothes',
	disp = "Одежда",
	dsc = "На стуле лежит {одежда}",
	tak = "Вы взяли одежду",
	inv = function(s)
		if me().standing then
			p "Вы оделись.";
		else
			p "Лежа одеваться не очень удобно, но вы справились.";
		end;
		me().dressed = true;
		s:remove();
	end;
};

