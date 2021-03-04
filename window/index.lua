
-- Room

window = room {
	nam = 'window',
	disp = 'Окно',

	decor = function(s)
		if s.obj:srch('transition_window_view') then
			p [[
				Из окна открывается {transition_window_view|вид} на дальние луга и холмы.
			]];
		end

		if s.obj:srch('latch') then
			if latch.is_locked then
				p [[{latch|Шпингалет} опущен.]];
			else
				p [[{latch|Шпингалет} поднят.]];
			end
		end

		if s.obj:srch('investigate_frame') then
			p [[^^{investigate_frame|Изучить окно}]];
		end

		if s.obj:srch('open_close_frame') then
			if frame.is_shut then
				p [[^^{open_close_frame|Открыть окно}]];
			else
				p [[^^{open_close_frame|Закрыть окно}]];
			end
		end

		if s.obj:srch('get_out') then
			p [[^^{get_out|Перелезть через окно}]];
		end

	end;

	obj = {
		'transition_window_view',
		'investigate_frame',
	};

	onenter = function(s,f)
		if f.nam ~= 'window_view' and f.nam ~= 'pathway_start' then
			p [[Вы подходите к окну.]];
		end
	end;

	way = {
		'near_bed',
		'desk',
		'workbench'
	};
};

-- Objects

require "window.objects"

-- Transitions

require "window_view"
require "pathway_start"

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
			p [[Вы выбираетесь через окно на улицу.]];
			walk('pathway_start');
		else
			p [[
				Прежде чем идти дальше, нужно обзавестить чем-то вроде блокнота для записей.
			]];
		end
	end;
};

-- Actions

require "window.actions"
