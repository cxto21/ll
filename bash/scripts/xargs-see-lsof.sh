
# List files opened by a process
echo "Enter program name"
read program
array=$(ps -A | awk -v program="$program" '$0 ~ program {print $1}');
echo $array | tr ' ' '\n' | xargs -I process lsof -p process 
# echo $array | xargs -I % lsof -p % > $%
# -p: enable confirmation that waits (y) to proceed
# -I %: enable % as wilcard
