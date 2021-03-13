
-- Transitions

require "house.window_view"
require "pathway_start.index"

transition_window_view = obj {
	nam = 'transition_window_view',

	act = function(s)
		walk('window_view');
	end;
};

get_out = obj {
	nam = 'get_out',

	act = function(s)
		if inv():srch('diary') then
			p [[Вы перелезаете через подоконник и оказываетесь на улице.]];
			walk('pathway_start');
		else
			p [[
				Прежде чем идти дальше, нужно обзавестить чем-то вроде блокнота для записей.
			]];
		end
	end;
};
