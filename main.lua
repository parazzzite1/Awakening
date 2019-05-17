-- $Name:Awakening$

instead_version "3.3.0"

require "dash" -- '--' replace :)
require "para" -- be more "Russian"
require "quotes"

require "ceiling"
require "nearBed"

-- Game Init

function init()
	game.act = 'Не получается.';
	game.inv = "Гм.. Не то..";
	game.use = 'Не сработает...';


	game.player = {
		nam = 'player',
		room = main,
		awoke = false,
		gotUpOnce = false,
		standing = false,
		dressed = false,
		nudist = false
	};
end;

-- Room

main = room {
	nam = 'main',
	disp = "Кровать",
	dsc = function()
		if me().awoke ~= true then
			p [[Вы чувствуете что проснулись. Голова немного гудит. Открыв глаза вы видите знакомый белый потолок.]];
		elseif me().gotUpOnce ~= true then
			p [[Вы проснулись и лежите на кровати. Что дальше?]];
		else 
			p [[Вы лежите на кровати. Что дальше?]];
		end
	end;
	obj = { 
		'lookAtCeiling',
		'lookAround'
	};
};

-- Transitions

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

