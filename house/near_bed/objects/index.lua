
-- Objects

chair = obj {
	nam = 'chair',

	act = function()
		p [[
			Стул как стул.
			Если не считать того, что он очень крепок и явно старше вас.
		]]
	end;

	obj = {
		'clothes'
	};
};

require "house.near_bed.objects.clothes"
