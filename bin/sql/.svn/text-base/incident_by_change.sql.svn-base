select c.changenumber, i.incidentnumber
from
      fusion.change c
      , fusion.fusionlink l
      , fusion.incident i
where c.changenumber=11359
  and c.recid = l.sourceid
  and i.recid = l.targetid
order by c.changenumber

