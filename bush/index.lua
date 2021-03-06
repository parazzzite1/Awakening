
-- Room

bush = room {
  is_visited = false,

  nam = 'bush',

  disp = 'Чаща',

  way = {
    'pathway_start',
  };

  decor = function(s)
    p [[
      Вокруг царит полумрак. Кое-где солнечные лучи пробиваются через кустарник.
      ^В душном воздухе медленно плывет осенняя листва.
      ^^Прямо перед вами тропинку пересекает небольшой {brook|ручей}.
      ^^{look_forward|Посмотреть вперед}
    ]]

    if s.obj:srch('to_the_church') then
      p [[^^{to_the_church|Дойти до конца тропы}]];
    end
  end;

  obj = {
    'brook',
    'look_forward',
  };

  onenter = function(s)
    if not s.is_visited then
      p [[
        Вы немного пригибаетесь и углубляетесь в чащу.
        Пройдя около сотни метров, вы решаете осмотреться и обдумать дальнейшие шаги.
      ]]
    end

    s.is_visited = true;
  end;
}

-- Objects

require "bush.objects"

-- Actions

look_forward = obj {
  nam = 'look_forward',

  act = function()
    p [[
      Где-то в далеке тропа выныривает из зарослей.
      ^^До туда еще идти и идти.
    ]];

    if not here().obj:srch('to_the_church') then
      here().obj:add('to_the_church');
    end
  end
};

-- Transitions

require "near_church.index"

to_the_church = obj {
  nam = 'to_the_church',

  act = function()
    p [[ Примерно через час вы доходите до конца тропы.]];

    local pt = inv():srch('pot');
    if pt and is_pot_with_water(pt) then
      erase_pot(pt);
      p [[Вода, которую вы взяли с собой, спасает от жажды.]];
    else
      me().is_thirsty = true;
      p [[Вас мучает жажда.]];
    end

    walk('near_church');
  end;
}
