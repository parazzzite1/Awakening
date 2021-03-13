
-- Utils

function pot_extra_inv_msg(s)
	if s.substance.nam == 'kerosene' then
		return " Теперь мы можем зажечь.";
	end

	return '';
end;

function is_pot(s)
	return s and s.nam == 'pot';
end;

function is_investigated_pot(s)
	return is_pot(s) and s.is_investigated;
end;

function is_misterious_pot(s)
	return is_pot(s) and not s.is_investigated;
end;

function is_empty_pot(s)
	return is_pot(s) and not s.substance;
end;

function is_investigated_empty_pot(s)
  return s.is_investigated and is_empty_pot(s);
end;

function is_misterious_pot_with_something(s)
	return is_misterious_pot(s) and s.substance;
end;

function is_investigated_pot_with_something(s)
	return is_investigated_pot(s) and s.substance;
end;

function is_pot_with_kerosene(s)
	return is_investigated_pot_with_something(s) and s.substance.nam == 'kerosene';
end;

function is_pot_with_water(s)
	return is_investigated_pot_with_something(s) and s.substance.nam == 'water';
end;

function get_substance(s)
	if s.is_substance then
		return s;
	end

	if s.substance then
		return s.substance;
	end
end;

function erase_pot(s)
	s.substance = nil;
end;
