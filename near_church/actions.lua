
-- Actions

look_at_belltower = obj {
  nam = 'look_at_belltower',

  act = function()
    p [[
      Прикрывая ладонью глаза от солнца вы смотрите на самый верх колокольни -
      несколько галок летают над крышей, а на месте колокола, похоже, теперь гнездо.
      ^^Должно быть, оттуда открывается отличный вид.
    ]];

    if not here().obj:srch('to_belltower') then
      here().obj:add('to_belltower');
    end
  end;
}
