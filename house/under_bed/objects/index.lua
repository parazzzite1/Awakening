
-- Objects

require "house.under_bed.objects.lost_letter"

twinkles = obj {
	nam = 'twinkles',

	act = function(s)
		p [[
			Вы тянете руку к огонькам и слышите тихий писк и шуршание.
			Видимо где-то в стене под кроватью поселилась мышь.
		]];

		s:remove();
	end;
};
