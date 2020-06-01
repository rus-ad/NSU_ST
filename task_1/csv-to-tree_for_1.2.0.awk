#!/usr/bin/env gawk

BEGIN {
	
	FS=","
	nodes=""
	edges=""
	
	print "digraph G {\n\trankdir=BT;"
	print "\tedge [arrowhead=diamond];"
	
}
/^[\s\t]*$/ {
	next
}
{
	
	nodes=nodes"\n\tn"$3" [label="$2"];";
	if($3 != $1)edges=edges"\n\tn"$3" -> n"$1";";
	
}
END {

	print nodes;
	print edges;
	print "\n}"
	
}
