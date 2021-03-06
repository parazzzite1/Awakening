
-- Room

pathway_start = room {
  nam = 'pathway_start',

  disp = 'Начало пути',

  decor = function()
    p [[
      Слева и справа от окна живой стеной растут молодые клены.
      ^^Немного впереди вы замечаете начало узкой тропы,
      идущей немного под уклон в самую чащу.
      ^^{go_inside|Забраться в дом}
    ]];
  end;

  obj = {
    'go_inside',
  }
};

-- Actions

-- Transitions

go_inside = obj {
  nam = 'go_inside',

  act = function(s)
    p [[Вы забираетесь в дом через окно.]];
    walk('window');
  end;
};
