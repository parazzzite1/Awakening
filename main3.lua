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
	awoke = false,
	gotUpOnce = false,
	standing = false,
	dressed = false,
	nudist = false	
};

-- Room

main = room {
	nam = 'main';
	disp = "Кровать";

	dsc = function()
		if me().awoke ~= true then
			p [[Вы чувствуете что проснулись. Голова немного гудит. Открыв глаза вы видите знакомый белый потолок.]];
		elseif me().gotUpOnce ~= true then
			p [[Вы проснулись и лежите на кровати. Что дальше?]];
		else 
			p [[Вы лежите на кровати. Что дальше?]];
		end
	end;

	decor = function(s)
		p [[{lookAtCeiling|Осмотреть потолок}]];
		p [[^^{lookAround|Встать и осмотреться}]];
	end;

	obj = { 
		'lookAtCeiling',
		'lookAround'
	};
};

-- Transitions

require "ceiling.index"
require "nearBed.index"

lookAround = obj {
	nam = 'lookAround',
	
	act = function() 
		p [[Вы встаете с кровати. Солнечный свет из окна бьет прямо в лицо.]];

		me().awoke = true;
		me().gotUpOnce = true;
		me().standing = true;
		
		walk('nearBed');
	end;
};


