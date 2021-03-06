
-- Objects

dr_old_church  = obj {
  is_read = false;

  nam = 'dr_old_church',

  disp = function(s)
    local d = "\"Старая церковь\"";
    if not s.is_read then
      return fmt.b(d);
    end

    return d;
  end;

  inv = function(s)
    s.is_read = true;
    p [[
      "TODO: запись про церковь: лор + сюжет"
    ]];
  end;
}
