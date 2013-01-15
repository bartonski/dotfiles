select priority
       , parentnumber
       , sitename
       , agencyname
       , subject
       , status
       , to_char(targetdatetime, 'YYYY-MM-DD')
from fusion.task
where owner='bchittenden'
	and parentlink_category='change'
	and status != 'closed'
