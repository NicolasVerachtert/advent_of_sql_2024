select sl.id
from sleigh_locations sl
join areas a on ST_DWithin(a.polygon, sl.coordinate, 0)