#! /bin/bash

set -x
filename="$1"
tablename="$2"

sql=".mode csv
.import '$filename' '$tablename'
"

sqlite3 "${tablename}.db" <<< "$sql"
