
-- Utils

function pot_extra_inv_msg(s)
	if s.substance.nam == 'kerosene' then
		return " Теперь мы можем зажечь.";
	end

	return '';
end;

function is_pot(s)
	return s.nam == 'pot';
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
