
-- Room

pathway_start = room {
  nam = 'pathway_start',

  disp = 'Начало пути',

  decor = function()
    p [[
      Слева и справа от окна живой стеной растут молодые клены.
      ^^Немного впереди вы замечаете начало узкой {trail|тропы},
      идущей немного под уклон в самую чащу.
      ^^{go_inside|Забраться в дом}
      ^^{go_forward|Идти вперед}
    ]];
  end;

  obj = {
    'trail',
    'go_inside',
    'go_forward',
  }
};

-- Objects

require "pathway_start.objects.trail"

-- Actions

-- Transitions

require "bush.index"

go_inside = obj {
  nam = 'go_inside',

  act = function(s)
    p [[Вы забираетесь в дом через окно.]];
    walk('window');
  end;
};

go_forward = obj {
  nam = 'go_forward',

  act = function(s)
    walk('bush');

    if not pathway_start.way:srch('bush') then
      pathway_start.way:add('bush', 0);
    end

  end;
}
