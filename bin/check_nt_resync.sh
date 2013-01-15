#! /bin/sh

# Takes a resync file and runs the following tests:
# (All tests should succeed)
# 
# Multiple charges per booking?
# Custody status IC for all offenders?
# Custody status date empty for all offenders?
# UPDATE_DATE BOOK_DATE ARREST_DATE OFFENSE_DATE RELEASE_DATE SCH_REL_DATE CREATION_DATE CLASSIFICATION_DATE are all 8-digit or 8 spaces
# UPTIME_TIME BOOK_TIME ARREST_TIME OFFENSE_TIME RELEASE_TIME SCH_REL_TIME CREATION_TIME CLASSIFICATION_TIME are all 4-digit or 4 spaces


syncfile="${1}"

# Helper function, formats 'start,length' as
# 'start-end'. This may be used to define ranges
# for cut.
range () 
{ 
    start=$(echo $1 | cut -d ',' -f1);
    len=$(echo $1 | cut -d ',' -f2);
    end=$(echo "$start + $len - 1" | bc);
    echo "$start-$end"
}

# Given 'start', 'length', 'regex', 'label' and 'type'
# Greps all 'OR' records in $syncfile, cuts the field
# specified by 'start' and 'length' then uses egrep
# to exclude 'regex'. If none of the lines match,
# print the message "All $label $type correct".
# (e.g. "All UPDATE_DATE dates correct" )
checkformat() {
    start=${1}   # start position in characters
    len=${2}     # length in characters
    regex="${3}" # regex used to test date or time
    label=${4}   # literal 'dates' or 'times'
    type=${5}    # literal 'dates' or 'times'
    grep '^OR' $syncfile | cut -c $(range $start,$len) | egrep -v "$regex" || printf " All %s %s correct\n" $label $type
}

echo Multiple charges per booking?
grep '^CH' $syncfile | cut -c $(range 66,25) | sort | uniq -c

echo Custody status IC for all offenders?
grep '^OR' $syncfile | cut -c $(range 311,25) | sort | uniq -c

echo Custody status date empty for all offenders?
grep '^OR' $syncfile | cut -c $(range 361,8) | sort | uniq -c


# Check formatting of dates and times

#           col len regex             label               type
# ===========================================================
checkformat 4   8   '[0-9]{8}|[ ]{8}' UPDATE_DATE         dates
checkformat 91  8   '[0-9]{8}|[ ]{8}' BOOK_DATE           dates
checkformat 287 8   '[0-9]{8}|[ ]{8}' ARREST_DATE         dates
checkformat 299 8   '[0-9]{8}|[ ]{8}' OFFENSE_DATE        dates
checkformat 361 8   '[0-9]{8}|[ ]{8}' RELEASE_DATE        dates
checkformat 431 8   '[0-9]{8}|[ ]{8}' SCH_REL_DATE        dates
checkformat 711 8   '[0-9]{8}|[ ]{8}' CREATION_DATE       dates
checkformat 783 8   '[0-9]{8}|[ ]{8}' CLASSIFICATION_DATE dates

checkformat 12  4   '[0-9]{4}|[ ]{4}' UPDATE_TIME         times
checkformat 99  4   '[0-9]{4}|[ ]{4}' BOOK_TIME           times
checkformat 295 4   '[0-9]{4}|[ ]{4}' ARREST_TIME         times
checkformat 307 4   '[0-9]{4}|[ ]{4}' OFFENSE_TIME        times
checkformat 369 4   '[0-9]{4}|[ ]{4}' RELEASE_TIME        times
checkformat 439 4   '[0-9]{4}|[ ]{4}' SCH_REL_TIME        times
checkformat 719 4   '[0-9]{4}|[ ]{4}' CREATION_TIME       times
checkformat 791 4   '[0-9]{4}|[ ]{4}' CLASSIFICATION_TIME times

