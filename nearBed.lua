require "ceiling" 
require "nearWindow"

-- Room

nearBed = room {
	nam = 'nearBed',
	disp = 'Около кровати',
	obj = { 
		'chair',
		'lieOnBed',
		'lookAtCeiling'
	};
	way = {
		'nearWindow'
	};
	exit = function(s,t)
		if me().dressed or t.nam == 'main' or t.nam == 'ceiling' then
			return true;
		else
			return [[Сначала неплохо бы одеться.]], false;
		end
	end;
};

-- Transitions

lookAround = obj {
	nam = 'lookAround',
	dsc = "^^{Встать и осмотреться}",
	act = function() 
		p [[Вы встаете с кровати. Солнечный свет из окна бьет прямо в лицо.]];
		me().awoke = true;
		me().gotUpOnce = true;
		me().standing = true;
		walk('nearBed');
	end;
};

-- Objects

chair = obj {
	nam = 'chair',
	dsc = "Недалеко от себя вы видите {стул}.",
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
	dsc = "На стуле висит {одежда}.",
	tak = "Вы взяли одежду.",
	inv = function(s)
		if me().dressed then
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
			w.obj:add(s, 1);
			
			return true;
		else
			return false;
		end;
	end;
};

