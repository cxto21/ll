function resetXDev(){
	id=$1; xinput disable $id && xinput enable $id;
}