
-- Objects

require "house.under_bed.objects.lost_letter"

tabletop = obj {
  nam = 'tabletop',

  act = function()
    p [[На столе царит беспорядок.]];

    if not is_player_has_note(lost_letter) then
      p [[Вчера вечером вы оставили здесь письмо. Где оно?]];
    end
  end;
};
