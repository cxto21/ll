
# Backup Sqlite
##Backup file
function backup_sqlite3(){
  database=$1
  sqlite3 $database .dump > $database.back
}
##Backup folder
function backup_sqlite_directoy(){
	path=${}
	if [[ -F  ]];
		for file in $path; do
			#obtain all sqlite paths
			sqlite_path="full path";
			backup_sqlite $sqlite_path # make parallelism with &
}

## Initialice
# pyS
alias pyS='cat << EOF > .tmp.s.py && python3 .tmp.s.py && rm -rf .tmp.s.py'
# rm dev cache
## python
alias pyRmCache='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf'

#--rmc--
function REMOVE_PYTHON_CACHE(){
  find . |\
    grep -E "(__pycache__|\.pyc|\.pyo$)"|\
    xargs rm -rf
}
