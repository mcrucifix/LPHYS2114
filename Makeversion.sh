git rev-parse --short HEAD       | awk '{print "\\newcommand{\\gitrevision}{"$1"}"}'     > Version.tex 
git rev-parse --abbrev-ref HEAD  | awk '{print "\\newcommand{\\gitbranch}{"$1"}"}'      >> Version.tex 
#git describe --dirty=-dev        | awk '{print "\\newcommand{\\gitversion}{"$1"}"}'     >> Version.tex
git  log -1 --format="%cd"       | awk '{print "\\newcommand{\\gitdate}{"$0"}"}'     >> Version.tex

