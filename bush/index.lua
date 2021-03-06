
-- Room

bush = room {
  is_visited = false,

  nam = 'bush',

  disp = 'Чаща',

  way = {
    'pathway_start',
  };

  decor = function()
    p [[
      Вокруг царит полумрак. Кое-где солнечные лучи пробиваются через кустарник.
      ^В душном воздухе медленно плывет осенняя листва.
      ^^Прямо перед вами тропинку пересекает небольшой {brook|ручей}.
      ^^{look_forward|Посмотреть вперед}
    ]]
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
  end
};
