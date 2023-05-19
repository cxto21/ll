#/bin/bash
echo “Enter dir”
read dir

cd $dir

for i in $(find $dir -type f);
do
    md5sum $i
done;
