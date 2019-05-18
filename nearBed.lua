require "ceiling" 
require "window"

-- Room

nearBed = room {
	nam = 'nearBed',
	disp = 'Около кровати',

	decor = function(s)
		p [[Недалеко от себя вы видите {chair|стул}.]];
		if chair.obj:srch('clothes') then
			p [[На стуле висит {clothes|одежда}.]];
		end

		p [[^^{lieOnBed|Лечь на кровать}]];
		p [[^^{lookAtCeiling|Осмотреть потолок}]];

	end;

	obj = { 
		'chair',
		'lieOnBed',
		'lookAtCeiling'
	};

	way = {
		'window'
	};

	onexit = function(s,t)
		if me().dressed or t.nam == 'main' or t.nam == 'ceiling' then
			return true;
		else
			return [[Сначала неплохо бы одеться.]], false;
		end
	end;
};

-- Transitions

lieOnBed = obj {
	nam = 'lieOnBed',
	
	act = function()
		p [[И снова под одеяло.]];
		if me().dressed then
			p [[В одежде - ну и ладно.]]
		end;

		me().standing = false;
		
		walk('main');
	end;	
};

-- Objects

chair = obj {
	nam = 'chair',

	act = function()
		p [[Стул как стул. Если не считать того, что он очень крепок и явно старше вас.]]
	end;

	obj = {
		'clothes'
	};
};

clothes = obj {
	nam = 'clothes',

	wearing = false,

	disp = function(s)
		if s.wearing then
			return "Одежда (надето)"
		else
			return "Одежда"
		end
	end;
	
	tak = "Вы взяли одежду.",

	inv = function(s)
		local currentRoom = here();
		if s.wearing and currentRoom.nam ~= 'nearBed' and currentRoom.nam ~= 'main' then
			p "Лучше не стоит.";
			return false;
		end

		if s.wearing then
			p "Вы разделись.";
			me().dressed = false;
			s.wearing = false;
		else
			p "Вы оделись.";
			me().dressed = true;
			s.wearing = true;
		end

		if me().standing ~= true then
			p [[Вы делали это лежа, так что пришлось повозиться.]];
		end;
	end;

	use = function(s,w)
		if w.nam == 'chair' then
			drop(s);
			
			if me().dressed and s.wearing then
				me().dressed = false;
				s.wearing = false;

				p [[Вы сняли одежду и повесили ее на стул.]];
			else
				s.wearing = false;

				p [[Вы повесили одежду на стул.]];
			end

			remove(s);
			w.obj:add(s);
			
			return true;
		else
			return false;
		end;
	end;
};

