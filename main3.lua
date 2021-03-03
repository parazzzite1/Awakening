-- $Name:Awakening$
-- $Version:0.0.1$

require "fmt"

fmt.dash = true
fmt.quotes = true

-- Game Init

game.act = 'Не получается.';
game.inv = "Гм.. Не то..";
game.use = 'Не сработает...';

game.player = player {
	nam = 'player',
	room = 'main',
	is_awoken = false,
	is_got_up_once = false,
	is_standing = false,
	is_dressed = false,
	nudist = false
};

-- Room

main = room {
	nam = 'main';
	disp = "Кровать";

	dsc = function()
		if not me().is_awoken then
			p [[Вы чувствуете что проснулись. Голова немного гудит. Открыв глаза вы видите знакомый белый потолок.]];
		elseif me().is_got_up_once ~= true then
			p [[Вы проснулись и лежите на кровати. Что дальше?]];
		else
			p [[Вы лежите на кровати. Что дальше?]];
		end
	end;

	decor = function(s)
		p [[{look_at_ceiling|Осмотреть потолок}]];
		p [[^^{look_around|Встать и осмотреться}]];
	end;

	obj = {
		'look_at_ceiling',
		'look_around'
	};
};

-- Transitions

require "ceiling.index"
require "near_bed.index"

look_around = obj {
	nam = 'look_around',

	act = function()
		p [[Вы встаете с кровати. Солнечный свет из окна бьет прямо в лицо.]];

		me().is_awoken = true;
		me().is_got_up_once = true;
		me().is_standing = true;

		walk('near_bed');
	end;
};
