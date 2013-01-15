SELECT createddatetime, status, owner, parent, parentnumber, subject, tasktype, sitename, agencyname, category
 FROM FUSION.task t
WHERE t.status = 'Closed'
--   AND c.category <> 'Implementation'
--   AND c.subcategory not in ('Booking System', 'Court System', 'Sex Offender System')
  AND
  t.lastmoddatetime >= to_date('02012011','MMDDYYYY')
  AND t.lastmoddatetime < to_date('02182011','MMDDYYYY')
  AND t.ownerteam like 'PSG Interface Eng%'
  and t.tasktype <> 'Approval'
--   and t.owner not in ('jwaddle','jhoward','chashem')
 and t.owner = 'mlin'
order by parent, parentnumber, createddatetime
