#!/bin/bash
#
# Title:      PTS major file
# org.Author(s):  Admin9705 - Deiteq
# Mod from MrDoob for PTS
# GNU:        General Public License v3.0
################################################################################

start0() {
sudocheck
mainstart
cleartabs  1>/dev/null 2>&1
info 
alias  1>/dev/null 2>&1
owned  1>/dev/null 2>&1
replaceui
check
}

sudocheck() {
  if [[ $EUID -ne 0 ]]; then
    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  You Must Execute as a SUDO USER (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    exit 0
  fi
}

mainstart() {
  file="/opt/ptsupdate/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
    sleep .5
    if [ -e "$file" ]; then waitvar=1; fi
  done
   ansible-playbook /opt/ptsupdate/autoupdate/version/choice.yml 1>/dev/null 2>&1
}

cleartabs() {
truncate -s 0 /var/plexguide/logs/*
}

info() {
printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Please wait one moment, while PTS now checks and set everything up for you!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
'
}
########end funtions // execute commands
alias() {
  ansible-playbook /opt/plexguide/menu/alias/alias.yml 1>/dev/null 2>&1
}
replaceui() {
pgui=$(docker ps --format '{{.Names}}' | grep "pgui")
upper=$(docker ps --format '{{.Names}}' | grep "uploader")
pas=$(systemctl list-unit-files | grep plex_autoscan.service | awk '{ print $2 }')

if [[ "$pgui" == "pgui" && "$upper" == "uploader" ]]; then
  cp -r /opt/plexguide/menu/pgui/templates/index.php /opt/appdata/pgui/index.php && docker restart pgui && sudo service mountcheck restart
fi
if [[ "$pgui" == "pgui" && "$upper" != "uploader" ]]; then
cp -r /opt/plexguide/menu/pgui/templates/oldui.php /opt/appdata/pgui/index.php && docker restart pgui && sudo service mountcheck restart
fi
if [[ "$pgui" == "pgui" && "$upper" != "uploader" && "$pas" == "enabled" ]]; then
cp -r /opt/plexguide/menu/pgui/templates/autoscan-index.php /opt/appdata/pgui/index.php && docker restart pgui && sudo service mountcheck restart
fi
}

owned() {
  chown -cR 1000:1000 /opt/plexguide
  chmod -R 775 /opt/plexguide
}

check() {
file="/opt/plexguide/menu/pg.yml"
  if [[ -f $file ]]; then
  printf '
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅      All files Valid and > PTS is up to date <
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
' 
  printf '
✅ All files Valid and > PTS is up to date <
' >>/var/plexguide/logs/pg.log
 else ansible-playbook /opt/plexguide/menu/version/missing_pull.yml; fi
}
