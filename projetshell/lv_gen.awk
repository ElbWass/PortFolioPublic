#! /bin/awk -f

BEGIN {
	RS=":";
}

{
	if( NR==1)
	{
		_Y=(150/2)-$1;
		_X=(41-$2)/2;
	}
	else
	{
		print "\033["NR+_X";"_Y"H"$0;
	}

}
