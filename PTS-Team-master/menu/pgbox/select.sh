#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

mainstart1() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Box Apps Interface Selection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  PTS Box installs a series of Core and Community applications!

[1] PTS          : Core
[2] PTS          : Community
--------------------------------
[3] Apps         : Personal Forks
[4] Apps         : Removal
[5] Apps         : Auto Update

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  # Standby
  read -p '↘️  Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1) bash /opt/plexguide/menu/pgbox/core/core.sh ;;
  2) bash /opt/plexguide/menu/pgbox/community/community.sh ;;
  3) bash /opt/plexguide/menu/pgbox/personal/personal.sh ;;
  4) bash /opt/plexguide/menu/pgbox/remove/removal.sh ;;
  5) bash /opt/plexguide/menu/pgbox/customparts/autobackup.sh ;;
  z) exit ;;
  Z) exit ;;
  esac
}
