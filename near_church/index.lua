
-- Room

near_church = room {
  is_visited = false;

  nam = 'near_church',

  disp = 'Окрестности церкви',

  decor = function(s)
    p [[
      Прямо перед вами возвышается старая {look_at_belltower|колокольня},
      а немного поодаль расположились руины каких-то строений.
    ]];

    if s.obj:srch('to_belltower') then
      p [[^^{to_belltower|Подняться на колокольню}]];
    end
  end;

  way = {
    path { 'Вернуться к дому', 'pathway_start'},
  };

  obj = {
    'look_at_belltower',
  };

  onenter = function(s, w)
    if w.nam == 'bush' and not s.is_visited then
      p [[Спустя час вы выбираетесь из леса. ]];
      if me().is_thirsty then
        p [[Вас начинает мучить жажда.]];
      else
        p [[Вода, которую вы взяли с собой, спасает от жажды.]];
      end
    end

    if not s.is_visited then
      s.is_visited = true;
      local d = inv():srch('diary');
      if d then
        add_new_record(d, dr_old_church);
      end
    end
  end;

  onexit = function(s, w)
    if w.nam == 'pathway_start' then
      p [[Путь назад неблизкий. Сначала нужно закончить все дела здесь.]];
      return false;
    end;

    return true;
  end;
};

-- Objects

require 'near_church.actions'

-- Transitions

require 'near_church.transitions'
