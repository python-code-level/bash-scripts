#!/bin/bash

# this script creates three back up exports of the current local repo 
# under trunk, system and research directories
# does not include full history of commits etc

# usage
# svn export URLorPATH localPATH

DATE=$(date +%Y-%m-%d)
echo "$DATE"

COPYBASE=/code-repo-export
ZIPS=/code-repo-export/zips

REPOURL=http://xxxxxxxxxxxxxxxxxxxx/trunk
REPOCOPY=$COPYBASE/$DATE-trunk

SYSURL=http://xxxxxxxxxxxxxxxxxxxx/trunk/system
SYSCOPY=$COPYBASE/$DATE-system

RESURL=http://xxxxxxxxxxxxxxxxxxxx/trunk/research
RESCOPY=$COPYBASE/$DATE-research

# get current revision number from svn url 
REV=$(svn info $REPOURL -r 'HEAD' | grep Revision | egrep -o "[0-9]+")

echo "R$REV"
echo "---"

svn export $REPOURL $REPOCOPY
svn export $SYSURL $SYSCOPY
svn export $RESURL $RESCOPY

zip -r $ZIPS/R${REV}_${DATE}_trunk.zip $REPOCOPY/
zip -r $ZIPS/R${REV}_${DATE}_sys.zip $SYSCOPY/
zip -r $ZIPS/R${REV}_${DATE}_res.zip $RESCOPY/

# size check commented out as too slow
#cd $REPOCOPY
# add check size of repo directory
#DIRSIZE=$(du -sh)

echo "Source repo trunk = $REPOURL"
echo "Source repo system= $SYSURL"
echo "Source repo research= $RESURL"

echo ""

echo "Destination trunk = $REPOCOPY"
echo "Destination system = $SYSCOPY"
echo "Destination research = $RESCOPY"

#echo "Export repo size = $DIRSIZE"
   
