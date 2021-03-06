
-- Room

near_church = room {
  is_visited = false;

  nam = 'near_church',

  disp = 'Окрестности церкви',

  decor = function()
    p [[
      TODO: добавить описание локации.
    ]];
  end;

  way = {
    path { 'Вернуться к дому', 'pathway_start'},
  };

  onenter = function(s, w)
    if w.nam == 'bush' then
      p [[Вы идете долго - около часа.]];
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
    p [[Путь назад неблизкий. Сначала нужно закончить здесь все дела.]];
    return false;
  end;
};

-- Transitions
