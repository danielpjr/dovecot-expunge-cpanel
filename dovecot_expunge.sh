#!/bin/bash

# It is recommended to use cronjob to run this script once a day
# Example: 0 0 * * * /path/to/dovecot_expunge.sh /dev/null 2>&1

# Looping in e-mail directories in cPanel accounts

for path in /home/*/mail/*; do
		[ -d "${path}" ] || continue
		domain="$(basename "${path}")"
		[[ $domain == *"."* ]] || continue
		for accountpath in "${path}"/*; do
			[ -d "${accountpath}" ] || continue
			account="$(basename "${accountpath}")"
			
			# Remove Trash, Junk and Spam emails as long as you are in these boxes more than 60 days
			
			/usr/bin/doveadm expunge mailbox INBOX.Trash -u "${account}"@"${domain}" savedbefore 60d
			/usr/bin/doveadm expunge mailbox INBOX.Junk -u "${account}"@"${domain}" savedbefore 60d
			/usr/bin/doveadm expunge mailbox INBOX.spam -u "${account}"@"${domain}" savedbefore 60d
			
			# Remove emails in Sent and Draft as long as you are in these boxes more than 180 days
			
			/usr/bin/doveadm expunge mailbox INBOX.Sent -u "${account}"@"${domain}" savedbefore 180d
			/usr/bin/doveadm expunge mailbox INBOX.Drafts -u "${account}"@"${domain}" savedbefore 180d
			
		done
	done

	# Remove emails that are sent to 'accounts' that do not exist in the domain and ...
	# are stored in the account: '{account}@nameserver.principal_domain.tdl' occupying space
	
	for path in /home/*; do
		[ -d "${path}/mail/cur" ] || continue
		qtd="$(/bin/ls -l "${path}"/mail/cur | wc -l)"
		if [ $qtd -gt 1 ]; then
			find "${path}"/mail/cur -type f -exec rm {} \;
		fi
	done
