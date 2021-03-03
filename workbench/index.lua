
-- Room

workbench = room {
	nam = 'workbench',

	disp = 'Верстак',

	way = {
		'desk',
		'window',
		'nearBed'
	};

	decor = function(s)
		p [[Перед вами крепкий столярный верстак.]];
		if s.obj:srch('hummer') then
			p [[^^Среди интрументов вы подмечаете {hummer|молоток}.]];
		end

		if s.obj:srch('pot') then
			p [[^^Над верстаком на полке стоит плотно закрытая жестяная {pot|банка}.]];
		end

		if s.obj:empty() then
			p [[Кажется, здесь больше нет ничего интересного.]];
		end
	end;

	obj = {
		'hummer',
		'pot'
	};
};

-- Objects

require "workbench.objects.index"

