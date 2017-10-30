#!/bin/bash
# Simple little script to automate the packaging+uploading of
# DOMCal data.  Hopefully, just simple enough to get the job done.
# IR 20140526
#
# Updated 20140717 to add emailing functionality IR

if (($# != 1))
then
  echo "Expected syntax is 'domcalUpload.sh section', where section is the"
  echo "section of the detector where the DOMCal was run on, eg icetop"
  exit
fi

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMPDIR="/tmp"

# Keep the trailing /, please
uploadDir="$SCRIPTDIR/../dropbox/"

calSection=$1
resultsDir="$SCRIPTDIR/../results/"
domcalOrigDir="domcal"
domcalName="domcal-`date +%Y%m%d`-$calSection-unvetted"

SENDMAIL=/usr/sbin/sendmail
email_recipients=blaufuss@icecube.umd.edu,john.kelley@icecube.wisc.edu,mkauer@icecube.wisc.edu,pnakarmi@crimson.ua.edu,icecube@icecube.usap.gov

if [ -e $resultsDir$domcalOrigDir ]
then
  if [ -e $resultsDir$domcalName* ]
  then
    echo "Files related to $domcalName exist already, not doing anything"
  else
    mv $resultsDir$domcalOrigDir $resultsDir$domcalName
    tar cf $resultsDir$domcalName.dat.tar -C $resultsDir $domcalName
    cp $resultsDir$domcalName.dat.tar $uploadDir
    echo "DOMCal data /$domcalName" > $uploadDir$domcalName.sem
    echo "Waiting for SPADE/JADE to pick up $domcalName..."
    while [ -e $uploadDir$domcalName.dat.tar -o -e $uploadDir$domcalName.sem ]
    do
      echo "Still waiting"
      sleep 10
    done
    echo "JADE picked up the DOMCal files."
    echo "Emailing folks to let them know."
    temp_email_file=tempemailfile`date '+%Y%m%d%H%M%S'`.txt
    temp_email_file="${TMPDIR}/${temp_email_file}"
    echo "Subject: $domcalName uploaded via SPADE" > $temp_email_file
    echo "" >> $temp_email_file
    echo "This is an automated message, email the winterovers at icecube@icecube.usap.gov with any questions" >> $temp_email_file
    cat $temp_email_file | $SENDMAIL $email_recipients
    rm $temp_email_file

  fi
else
  echo "Didn't find a $domcalOrigDir directory, so didn't do anything"
fi
