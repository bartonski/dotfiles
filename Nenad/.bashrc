##########################################
#### Customized .bashrc | Nenad Bozic ####
##########################################

# TODO  Get custom commands fixed on Prep and Prod - some don't work.
# TODO  Get "--group-directories-first" ls option to work on Prep and Prod
# TODO  Add visual and audible bell on standard error.
# TODO  Use zipgrep instead of current way of searching zip files?
# TODO  Create a new function - activity - that will show the oldest and newest file, recursively

# Binutils
# Coreutils
# Diffutils
# Findutils
# Fontutils
# IDutils
# INetUtils
# Mailutils
# PaxUtils
# PlotUtils
# Recutils
# Sharutils
# Sysutils
# Termutils
# src-highlite

# Fileutils, Shellutils, and Textutils

# ?????:
test -s ~/.alias && . ~/.alias || true

#-------------------
# Environment Config
#-------------------

if [ "$APPRISS_ENV" == "local" ]; then
	# Local:
	export APPRISS_ENV_LOCAL=true

	export PS1="\n\[\e[0;32m\]____________________________________________________________________________________________________\[\e[0m\]\n\[\e[1;90;42m\]| \[\e[0m\]\[\e[1;97;42m\]\w\[\e[0m\]\[\e[1;90;42m\] @ \h (\u) \[\e[0m\]\[\e[1;90;42m\]\n| => \[\e[0m\] "
	export PS2="\n\[\e[1;90;103m\]| => \[\e[0m\] "

	alias rm='rm'
	alias cp='cp'
	alias mv='mv'

	export LS_OPTIONS="--color=auto --indicator-style=slash --group-directories-first --time-style=long-iso"
	export LS_OPTIONS_GROUPING_OVERRIDE="--color=auto --indicator-style=slash --time-style=long-iso"

else
	# Remote:
	export APPRISS_ENV_LOCAL=false

	if [ "$APPRISS_ENV" == "prep" ]; then
		# Prep:
		export PS1="\n\e[0;34m____________________________________________________________________________________________________\e[0m\n\e[0;36;44m| \e[0m\e[1;33;44m\w\e[0m\e[0;36;44m @ \h (\u) \e[0m\e[0;36;44m\n| PREP | => \e[0m "
		export PS2="\n\e[0;36;103m| => \e[0m "
		alias rm='rm -i'
		alias cp='cp -i'
		alias mv='mv -i'

	else
		# PROD:
		export PS1="\n\e[0;31m____________________________________________________________________________________________________\e[0m\n\e[0;30;41m| \e[0m\e[1;33;41m\w\e[0m\e[0;30;41m @ \h (\u) \e[0m\e[0;30;41m\n| PROD | => \e[0m "
		export PS2="\n\e[0;30;103m| => \e[0m "
		alias rm='rm -i'
		alias cp='cp -i'
		alias mv='mv -i'

	fi

	export LS_OPTIONS="--color=auto --indicator-style=slash --time-style=long-iso"
	export LS_OPTIONS_GROUPING_OVERRIDE="--color=auto --indicator-style=slash --time-style=long-iso"

fi

# Dir Colors File - configures the LS_COLORS env variable:
eval `dircolors ~/.dir_colors`
# Separately configure the "others writable" directory colors:
export LS_COLORS="${LS_COLORS}ow=01;37;40"


#-------------------
# Overrides, Global
#-------------------

alias ls="ls $LS_OPTIONS "

alias l="ls $LS_OPTIONS -lAtr"
alias lr="ls $LS_OPTIONS -lAt"

alias lsm="ls $LS_OPTIONS -lAtr"
alias lsmr="ls $LS_OPTIONS -lAt"

alias lsa="ls $LS_OPTIONS -lAtr"
alias lsar="ls $LS_OPTIONS -lAt"

alias lsc="ls $LS_OPTIONS -lAcr"
alias lscr="ls $LS_OPTIONS -lct"

alias lsn="ls $LS_OPTIONS -lA"
alias lsnr="ls $LS_OPTIONS -lAr"

alias lss="ls $LS_OPTIONS -lASr"
alias lssr="ls $LS_OPTIONS -lAS"

alias lsr="ls $LS_OPTIONS -lAtrR"
alias lsrr="ls $LS_OPTIONS -lAtR"

cd ()
	{
		command cd "${1}"
		l
	}
alias ..='cd ..'
alias ...='cd ../../'


#-------------------
# Variables, Global
#-------------------

t="$(echo ~/temp/)"
temp="$(echo ~/temp/)"

prep_server='prepaftpproc01.prep.appriss.com'
prod_server='prodaftpproc01.prod.appriss.com'
prod_server2='prodaftpproc02.prod.appriss.com'

ftp_prep_server='prepftp01.prep.appriss.com'
ftp_prod_server='prodftp01.prod.appriss.com'
ftp_prod_server2='prodftp02.prod.appriss.com'


#-------------------
# Variables, Env.
#-------------------

if $APPRISS_ENV_LOCAL ; then
	# Local

	perl_lib="/opt/local/lib/perl5/5.12.3/darwin-multi-2level/"

	sup="/Users/nbozic/Documents/Interfaces/supplies/"
	i="${APPRISS_ENV_HOME}"
	ii="/Users/nbozic/Documents/archived_interfaces/"

	stuff="/Users/nbozic/Documents/Stuff/"
	documents="/Users/nbozic/Documents/"
	downloads="/Users/nbozic/Downloads/"

	sup_preproclinux="/Users/nbozic/Documents/Interfaces/supplies/mac_local/preproc"

	sup_doc="/Users/nbozic/Documents/Interfaces/supplies/svn/doc/"
	sup_reform="/Users/nbozic/Documents/Interfaces/supplies/svn/reform_INI/source/"
	sup_photos="/Users/nbozic/Documents/Interfaces/supplies/svn/photo_Extraction/"
	sup_split="/Users/nbozic/Documents/Interfaces/supplies/svn/interface_Split/"
	sup_directftp="/Users/nbozic/Documents/Interfaces/supplies/svn/interface_Direct_FTP/"
	sup_gateway_jail="/Users/nbozic/Documents/Interfaces/supplies/svn/interface_Gateway_PC/jail/"
	sup_gateway_court="/Users/nbozic/Documents/Interfaces/supplies/svn/interface_Gateway_PC/court/"

	#------------------------------------------------------------------------------

	vabrunswick="${APPRISS_ENV_HOME}/VABrunswick/project/working/"
	svabrunswick="${APPRISS_ENV_HOME}/VABrunswick/project/source/"

	txdallas="${APPRISS_ENV_HOME}/DallasTX/project/working/"
	stxdallas="${APPRISS_ENV_HOME}/DallasTX/project/source/"

	mimontcalm="${APPRISS_ENV_HOME}/MIMontcalm/working/"
	smimontcalm="${APPRISS_ENV_HOME}/MIMontcalm/source/"

	ingibson="${APPRISS_ENV_HOME}/INGibson/working/"
	singibson="${APPRISS_ENV_HOME}/INGibson/source/"

	mdmontgomeryja="${APPRISS_ENV_HOME}/MDMontgomery/working/"
	smdmontgomeryja="${APPRISS_ENV_HOME}/MDMontgomery/source/"

	waasotinja="${APPRISS_ENV_HOME}/WAAsotin/working/"
	swaasotinja="${APPRISS_ENV_HOME}/WAAsotin/source/"

	wakittitasja="${APPRISS_ENV_HOME}/WAKittitas/working/"
	swakittitasja="${APPRISS_ENV_HOME}/WAKittitas/source/"

	ndmckenzieja="${APPRISS_ENV_HOME}/NDMcKenzie/working/"
	sndmckenzieja="${APPRISS_ENV_HOME}/NDMcKenzie/source/"

	latangipahoaja="${APPRISS_ENV_HOME}/latangipahoaja/working/"
	slatangipahoaja="${APPRISS_ENV_HOME}/latangipahoaja/source/"

	flpascoja="${APPRISS_ENV_HOME}/flpascoja/working/"
	sflpascoja="${APPRISS_ENV_HOME}/flpascoja/source/"

else
	# Remote:

	perl_lib="/usr/lib/perl5/"

	ftplog='/var/log/vsftpd.log'

	logs_process="${APPRISS_ENV_HOME}/core/services/ftp01/logs/"

	logs_importstandard="${APPRISS_ENV_HOME}/core/services/jvd01/logs/"
	logs_importerror="${APPRISS_ENV_HOME}/core/services/jvd01/logs/error/"
	import_tempfiles="${APPRISS_ENV_HOME}/core/services/jvd01/"

	#------------------------------------------------------------------------------

	vabrunswick="${APPRISS_ENV_HOME}/project/vine/va/vastate/vabrunswickja/ftphome/"
	dvabrunswick="/srv/ftp/homedirs/va/b/vabrunswickja/"

	txdallas="${APPRISS_ENV_HOME}/project/vine/tx/txstate/txdallas/ftphome/"
	dtxdallas="/srv/ftp/homedirs/tx/d/txdallas/"

	mimontcalm="${APPRISS_ENV_HOME}/project/vine/mi/mistate/mimontcalmja/ftphome/"
	dmimontcalm="/srv/ftp/homedirs/mi/m/mimontcalmja/"

	ingibson="${APPRISS_ENV_HOME}/project/vine/in/instate/ingibsonja/ftphome/"
	dingibson="/srv/ftp/homedirs/in/g/ingibsonja/"

	latangipahoaja="${APPRISS_ENV_HOME}/project/vine/la/lastate/latangipahoaja/ftphome/"
	dlatangipahoaja="/srv/ftp/homedirs/la/t/latangipahoaja/"

	mdmontgomeryja="${APPRISS_ENV_HOME}/project/vine/md/mdstate/mdmontgomeryja/ftphome/"
	dmdmontgomeryja="/srv/ftp/homedirs/md/m/mdmontgomeryja/"

	waasotinja="${APPRISS_ENV_HOME}/project/vine/wa/wastate/waasotinja/ftphome/"
	dwaasotinja="/srv/ftp/homedirs/wa/a/waasotinja/"

	wakittitasja="${APPRISS_ENV_HOME}/project/vine/wa/wastate/wakittitasja/ftphome/"
	dwakittitasja="/srv/ftp/homedirs/wa/k/wakittitasja/"

	ndmckenzieja="${APPRISS_ENV_HOME}/project/vine/nd/ndstate/ndmckenzieja/ftphome/"
	dndmckenzieja="/srv/ftp/homedirs/nd/m/ndmckenzieja/"

	flpascoja="${APPRISS_ENV_HOME}/project/vine/fl/flstate/flpascoja/ftphome/"
	dflpascoja="/srv/ftp/homedirs/fl/p/flpascoja/"

fi


#-------------------
# Aliases, Global
#-------------------

alias t="cd ${t}"
alias temp="cd ${temp}"
alias where='title "Current Location";pwd'

alias c="separator; cat ${1}"
alias o="open"

# Spacer
alias sep='echo;echo;echo; for t in {1..4}; do echo -e "\033[0;43;33m ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- \033[0m"; done; echo;echo'


#-------------------
# Aliases, Env.
#-------------------

# Remote Access:

if $APPRISS_ENV_LOCAL ; then
	# Local
	alias prep="ssh nbozic@${prep_server}"
	alias prod="ssh nbozic@${prod_server}"
	alias prod2="ssh nbozic@${prod_server2}"

	alias ftpprep="ssh nbozic@${ftp_prep_server}"
	alias ftpprod1="ssh nbozic@${ftp_prod_server}"
	alias ftpprod2="ssh nbozic@${ftp_prod_server2}"
fi


# Shortcuts:

if $APPRISS_ENV_LOCAL ; then
	#--------------------------------------------------------------------------------
	# Local
	#--------------------------------------------------------------------------------

	alias perl_lib="cd /opt/local/lib/perl5/5.12.3/darwin-multi-2level/"

	alias sup="command cd /Users/nbozic/Documents/Interfaces/supplies/; ls $LS_OPTIONS -l"
	alias i="command cd ${APPRISS_ENV_HOME}; ls $LS_OPTIONS -l"
	alias ii="command cd /Users/nbozic/Documents/archived_interfaces/; ls $LS_OPTIONS -l"

	alias stuff="cd /Users/nbozic/Documents/Stuff/"
	alias documents="cd /Users/nbozic/Documents/"
	alias downloads="cd /Users/nbozic/Downloads/"

	alias sup_preproclinux="cd /Users/nbozic/Documents/Interfaces/supplies/mac_local/"

	alias sup_doc="cd /Users/nbozic/Documents/Interfaces/supplies/svn/doc/"
	alias sup_reform="cd /Users/nbozic/Documents/Interfaces/supplies/svn/reform_INI/source/"
	alias sup_photos="cd /Users/nbozic/Documents/Interfaces/supplies/svn/photo_Extraction/"
	alias sup_split="cd /Users/nbozic/Documents/Interfaces/supplies/svn/interface_Split/"
	alias sup_directftp="cd /Users/nbozic/Documents/Interfaces/supplies/svn/interface_Direct_FTP/"
	alias sup_gateway_jail="cd /Users/nbozic/Documents/Interfaces/supplies/svn/interface_Gateway_PC/jail/"
	alias sup_gateway_court="cd /Users/nbozic/Documents/Interfaces/supplies/svn/interface_Gateway_PC/court/"

	#------------------------------------------------------------------------------

	alias vabrunswick="cd ${APPRISS_ENV_HOME}/VABrunswick/project/working/"
	alias svabrunswick="cd ${APPRISS_ENV_HOME}/VABrunswick/project/source/"

	alias txdallas="cd ${APPRISS_ENV_HOME}/DallasTX/project/working/"
	alias stxdallas="cd ${APPRISS_ENV_HOME}/DallasTX/project/source/"

	alias mimontcalm="cd ${APPRISS_ENV_HOME}/MIMontcalm/working/"
	alias smimontcalm="cd ${APPRISS_ENV_HOME}/MIMontcalm/source/"

	alias ingibson="cd ${APPRISS_ENV_HOME}/INGibson/working/"
	alias singibson="cd ${APPRISS_ENV_HOME}/INGibson/source/"

	alias mdmontgomeryja="cd ${APPRISS_ENV_HOME}/MDMontgomery/working/"
	alias smdmontgomeryja="cd ${APPRISS_ENV_HOME}/MDMontgomery/source/"

	alias waasotinja="cd ${APPRISS_ENV_HOME}/WAAsotin/working/"
	alias swaasotinja="cd ${APPRISS_ENV_HOME}/WAAsotin/source/"

	alias wakittitasja="cd ${APPRISS_ENV_HOME}/WAKittitas/working/"
	alias swakittitasja="cd ${APPRISS_ENV_HOME}/WAKittitas/source/"

	alias ndmckenzieja="cd ${APPRISS_ENV_HOME}/NDMcKenzie/working/"
	alias sndmckenzieja="cd ${APPRISS_ENV_HOME}/NDMcKenzie/source/"

	alias latangipahoaja="cd ${APPRISS_ENV_HOME}/latangipahoaja/working/"
	alias slatangipahoaja="cd ${APPRISS_ENV_HOME}/latangipahoaja/source/"
	
	alias flpascoja="cd ${APPRISS_ENV_HOME}/flpascoja/working/"
	alias sflpascoja="cd ${APPRISS_ENV_HOME}/flpascoja/source/"

	#--------------------------------------------------------------------------------

else
	#--------------------------------------------------------------------------------
	# Remote
	#--------------------------------------------------------------------------------

	alias e='exit'

	#--------------------------------------------------------------------------------

	alias perl_lib="cd /usr/lib/perl5/"

	alias logs_process="cd ${APPRISS_ENV_HOME}/core/services/ftp01/logs/"

	alias logs_importstandard="cd ${APPRISS_ENV_HOME}/core/services/jvd01/logs/"
	alias logs_importerror=" cd ${APPRISS_ENV_HOME}/core/services/jvd01/logs/error/"
	alias import_tempfiles="cd ${APPRISS_ENV_HOME}/core/services/jvd01/"

	#------------------------------------------------------------------------------

	alias vabrunswick="cd ${APPRISS_ENV_HOME}/project/vine/va/vastate/vabrunswickja/ftphome/"
	alias dvabrunswick="cd /srv/ftp/homedirs/va/b/vabrunswickja/"

	alias txdallas="cd ${APPRISS_ENV_HOME}/project/vine/tx/txstate/txdallas/ftphome/"
	alias dtxdallas="cd /srv/ftp/homedirs/tx/d/txdallas/"

	alias mimontcalm="cd ${APPRISS_ENV_HOME}/project/vine/mi/mistate/mimontcalmja/ftphome/"
	alias dmimontcalm="cd /srv/ftp/homedirs/mi/m/mimontcalmja/"

	alias ingibson="cd ${APPRISS_ENV_HOME}/project/vine/in/instate/ingibsonja/ftphome/"
	alias dingibson="cd /srv/ftp/homedirs/in/g/ingibsonja/"

	alias latangipahoaja="cd ${APPRISS_ENV_HOME}/project/vine/la/lastate/latangipahoaja/ftphome/"
	alias dlatangipahoaja="cd /srv/ftp/homedirs/la/t/latangipahoaja/"

	alias mdmontgomeryja="cd ${APPRISS_ENV_HOME}/project/vine/md/mdstate/mdmontgomeryja/ftphome/"
	alias dmdmontgomeryja="cd /srv/ftp/homedirs/md/m/mdmontgomeryja/"

	alias waasotinja="cd ${APPRISS_ENV_HOME}/project/vine/wa/wastate/waasotinja/ftphome/"
	alias dwaasotinja="cd /srv/ftp/homedirs/wa/a/waasotinja/"

	alias wakittitasja="cd ${APPRISS_ENV_HOME}/project/vine/wa/wastate/wakittitasja/ftphome/"
	alias dwakittitasja="cd /srv/ftp/homedirs/wa/k/wakittitasja/"

	alias ndmckenzieja="cd ${APPRISS_ENV_HOME}/project/vine/nd/ndstate/ndmckenzieja/ftphome/"
	alias dndmckenzieja="cd /srv/ftp/homedirs/nd/m/ndmckenzieja/"

	alias flpascoja="cd ${APPRISS_ENV_HOME}/project/vine/fl/flstate/flpascoja/ftphome/"
	alias dflpascoja="cd /srv/ftp/homedirs/fl/p/flpascoja/"

	#--------------------------------------------------------------------------------

fi

# local and remote project shortcuts...
alias 1="mimontcalm"
alias 2="ingibson"
alias 3="vabrunswick"
alias 4="txdallas"


#--------------------------------------------------------------------------------
# Functions, Direct (intended for user)
#--------------------------------------------------------------------------------

title ()
	{
		# Barton's echo command that's formatted as a title...
		# echo $@ | perl -ne 'chomp; print "\n" . "=" x length($_); print "\n$_\n"; print "=" x length($_) . "\n" '
		echo '------------------------------------------------------------------------------------------'
		echo -e "      | \033[0;30;47m ${1} \033[0m"
		echo '------------------------------------------------------------------------------------------'
	}

separator ()
	{
		# Simple separator
		echo -e "\033[0;37m--------------------------------------------------------------------------------\033[0m"
	}

bashrc_sync ()
	{
		if $APPRISS_ENV_LOCAL ; then
			separator
			echo "Copying local '.bashrc' to Prep..."
			scp -q /Users/nbozic/.bashrc nbozic@${prep_server}:~/
			echo "Copying local '.dir_colors' to Prep..."
			scp -q /Users/nbozic/.dir_colors nbozic@${prep_server}:~/

			separator
			echo "Copying local '.bashrc' to Production 1..."
			scp -q /Users/nbozic/.bashrc nbozic@${prod_server}:~/
			echo "Copying local '.dir_colors' to Production 1..."
			scp -q /Users/nbozic/.dir_colors nbozic@${prod_server}:~/

			separator
			echo "Copying local '.bashrc' to Production 2..."
			scp -q /Users/nbozic/.bashrc nbozic@${prod_server2}:~/
			echo "Copying local '.dir_colors' to Production 2..."
			scp -q /Users/nbozic/.dir_colors nbozic@${prod_server2}:~/

			separator
			echo "Copying local '.bashrc' to Prep FTP..."
			scp -q /Users/nbozic/.bashrc nbozic@${ftp_prep_server}:~/
			echo "Copying local '.dir_colors' to Prep FTP..."
			scp -q /Users/nbozic/.dir_colors nbozic@${ftp_prep_server}:~/

			separator
			echo "Copying local '.bashrc' to Production FTP 1..."
			scp -q /Users/nbozic/.bashrc nbozic@${ftp_prod_server}:~/
			echo "Copying local '.dir_colors' to Production FTP 1..."
			scp -q /Users/nbozic/.dir_colors nbozic@${ftp_prod_server}:~/

			separator
			echo "Copying local '.bashrc' to Production FTP 2..."
			scp -q /Users/nbozic/.bashrc nbozic@${ftp_prod_server2}:~/
			echo "Copying local '.dir_colors' to Production FTP 2..."
			scp -q /Users/nbozic/.dir_colors nbozic@${ftp_prod_server2}:~/

			separator
		else
			do_display_disabled_message
		fi
	}

f ()
	{
		title 'Find Files and Directories (case Insensitive) (Recursive)'

		local searchPattern=$(echo $1);

		find . -path "*/.svn" -prune -o -iname \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

f0 ()
	{
		title 'Find Files and Directories (case Insensitive) (No Sub Dirs)'

		local searchPattern=$(echo $1);

		find . -maxdepth 1 -path "*/.svn" -prune -o -iname \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

fcase ()
	{
		title 'Find Files and Directories (Case-Sensitive) (Recursive)'

		local searchPattern=$(echo $1);

		find . -path "*/.svn" -prune -o -name \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

fc0 ()
	{
		title 'Find Files and Directories (Case-Sensitive) (No Sub Dirs)'

		local searchPattern=$(echo $1);

		find . -maxdepth 1 -path "*/.svn" -prune -o -name \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

ff ()
	{
		title 'Find Files Only (case Insensitive) (Recursive)'

		local searchPattern=$(echo $1);

		find . -path "*/.svn" -prune -o -type f -iname \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

ffc ()
	{
		title 'Find Files Only (Case-Sensitive) (Recursive)'

		local searchPattern=$(echo $1);

		find . -path "*/.svn" -prune -o -type f -name \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

fd ()
	{
		title 'Find Directories Only (case Insensitive) (Recursive)'

		local searchPattern=$(echo $1);

		find . -path "*/.svn" -prune -o -type d -iname \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

fdc ()
	{
		title 'Find Directories Only (Case-Sensitive) (Recursive)'

		local searchPattern=$(echo $1);

		find . -path "*/.svn" -prune -o -type d -name \*${searchPattern}\* -print0 | xargs -0 -n 1 | sed "s/[ ]/\\\ /g"

		separator
	}

prep_import_log ()
	{
		local searchPattern=$1;
		local logPath=$(echo '/prepfsnr/prep/core/services/jvd01/logs/');
		local logFile=$(date '+%Y%m%d.log');

		title 'Searching Import Logs on Prep (case Insensitive)'
		echo "      Searching for '$searchPattern'..."
		echo "      File: '${logPath}${logFile}'"
		separator

		ssh $prep_server  egrep -i -n $searchPattern "$logPath$logFile" | egrep -i $searchPattern --color='auto'

		separator
	}

s ()
	{
		title 'Search File Contents (case Insensitive) (Recursive) (No Binary)'
		echo "   File name or ext is optional. Use single quotes for Regex."
		separator

		local searchPattern=$1;
		local fileExtension=$2;

		# if extension is not empty
		if [ "$fileExtension" = '' ]; then
			# no file restriction
			# '-o' option stands for 'OR', which allows for multiple conditions:
			find . -path "*/.svn" -prune -o -print0 | xargs -0 egrep -i -n -I -H "${searchPattern}" --color='auto'
		else
			# file restriction
			find . -path "*/.svn" -prune -o -iname "*$fileExtension" -print0 | xargs -0 egrep -i -n -I -H "${searchPattern}" --color='auto'
		fi

		separator
	}

s0 ()
	{
		title 'Search File Contents (case Insensitive) (No Sub Dirs) (No Binary)'
		echo "   File name or ext is optional. Use single quotes for Regex."
		separator

		local searchPattern=$1;
		local fileExtension=$2;

		# if extension is not empty
		if [ "$fileExtension" = '' ]; then
			# no file restriction
			# '-o' option stands for 'OR', which allows for multiple conditions:
			find . -maxdepth 1 -path "*/.svn" -prune -o -print0 | xargs -0 egrep -i -n -I -H "${searchPattern}" --color='auto'
		else
			# file restriction
			find . -maxdepth 1 -path "*/.svn" -prune -o -iname "*$fileExtension" -print0 | xargs -0 egrep -i -n -I -H "${searchPattern}" --color='auto'
		fi

		separator
	}

sc ()
	{
		title 'Search File Contents (Case-Sensitive) (Recursive) (No Binary)'
		echo "   File name or ext is optional. Use single quotes for Regex."
		separator

		local searchPattern=$1;
		local fileExtension=$2;

		# if extension is not empty
		if [ "$fileExtension" = '' ]; then
			# no file restriction
			# '-o' option stands for 'OR', which allows for multiple conditions:
			find . -path "*/.svn" -prune -o -print0 | xargs -0 egrep -n -I -H "${searchPattern}" --color='auto'
		else
			# file restriction
			find . -path "*/.svn" -prune -o -iname "*$fileExtension" -print0 | xargs -0 egrep -n -I -H "${searchPattern}" --color='auto'
		fi

		separator
	}

sc0 ()
	{
		title 'Search File Contents (Case-Sensitive) (No Sub Dirs) (No Binary)'
		echo "   File name or ext is optional. Use single quotes for Regex."
		separator

		local searchPattern=$1;
		local fileExtension=$2;

		# if extension is not empty
		if [ "$fileExtension" = '' ]; then
			# no file restriction
			# '-o' option stands for 'OR', which allows for multiple conditions:
			find . -maxdepth 1 -path "*/.svn" -prune -o -print0 | xargs -0 egrep -n -I -H "${searchPattern}" --color='auto'
		else
			# file restriction
			find . -maxdepth 1 -path "*/.svn" -prune -o -iname "*$fileExtension" -print0 | xargs -0 egrep -n -I -H "${searchPattern}" --color='auto'
		fi

		separator
	}

sg ()
	{
		title 'Search GZip Contents (case Insensitive) (Recursive) (.gz ext)'
		echo "   No quotes needed for single words. Use single quotes for Regex."
		separator

		local searchPattern=$1;

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for i in $(  find . -iname \*.gz | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"  );
			do
				zgrep --color='always' -i -n -H "${searchPattern}" $i;
			done ;

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

sgc ()
	{
		title 'Search GZip Contents (Case-Sensitive) (Recursive) (.gz ext)'
		echo "   No quotes needed for single words. Use single quotes for Regex."
		separator

		local searchPattern=$1;

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for i in $(  find . -iname \*.gz | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"  );
			do
				zgrep --color='always' -n -H "${searchPattern}" $i;
			done ;

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

stg ()
	{
		title 'Search TAR & GZip Contents (case Insensitive) (Recursive) (.tar.gz ext)'
		echo "   No quotes needed for single words. Use single quotes for Regex."
		separator

		local searchPattern=$(echo $1);

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for t in $(  find . -iname \*.tar.gz | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"  );
			do
				echo; echo "   ======== $t  ===================";
				for i in $(tar ztf $t);
					do
						echo '        ______________________________';
						echo "        $i";
						tar zxf $t -O $i | zcat;
					done | egrep --color='auto' -i "(^[ ]{8}_.*_\$)|(\.gz\$)|(${searchPattern})"; echo;
			done

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

stgc ()
	{
		title 'Search TAR & GZip Contents (Case-Sensitive) (Recursive) (.tar.gz ext)'
		echo "   No quotes needed for single words. Use single quotes for Regex."
		separator

		local searchPattern=$(echo $1);

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for t in $(  find . -iname \*.tar.gz | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"  );
			do
				echo; echo "   ======== $t  ===================";
				for i in $(tar ztf $t);
					do
						echo '        ______________________________';
						echo "        $i";
						tar zxf $t -O $i | zcat;
					done | egrep --color='auto' "(^[ ]{8}_.*_\$)|(\.gz\$)|(${searchPattern})"; echo;
			done

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

sz ()
	{
		title 'Search Zip Contents (case Insensitive) (Recursive) (No Binary) (.zip ext)'
		echo "   No quotes needed for single words. Use single quotes for Regex."
		separator

		local searchPattern=$(echo $1);
		echo

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for i in $(  find . -iname \*.zip | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"  );
			do
				echo "    ======= $i  ===============";
				unzip -ca $i | egrep --color='auto' -i -I "${searchPattern}";
				echo;
			done

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

szc ()
	{
		title 'Search Zip Contents (Case-Sensitive) (Recursive) (No Binary) (.zip ext)'
		echo "   No quotes needed for single words. Use single quotes for Regex."
		separator

		local searchPattern=$(echo $1);
		echo

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for i in $(  find . -iname \*.zip | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"  );
			do
				echo "    ======= $i  ===============";
				unzip -ca $i | egrep --color='auto' -I "${searchPattern}";
				echo;
			done

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

#--------------------------------------------------------------------------------

preproc_checks ()
	{
		title 'Preproc and Reform File Checks'

		local configFile=$1;

		preproc -v | head -n 1

		separator
		echo "Preproc Location: $(which preproc)"

		if [ "$configFile" = '' ]; then
			# no config file specified
			echo "Config File - trying default: reform.ini"
			separator
			echo
			preproc -c -o -f reform.ini
		else
			echo "Config File: ${configFile}"
			separator
			echo
			preproc -c -o -f ${configFile}
		fi

		echo
		separator
	}

file_rectypes ()
	{
		local fileWithRecs=$1;

		title 'Display SDL Rec Type Counts in a File'
		echo "   File: '${1}'"
		echo "   Examiming the first 3 characters of each line..."
		separator

		cat "${1}" | cut -c 1-3 | sort | uniq -c

		separator
	}

iv ()
	{
		# Display files that can considered to be part of an interface deploy

		title 'Interface VINE (Recursive)'

		do_search_i_vine | uniq

		separator
	}

ij ()
	{
		# Display files that can be considered interface leftovers...
		# Use logic where only files that are not of specific type will be displayed

		title 'Interface Junk (Recursive)'

		do_search_i_junk | uniq

		separator
	}

il ()
	{
		title 'Display Recent Interface Logs'

		local perlLogs=$( find . -iname *.log | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g" | xargs ls -lat | head -n 3 | tr -s " " | cut -d " " -f 9 )

		echo "   Log: ${perlLogs}"
		separator

		echo "${perlLogs}" | xargs -n 1 cat | egrep --color='auto' -i -n -H '[ ]|(warn|severe|fatal|ERROR)'

		separator
	}

#--------------------------------------------------------------------------------

ic ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Cleanup of Perl Interface'

			find . -iname '*.prc' -delete
			find . -iname '*.fin' -delete
			find . -iname '*.wrk' -delete
			find . -iname '*.srt' -delete
			find . -iname '*.old' -delete
			find . -iname '*.cmp' -delete
			find . -iname '*.sys' -delete
			find . -iname '*.dat' -delete
			find . -iname '*.txt' -delete
			find . -iname '*.xml' -delete
			find . -iname '*.csv' -delete
			find . -iname '*.bad' -delete
			find . -iname '*.tok' -delete
			find . -iname '*.token' -delete
			find . -iname '*.tracker' -delete
			find . -iname '*.downloaded' -delete
			find . -iname '*_temp' -delete
			find . -iname '*.zip' -delete
			find . -iname '*.tar' -delete
			find . -iname '*.gz' -delete
			find . -type d -iname 'mrgedata' | sed "s/[ ]/\\\ /g" | xargs -n 1 rm -rf
			find . -type d -iname 'log' | sed "s/[ ]/\\\ /g" | xargs -n 1 rm -rf
			find . -iname '*.log' -delete
			find . -type d -iname 'archive' | sed "s/[ ]/\\\ /g" | xargs -n 1 rm -rf
			find . -iname '*.sav' -delete
			find . -iname '*.raw' -delete
			find . -iname '*.sent' -delete
			find . -type d -iname 'send' | sed "s/[ ]/\\\ /g" | xargs -n 1 rm -rf
			find . -type d -iname 'working' | sed "s/[ ]/\\\ /g" | xargs -n 1 rm -rf
			find . -type d -iname 'holding' | sed "s/[ ]/\\\ /g" | xargs -n 1 rm -rf

			separator

			l

		else
			do_display_disabled_message
		fi
	}

ir ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Run Interface, Standard Mode (.prerun, getdata.pl, getdata.rex, getpdata.pl, .webrun)'

			local interfaceFile=$( find . -maxdepth 1 -path "*/.svn" -prune -o -iname .prerun -o -iname getdata.pl -o -iname getdata.rex -o -iname getpdata.pl -o -iname .webrun | sed "s/[ ]/\\\ /g" | head -n 1 )

			if [ "$interfaceFile" == "" ]; then
				echo
				echo -e "  No runnable interface files were found in current directory!\a\a\a\a"
				return;
			fi

			# Must utilize bash in interactive mode when using aliases with xargs
			echo "${interfaceFile}" | xargs -n 1 bash -ic do_run_interface

			find . -iname \*.log | egrep -i '\.log$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g" | xargs -n 1 egrep --color='auto' -i -n -H 'warn|severe|fatal|ERROR'

			separator

			l

		else
			do_display_disabled_message
		fi
	}

irr ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Run Perl Interface, Resync Mode (.prerun or getdata.pl)'

			# Must utilize bash in interactive mode when using aliases with xargs
			find . \(  -iname getdata.pl  -o  -iname .prerun  \) | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g" | xargs -n 1 bash -ic do_run_resync_with_dir_change

		else
			do_display_disabled_message
		fi
	}

#--------------------------------------------------------------------------------

do_get_test_data_trx_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/trx_single/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/trx_single/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}

do_get_test_data_0_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/0/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/0/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_full_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/full/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/full/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_1_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/1/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/1/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_2_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/2/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/2/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_3_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/3/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/3/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_4_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/4/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/4/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_5_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/5/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/5/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}
do_get_test_data_6_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/6/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/6/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}

do_get_test_data_ini_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Interface Test-Data Copy (from "../test_data/ini_single/" to here)'

			# copy test data to parent dir
			cp -r -p ../test_data/ini_single/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}

do_get_test_data_photo_recs ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Photo Test-Data Copy (from "../../test_data/photo_recs/" to here)'

			# copy test data to second-parent dir
			cp -r -p ../../test_data/photo_recs/* ./

			separator

			l

		else
			do_display_disabled_message
		fi
	}

#--------------------------------------------------------------------------------

it ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title '| Test-Run Interface (Batch of Scripts) |'
			echo

			# first... delete all the junk files
			ic
			echo

			# do_get_test_data_trx_recs
			# echo
			# ir

			do_get_test_data_full_recs
			echo
			ir

			# do_get_test_data_0_recs
			# echo
			# ir

			# then... fetch the test data
			# do_get_test_data_trx_recs
			# do_get_test_data_ini_recs

			# finally... run the interface
			# ir

		else
			do_display_disabled_message
		fi
	}

its ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title '| Test-Run Interface (Batch of Scripts) |'
			echo

			# first... delete all the junk files
			ic
			echo

			# then... fetch each test data batch and process
			do_get_test_data_1_recs
			echo
			ir

			do_get_test_data_2_recs
			echo
			ir

			do_get_test_data_3_recs
			echo
			ir

			do_get_test_data_4_recs
			echo
			ir

			do_get_test_data_5_recs
			echo
			ir

			do_get_test_data_6_recs
			echo
			ir

		else
			do_display_disabled_message
		fi
	}

itp ()
	{
		if $APPRISS_ENV_LOCAL ; then

			title 'Test-Run Photos'
			echo

			# first... delete all the junk files
			ic
			echo

			# then... fetch the test data
			do_get_test_data_photo_recs
			echo

			# finally... run the interface
			ir

		else
			do_display_disabled_message
		fi
	}

#--------------------------------------------------------------------------------

file_ref ()
	{
		# References to File: find which other files reference the provided file name

		echo 'ref-to'

		separator
	}

f_ref_none ()
	{
		# No References: find which files are orphans...
		# CAUTION: Resulting files may still be referenced from another directory!

		echo 'ref-none'

		separator
	}

f_files ()
	{
		title "All Files (Recursive)"

		find . -type f | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}

f_nonfiles ()
	{
		title "All Non-Files (Recursive)"

		find . -not -type f | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}

f_older ()
	{
		local minutes=$(echo $1);
		title "Files/Dirs Modified MORE THAN ${minutes} Minutes Ago"

		find . -mmin +${minutes} | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}
f_newer ()
	{
		local minutes=$(echo $1);
		title "Files/Dirs Modified LESS THAN ${minutes} Minutes Ago"

		find . -mmin -${minutes} | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}

f_older_access ()
	{
		local minutes=$(echo $1);
		title "Files/Dirs Accessed MORE THAN ${minutes} Minutes Ago"

		find . -amin +${minutes} | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}
f_newer_access ()
	{
		local minutes=$(echo $1);
		title "Files/Dirs Accessed LESS THAN ${minutes} Minutes Ago"

		find . -amin -${minutes} | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}

f_older_change ()
	{
		local minutes=$(echo $1);
		title "Files/Dirs Changed MORE THAN ${minutes} Minutes Ago"

		find . -cmin +${minutes} | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}
f_newer_change ()
	{
		local minutes=$(echo $1);
		title "Files/Dirs Changed LESS THAN ${minutes} Minutes Ago"

		find . -cmin -${minutes} | egrep -v '^\.$' | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"

		separator
	}

file_info ()
	{
		title "File: Extensive Information"
		local fileName=$(echo $1 | sed "s/[ ]/\\\ /g");

		echo ' [STAT]'
		stat ${fileName}

		if [ "$APPRISS_ENV" != "local" ]; then
			separator
			echo ' [GETFACL]'
			getfacl ${fileName}
		fi

		separator
		echo ' [FILE]'
		file -p ${fileName}

		separator
	}

archive_info ()
	{
		title "Archive: Extensive Information"
		local fileName=$(echo $1 | sed "s/[ ]/\\\ /g");
		local fileExt=$(echo $1 | sed "s/.*\.//" | tr '[:lower:]' '[:upper:]' );

		if [ "$fileExt" = "ZIP" ]; then
			zipinfo $fileName
			separator
			return;
		fi

		if [ "$fileExt" = "TAR" ]; then
			tar -tvf $fileName
			separator
			return;
		fi

		if [ "$fileExt" = "BZ2" ]; then
			tar -jtvf $fileName
			separator
			return;
		fi

		if [ "$fileExt" = "GZ" ]; then
			# Determine if it's a TAR archive or not...
			fileExt=$( echo "${fileName}" | tr '[:lower:]' '[:upper:]' | egrep '.TAR.GZ' );

			if [ "$fileExt" = "" ]; then
				# simple GZ
				gzip -l $fileName
			else
				# TAR.GZ
				tar -ztvf $fileName
			fi

			separator
			return;
		fi

		echo
		echo "Archive '${fileExt}' not recognized!"
	}

line ()
	{
		local lineNum=`expr $1 + 0`;
		local fileName=$2;
		local lineExpand=$3;

		if [ "$lineExpand" = '' ]; then
			# if no expansion value is provided, pick a default value
			lineExpand=4;
		fi

		local lineStart=`expr $lineNum - $lineExpand`;
		local lineEnd=`expr $lineNum + $lineExpand`

		title "File: ${fileName} | Line: ${lineNum} | Expansion: ${lineExpand}"

		if [ $lineStart -lt 1 ]; then
			lineStart=1;
		fi

		# cat -n "${fileName}" | sed -n -l "${lineStart},${lineEnd}p;${lineEnd}q" | egrep --color='auto' "(^[ ]*${lineNum}[^0-9])|(^[ ])"

		cat -n "${fileName}" | sed -n "${lineStart},${lineEnd} p" | egrep --color='auto' "(^[ ]*${lineNum}[^0-9])|(^[ ])"

		separator
	}

file_nullchars ()
	{
		title "Null Character Occurences in File"
		local fileName=$(echo $1);

		hexdump -ve '1/1 "%.2x "' ${fileName} | egrep -o '00' | wc -l

		separator
	}

f_nullchars ()
	{
		title "Find Files with Null Character Occurences (Recursive)"

		#----
		# CHANGE formatting for loops to handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----

		for i in $( find . -type f );
			do
			# echo "$( hexdump -ve '1/1 "%.2x "' ${i} | egrep -c '00' ): ${i}" | egrep -v '^0' | cut -c 4-;
			# INCORRECT below??
			echo "$( hexdump -b ${i} | egrep -m 1 -c ' 00' ): ${i}" | egrep -v '^0' | cut -c 4-;
			done ;

		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

f_zerobyte ()
	{
		# Finds and lists all zero-byte files
		title "Zero-Byte Files (Recursive)"

		find . -empty -type f -print0 | xargs -0 -n 1

		separator
	}

perm_troubleshoot ()
	{
		# permission basics:  ugo  |  rwx

		title "Items NOT Writable (Recursive):"
		find . -not -perm -u=w -print0 | xargs -0 -n 1
		echo

		title "Items NOT Readable (Recursive):"
		find . -not -perm -u=r -print0 | xargs -0 -n 1
		echo

		title "Items with Unknown USER (Recursive):"
		find . -nouser -print0 | xargs -0 -n 1
		echo

		title "Items with Unknown GROUP (Recursive):"
		find . -nogroup -print0 | xargs -0 -n 1
		echo

		title "List of all Owners and Groups (Recursive):"
		find . -print0 | xargs -0 ls -dl | tr -s " " | cut -d " " -f 3,4 | sort | uniq -c | sed -e 's/\([ ]*\)\([0-9]*\)\([ ]\)\([^ ]*\)\([ ]\)\([^ ]*\)/\1(\2x) \4  \6/'
		separator
	}

perm_find_by_user ()
	{
		local user=$1;
		title "Items owned by user '$user' (Recursive):"
		find . -user $user -print0 | xargs -0 -n 1
		separator
	}

perm_find_by_group ()
	{
		local group=$1;
		title "Items owned by group '$group' (Recursive):"
		find . -group $group -print0 | xargs -0 -n 1
		separator
	}

perm_ownership_current_user ()
	{
		# permission basics:  ugo  |  rwx

		title "Items owned by current user '$USER' (Recursive):"
		find . -user $USER -print0 | xargs -0 -n 1
		echo

		title "Items NOT owned by current user '$USER' (Recursive):"
		find . -not -user $USER -print0 | xargs -0 -n 1

		separator
	}

perm_restrictions_current_user ()
	{
		title "Items NOT Executable by current user '$USER' (Recursive):"
		find . -not -perm -u=x | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"
		echo

		title "Items NOT Writable by current user '$USER' (Recursive):"
		find . -not -perm -u=w | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"
		echo

		title "Items NOT Readable by current user '$USER' (Recursive):"
		find . -not -perm -u=r | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"
		echo

		separator
	}

perm_restrictions_current_group ()
	{
		title "Items NOT Executable by current group '$GROUPS' (Recursive):"
		find . -not -perm -g=x | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"
		echo

		title "Items NOT Writable by current group '$GROUPS' (Recursive):"
		find . -not -perm -g=w | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"
		echo

		title "Items NOT Readable by current group '$GROUPS' (Recursive):"
		find . -not -perm -g=r | egrep -v -i '\.svn\/' | sed "s/[ ]/\\\ /g"
		echo

		separator
	}

perm_make_readable ()
	{
		local fileName=$(echo $1);
		title "Make '${fileName}' Readable by All"
		separator

		chmod ugo+r $fileName

		l
	}
perm_make_writable ()
	{
		local fileName=$(echo $1);
		title "Make '${fileName}' Writable by All"
		separator

		chmod ugo+w $fileName

		l
	}
perm_make_executable ()
	{
		local fileName=$(echo $1);
		title "Make '${fileName}' Executable by All"
		separator

		chmod ugo+x $fileName

		l
	}

perm_make_not_readable ()
	{
		local fileName=$(echo $1);
		title "Make '${fileName}' Not Readable except by the Owner"
		separator

		chmod go-r $fileName

		l
	}
perm_make_not_writable ()
	{
		local fileName=$(echo $1);
		title "Make '${fileName}' Not Writable except by the Owner"
		separator

		chmod go-w $fileName

		l
	}
perm_make_not_executable ()
	{
		local fileName=$(echo $1);
		title "Make '${fileName}' Not Executable by Anyone"
		separator

		chmod ugo-x $fileName

		l
	}

svn_remove ()
	{
		title 'Remove ".svn" directories (Recursive)'

		local currentCount=$( echo * | find . -type d -iname '.svn' | sed "s/[ ]/\\\ /g" | wc -l );

		echo "   Directory: $(pwd)/"
		echo

		if [ $currentCount -eq 0 ]; then
			echo '   No items found to remove. Exiting...'
			return;
		else
			echo "   Items to remove (${currentCount}):"
		fi
		separator

		find . -type d -iname '.svn' | sed "s/[ ]/\\\ /g"
		separator
		echo

		# Get input from user
		while true; do
			read -p "   Proceed and remove all ${currentCount} items? " yn
			case $yn in
				[Yy]* ) echo '   Deleting...'; break;;
				[Nn]* ) echo '   Exiting...'; return;;
				* ) echo "   Please answer yes or no.";;
			esac
		done

		find . -type d -iname '.svn' | sed "s/[ ]/\\\ /g" | xargs rm -rf

		currentCount=$( echo * | find . -type d -iname '.svn' | sed "s/[ ]/\\\ /g" | wc -l );
		echo
		echo "   Final Count: ${currentCount}"
		echo

		separator
	}

perl_check ()
	{
		title 'Perl Syntax Check (recursive)'

		# Must utilize bash in interactive mode when using aliases with xargs
		find . -path "*/.svn" -prune  -o  -iname \*.pl  -o  -iname \*.pm  -o  -iname .prerun  -o  -iname .postrun | sed "s/[ ]/\\\ /g" | xargs -n 1 bash -ic do_perl_check_with_dir_change
	}

bk ()
	{
		title 'Backup File/Directory'
		local fileName=$(echo "$1");
		local fileNameBk=$(echo "${1}_bk");

		# Empty...
		if [ "$fileName" = '' ]; then
			echo "   You have not provided anything to back up!"
			echo '   Exiting...'
			echo
			return;
		fi

		# Not found...
		if [ ! -e $fileName ]; then
			echo "   Item '$fileName' does not exist!"
			echo '   Exiting...'
			echo
			return;
		fi

		# Already exists...
		if [ -e $fileNameBk ]; then
			# Get input from user
			while true; do
				read -p "   Item '$fileNameBk' already exists! Overwrite? " yn
				case $yn in
					[Yy]* ) rm -rf $fileNameBk ; break;;
					[Nn]* ) echo '   Exiting...'; echo; return;;
					* ) echo "      Please answer yes or no.";;
				esac
			done
		fi

		cp -r -p $fileName $fileNameBk

		echo "   Created backup '${fileNameBk}' from original '${fileName}'."

		separator

		l
	}

clean ()
	{
		# Clean the custom command line scaffold, for easy result recycling...
		while read line
		do
			echo $line | sed "s/[ ]/\\\ /g" | egrep -i -v '([\-]{12})|(^[ ])|(^\|)'
		done
	}

alias listify="clean | sed \"s/[ ]/\\\ /g\" | xargs ls $LS_OPTIONS -ltrd"

#--------------------------------------------------------------------------------

scp_to_prep ()
	{
		# Copy all archived JPG files from a remote directory to a local directory...
		#    scp nbozic@prodaftpproc01.prod.appriss.com:/prodfsnr/prod/project/vine/ak/akdoc/ftphome/photos_temp_archive/*.jpg ${APPRISS_ENV_HOME}/AKDOC/project/raw_data/photos3/

		# Copy all files from a remote directory to the current local directory...
		#    scp nbozic@${prep_server}:/srv/ftp/homedirs/mi/m/mimontcalmja/* ./

		# Copy all files with .txt extension to the directory /home/user on the remote.server.com host
		#    scp *.txt user@remote.server.com:/home/user/     ( l >> r )

		# Copy the file "foobar.txt" from a remote host to the local host
		#    scp your_username@remotehost.edu:foobar.txt /some/local/directory    ( l << r )

		title 'SCP: Transfer Local items to Prep "temp" dir'
		echo "   Example1: reform.ini"
		echo "   Example2: *"
		separator

		local pattern=$(echo $1);

		scp ./$pattern nbozic@${prep_server}:~/temp/

		separator
	}

scp_to_prod ()
	{
		title 'SCP: Transfer Local items to Prod "temp" dir'
		echo "   Example1: reform.ini"
		echo "   Example2: *"
		separator

		local pattern=$(echo $1);

		scp ./$pattern nbozic@${prod_server}:~/temp/

		separator
	}

scp_from_prep ()
	{
		title 'SCP: Transfer from Prep to current Local dir'
		echo "   Example1: /prepfsnr/prep/project/vine/in/instate/ingibsonja/ftphome/reform.ini"
		echo "   Example2: /srv/ftp/homedirs/in/g/ingibsonja/*"
		separator

		local pattern=$(echo $1);

		scp -p nbozic@${prep_server}:$pattern ./

		separator
	}
scp_from_prod ()
	{
		title 'SCP: Transfer from Prod to current Local dir'
		echo "   Example1: /prodfsnr/prod/project/vine/in/instate/ingibsonja/ftphome/reform.ini"
		echo "   Example2: /srv/ftp/homedirs/in/g/ingibsonja/*"
		separator

		local pattern=$(echo $1);

		scp -p nbozic@${prod_server}:$pattern ./

		separator
	}


#--------------------------------------------------------------------------------
# Functions, Indirect (intended for other functions)
#--------------------------------------------------------------------------------

do_run_resync_with_dir_change ()
	{
		if $APPRISS_ENV_LOCAL ; then

			# This script temporarily changes the working dir.
			local originalDir=$(pwd);
			local tempDir=$(echo $0 | sed -e 's/\(.*\/\)\(.*\)/\1/');
			local tempFile=$(echo $0 | sed "s/.*\///");

			echo "   Running Resync: $tempFile from '$tempDir' ..."
			separator

			# Change directory to new path
			command cd ${tempDir}
			# Check Perl...
			perl ${tempFile} -r -i
			# Change directory back
			command cd ${originalDir}

		else
			do_display_disabled_message
		fi
	}

do_run_interface ()
	{
		if $APPRISS_ENV_LOCAL ; then
			# This script runs the interface from current directory

			local interfaceFile=$(echo $0 | sed "s/.*\///");

			separator

			if [ "$interfaceFile" == "getdata.rex" ]; then
				# Rex
				echo "   Running Rex file '$interfaceFile' in current dir ..."
				separator
				rexx ${interfaceFile}
			else
				# Perl
				echo "   Running Perl file '$interfaceFile' in current dir ..."
				separator
				perl ${interfaceFile}
			fi

		else
			do_display_disabled_message
		fi
	}

do_perl_check_with_dir_change ()
	{
		# It doesn't seem possible to reliably check the syntax of
		# a perl file if the file is located in a sub directory.
		# As a result this script temporarily changes the working dir.

		# Exit early if string 'bash' is provided (no files found)
		if [ "$0" == "bash" ]; then
			echo
			echo '  No perl files found in current directory or subdirectories!'
			return;
		fi

		# Get rid of spaces in original dir:
		local originalDir=$(pwd);
		# Parse directory portion (and revert back to spaces):
		local tempDir=$(echo "$0" | sed -e 's/\(.*\/\)\(.*\)/\1/' | sed "s/\\\ /\ /");
		# Parse file name portion (and revert back to spaces):
		local tempFile=$(echo "$0" | sed "s/.*\///" | sed "s/\\\ /\ /");

		echo -e "\033[0;37m  File '${0}': \033[0m"

		# Change directory to new path...
		command cd "${tempDir}"

		# Check Perl...
		perl -cw ${tempFile}
		separator

		# Change directory back...
		command cd "${originalDir}"
	}

do_search_i_vine ()
	{
		find . -iname '.prerun';echo
		find . -iname '.postrun';echo
		find . -iname '.mask';echo
		find . -iname '.replicate';echo
		find . -type f -iname 'preproc';echo
		find . -iname '*.exe';echo
		find . -iname '*.ini';echo
		find . -iname '*.jar';echo
		find . -iname '*.xsl';echo
		find . -iname '*.xslt';echo
		find . -iname '*.pl';echo
		find . -iname '*.pm';echo
		find . -iname '*.rex';echo
		find . -iname '*.bat';echo
		find . -iname '*.sh';echo
		find . -iname '*.asc';echo
		find . -iname '*.prop';echo
		find . -iname '*.properties';echo
		find . -iname '*.sql';echo
		find . -iname '*.doc';echo
		find . -iname '*.vbs';echo
		find . -iname '*.wsf';echo
		find . -iname '*.udl';echo
		find . -type f -iname 'known_hosts';echo
		find . -type f -iname 'authorized_keys';echo
	}

do_search_i_junk ()
	{
		find . -iname '*.prc';echo
		find . -iname '*.fin';echo
		find . -iname '*.wrk';echo
		find . -iname '*.srt';echo
		find . -iname '*.old';echo
		find . -iname '*.cmp';echo
		find . -iname '*.sys';echo
		find . -iname '*.dat';echo
		find . -iname '*.txt';echo
		find . -iname '*.xml';echo
		find . -iname '*.csv';echo
		find . -iname '*.bad';echo
		find . -iname '*.tok';echo
		find . -iname '*.token';echo
		find . -iname '*.tracker';echo
		find . -iname '*.downloaded';echo
		find . -iname '*_temp';echo
		find . -iname '*.zip';echo
		find . -iname '*.tar';echo
		find . -iname '*.gz';echo
		find . -type d -iname 'mrgedata';echo
		find . -type d -iname 'log';echo
		find . -iname '*.log';echo
		find . -type d -iname 'archive';echo
		find . -iname '*.sav';echo
		find . -iname '*.raw';echo
		find . -iname '*.sent';echo
		find . -type d -iname 'send';echo
		find . -type d -iname 'working';echo
		find . -type d -iname 'holding';echo
	}

do_display_disabled_message ()
	{
		echo -e "\033[0;43;30m ! FUNCTIONALITY DISABLED IN THIS ENVIRONMENT ! \033[0m"
		echo
	}

reload_terminal ()
	{
		separator

		# This will reload all the changes made to .bashrc,
		# as well as .dir_colors, without having to restart the terminal...
		source ~/.bashrc

		separator

		l
	}

files_rename_strip_path ()
	{
		title 'Strip Paths From File Names (No Sub Dirs)'
		echo "   Renames files and dirs like '\some\path\itemname' to 'itemname'."
		separator

		local fileCount=$( find . -maxdepth 1 -name '\\*' | wc -l );
		echo "Found ${fileCount} items to process."

		if [ $fileCount -eq 0 ]; then
			return;
		fi

		# Prompt the user...
		while true; do
			read -p "   Are you sure you want proceed? " yn
			case $yn in
				[Yy]* ) break;;
				[Nn]* ) echo '   Exiting...'; return;;
				* ) echo "   Please answer yes or no.";;
			esac
		done

		separator

		##  find . -maxdepth 1 -name '\\*' -printf "echo '%p' | tr '[:upper:]' '[:lower:]' \n" | sh
		# This constructs a list of commands using pipes to execute, then sends these
		# to a new shell to actually be executed. (omitting the final "| sh" is a good
		# way to debug or perform dry runs.)

		#--------------------------------------------------------------------------------

		#### Faster, but less flexible and difficult to maintain:

		# find . -maxdepth 1 -name '\\*' -printf "echo \"Renaming file '%p'...\"; mv \"%p\" \"\$(echo '%p' | sed \"s/.*\\\\\\\\\\\\//\")\" \n" | sh

		#--------------------------------------------------------------------------------

		#### Slower, but more flexible and easy to maintain:

		#----
		# CHANGE formatting so loops can handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----
		for i in $( find . -maxdepth 1 -name '\\*' );
		do
			echo "Renaming '$(echo ${i} | sed "s/.*\///" )' to '$(echo ${i} | sed "s/.*\\\//" )'...";
			mv "${i}" "$(echo ${i} | sed "s/.*\\\//" )"
		done ;
		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		#--------------------------------------------------------------------------------

		separator
	}

files_rename_to_lowercase ()
	{
		title 'Change File Names to Lower Case (No Sub Dirs)'
		echo "   Renames files like 'IMG1.JPG' to 'img1.jpg'."
		separator

		local fileCount=$( find . -maxdepth 1 -type f -name '*' | egrep '[A-Z]' | wc -l );
		echo "Found ${fileCount} items to process."

		if [ $fileCount -eq 0 ]; then
			return;
		fi

		# Prompt the user...
		while true; do
			read -p "   Are you sure you want proceed? " yn
			case $yn in
				[Yy]* ) break;;
				[Nn]* ) echo '   Exiting...'; return;;
				* ) echo "   Please answer yes or no.";;
			esac
		done

		separator

		#----
		# CHANGE formatting so loops can handle spaces in file names...
		SAVEIFS=$IFS
		IFS=$(echo -en "\n\b")
		#----
		for i in $( find . -maxdepth 1 -type f -name '*' | egrep '[A-Z]' );
		do
			local fileOriginal="${i}";
			local fileNew="$(echo ${i} | tr '[:upper:]' '[:lower:]' )";
			local fileTemp="${fileNew}_";
			echo "Renaming '${fileOriginal}' to '${fileNew}'...";
			mv -f $fileOriginal $fileTemp;
			mv -f $fileTemp $fileNew;
		done ;
		#----
		# RESTORE formatting to previous...
		IFS=$SAVEIFS
		#----

		separator
	}

xml_validate ()
	{
		title "XML File Validation (Recursive)"
		echo "   Checks the syntax. No additional messages if valid."
		separator

		find . -iname '*.xml' -print0 |
		xargs -0 -I {} bash -ic do_xml_or_xsl_validate {}
	}
xsl_validate ()
	{
		title "XSL and XSLT File Validation (Recursive)"
		echo "   Checks the syntax. No additional messages if valid."
		separator

		find . -iname '*.xsl' -o -iname '*.xslt' -print0 |
		xargs -0 -I {} bash -ic do_xml_or_xsl_validate {}
	}
do_xml_or_xsl_validate ()
	{
		local fileName=$0;

		echo "Checking '${fileName}'..."
		xmllint --noout ${fileName}

		separator
	}

summary ()
	{
		activity
	}

activity ()
	{
		title "Activity Summary of Current Directory (Recursive)"

		local totalItems=$( find . | egrep -v -i '^\.[\/]?$' | wc -l );
		echo "   [ Total Items in Directory: ${totalItems} ]"
		separator
		echo

		echo "   Least recently ACCESSED items (limit 2):"
		find . -print0 | xargs -0 ls -du | tail -n 3 | egrep -v -i '^\.[\/]?$' | tail -n 2 | sed "s/[ ]/\\\ /g" | xargs ls $LS_OPTIONS_GROUPING_OVERRIDE -dltu
		echo
		echo "   Least recently CHANGED items (limit 2):"
		find . -print0 | xargs -0 ls -dc | tail -n 3 | egrep -v -i '^\.[\/]?$' | tail -n 2 | sed "s/[ ]/\\\ /g" | xargs ls $LS_OPTIONS_GROUPING_OVERRIDE -dltc
		echo
		echo "   Least recently MODIFIED items (limit 2):"
		find . -print0 | xargs -0 ls -dt | tail -n 3 | egrep -v -i '^\.[\/]?$' | tail -n 2 | sed "s/[ ]/\\\ /g" | xargs ls $LS_OPTIONS_GROUPING_OVERRIDE -dlt
		echo
		separator
		echo

		# echo "   Most recently ACCESSED items (limit 8):"
		# find . -print0 | xargs -0 ls -dur | tail -n 9 | egrep -v -i '^\.[\/]?$' | tail -n 8 | sed "s/[ ]/\\\ /g" | xargs ls $LS_OPTIONS_GROUPING_OVERRIDE -dltur
		# separator
		echo "   Most recently CHANGED items (limit 8):"
		find . -print0 | xargs -0 ls -dcr | tail -n 9 | egrep -v -i '^\.[\/]?$' | tail -n 8 | sed "s/[ ]/\\\ /g" | xargs ls $LS_OPTIONS_GROUPING_OVERRIDE -dltcr
		echo
		echo "   Most recently MODIFIED items (limit 8):"
		find . -print0 | xargs -0 ls -dtr | tail -n 9 | egrep -v -i '^\.[\/]?$' | tail -n 8 | sed "s/[ ]/\\\ /g" | xargs ls $LS_OPTIONS_GROUPING_OVERRIDE -dltr
		echo
		separator
	}

file_corrupted ()
	{
		local fileName=$1;

		# Utilize cat to detect a corrupt file...
		cat "$fileName" > /dev/null 2>&1

		# Check if previously executed command returned an error...
		if [ $? -eq 0 ]; then
			echo 'File is OK.'
		else
			echo 'File is CORRUPT!'
		fi

		# Utilize other methods to detect corrupt files?

	}

#--------------------------------------------------------------------------------

# Default actions on initial load...

## !! Automatic listings are causing issues with interactive bash calls...
# if [ "$APPRISS_ENV" == "local" ]; then
	# Local:
	# i
# fi

#--------------------------------------------------------------------------------