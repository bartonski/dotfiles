-- okalfalfaja
select o.oid, n.fname, n.lname, o.custody_status_cd, o.custody_detail_cd
from stdvine.offender o, stdvine.name n
where
        o.site_id=37000
        and n.site_id = o.site_id
        and o.agency=2
        and n.agency = o.agency
        and n.linkage_sid = o.offender_sid
        -- and o.oid in ( ) 
