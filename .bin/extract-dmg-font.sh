TMP=$(mktemp -d)
mkdir font
7z e "$1" -o"$TMP" -bd -y &> /dev/null
7z e $TMP/"*.pkg" -o"$TMP" -bd -y &> /dev/null
find $TMP -name "Payload" -exec 7z e {} -bd -y &> /dev/null
7z e $TMP/Payload -o"$TMP" -bd -y  &> /dev/null
7z e $TMP/Payload~ -ofont -bd -y &> /dev/null
rm -rf $TMP &> /dev/null
