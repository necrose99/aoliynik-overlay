#!/bin/awk

BEGIN       {
                skipLines = 1
				print "#!/bin/sh"
				print "#"
				print "# Wonder Shaper\n"
            }

/^if \[/    { skipLines = 0 }

            { if (!skipLines) print $0 }
