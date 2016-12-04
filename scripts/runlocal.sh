cd $1/src
rm $1/neko/Main.n
haxe -main Main -neko $1/neko/Main.n
neko $1/neko/Main.n