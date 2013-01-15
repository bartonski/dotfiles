--select changenumber, agencyname, sitename, subject, priority, description, risk
select
	priority,
	changenumber,
	sitename,
	agencyname,
	subject,
	status,
	SCHEDULEDSTARTDATE,
	SCHEDULEDENDDATE
from fusion.change
where
	owner='bchittenden'
	and status != 'closed'
	and status != 'cancelled'
	and status != 'duplicate'
order by changenumber
