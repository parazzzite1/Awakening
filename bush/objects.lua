
-- Objects

water = obj {
  is_substance = true,

  nam = 'water',

  disp = 'вода',
};

brook  = obj {
  substance = water;

  nam = 'brook',

  act = [[Чистый родник весело бежит прочь из чащи навстречу солнцу.]],

  used = function(s, w)
    if is_empty_pot(w) then
      p [[Вы зачерпываете банкой воду из ручья]];
      w.substance = s.substance;
      return true;
    end

    return false;
  end
}
