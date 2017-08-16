# dovecot-expunge-cpanel
Shell script to remove old emails in the boxes: trash, spam and drafts.

# Usage:
It is recommended to use cronjob to run this script once a day

Example: 0 0 * * * /path/to/dovecot_expunge.sh /dev/null 2>&1
