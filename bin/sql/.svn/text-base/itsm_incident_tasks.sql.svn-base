select priority
       , 'I:'
       , parentnumber
       , sitename
       , agencyname
       , subject
       , status
       , to_char(targetdatetime, 'YYYY-MM-DD')
from fusion.task
where owner='bchittenden'
	and parentlink_category='incident'
	and status != 'closed'
