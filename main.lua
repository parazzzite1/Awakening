-- $Name:Awakening$

instead_version "3.3.0"

require "dash" -- '--' replace :)
require "para" -- be more "Russian"
require "quotes"

require "ceiling"
require "nearBed"

game.act = 'Не получается.';
game.inv = "Гм.. Не то..";
game.use = 'Не сработает...';

function init()
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

lookAround = obj {
	nam = 'lookAround',
	dsc = "^^{Встать и осмотреться}",
	act = function() 
		p [[Кровать упруго проминается, когда вы встаете. Солнечный свет из окна бьет прямо в лицо.^^Вы заслоняетесь от него ладонью и окидывате взглядом комнату.]];
		me().awoke = true;
		me().gotUpOnce = true;
		me().standing = true;
		walk('nearBed');
	end;
};

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



