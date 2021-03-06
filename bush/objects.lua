
-- Objects

water = obj {
  is_substance = true,

  nam = 'water',

  disp = 'вода',
};

brook  = obj {
  substance = water;

  nam = 'brook',

  act = [[Чистый родник весело бежит прочь из чащи навстречу солнцу. Вода бы вам пригодилась.]],

  used = function(s, w)
    if is_empty_pot(w) then
      p [[Вы наполняете банку чистой водой из ручья.]];
      w.substance = s.substance;
      return true;
    end

    return false;
  end
}
