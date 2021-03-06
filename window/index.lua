
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
			p [[^^{get_out|Выбраться наружу}]];
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

require "window.transitions"

-- Actions

require "window.actions"
