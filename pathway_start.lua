
-- Room

pathway_start = room {
  nam = 'pathway_start',

  disp = 'Начало пути',

  decor = function()
    p [[
      Вы стоите в самом начале долгого пути к приключениям.
      ^^Они скоро будут, но пока на этом все=)
      ^^Но можeт пока вернуться в дом - вдруг там что-то осталось?
      ^^{go_inside|Забраться в дом}
    ]];
  end;

  obj = {
    'go_inside',
  }
};

-- Transitions

go_inside = obj {
  nam = 'go_inside',

  act = function(s)
    p [[Вы забираетесь в дом через окно.]];
    walk('window');
  end;
};
