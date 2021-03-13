
-- Room

near_church = room {
  is_visited = false;

  nam = 'near_church',

  disp = 'Окрестности церкви',

  decor = function()
    p [[
      Прямо перед вами возвышается старая {look_at_belltower|колокольня},
      а немного поодаль расположились руины каких-то строений.
    ]];
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

  onexit = function(s)
    p [[Путь назад неблизкий. Сначала нужно закончить все дела здесь.]];
    return false;
  end;
};

-- Objects

require 'near_church.objects'

-- Transitions
