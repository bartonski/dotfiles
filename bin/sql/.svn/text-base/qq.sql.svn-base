-- VA State

select unique d.description, d.agency from ANSWERS.AGENCY_RESYNC r, SVRMGR.AGENCY_CODE d
where r.agency_code_sid = d.agency_code_sid
and d.site_id =  47000
and d.agency in (  '131' )
and r.last_change_ts > sysdate - 2 
and r.UPDATE_MODE_CD = 'NOUPDRS'
group by d.description, d.agency
order by d.agency
