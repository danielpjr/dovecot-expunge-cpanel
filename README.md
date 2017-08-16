# Dovecot expunge cPanel
Shell script to remove old emails in the boxes: trash, spam and drafts.

# Usage:
It is recommended to use cronjob to run this script once a day

Example: 0 0 * * * /path/to/dovecot_expunge.sh /dev/null 2>&1

# Danger!
The use of the script and its consequences are of the user's interest.

It is not possible to guarantee the perfect functioning of the script in unknown hosts.

It is recommended to debug and test the script before running it in the production environment.
