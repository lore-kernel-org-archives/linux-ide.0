From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding crazy head unloads
Date: Fri, 23 May 2008 20:36:54 +0900
Message-ID: <4836AC56.2010501@gmail.com>
References: <48361F88.7040400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090707060501090909080902"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:41190 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYEWLhF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 May 2008 07:37:05 -0400
Received: by wr-out-0506.google.com with SMTP id c48so332681wra.1
        for <linux-ide@vger.kernel.org>; Fri, 23 May 2008 04:37:04 -0700 (PDT)
In-Reply-To: <48361F88.7040400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: roland.kletzing@materna.de, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, scott@ubuntu.com

This is a multi-part message in MIME format.
--------------090707060501090909080902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's updated version which can do glob matching and other stuff.  I've 
also set up a git tree.

http://git.kernel.org/?p=linux/kernel/git/tj/storage-fixup.git

-- 
tejun

--------------090707060501090909080902
Content-Type: text/plain;
 name="storage-fixup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="storage-fixup"

#! /bin/bash
#
# storage-fixup			- Tejun Heo <teheo@suse.de>
#
# Script to issue fix up commands for weird disks.  This is primarily
# to adjust ATA APM setting.  Some laptop BIOSen set this value too
# aggressively causing frequent head unloads which can kill the drive
# quickly.  This script should be called during boot and resume.  It
# examines rules from /etc/stroage-fixup.conf and executes matching
# commands.
#
# In stroage-fixup.conf, empty lines and lines starting w/ # are
# ignored.  Each line starts with rule, dmi, hal or act.
#
# rule RULENAME
#	Starts a rule.  $RULENAME can't contain whitespaces.
#
# dmi KEY PATTERN
#	Checks whether DMI value for KEY matches PATTERN.  If not, the
#	rule is skipped.
#
# hal KEY PATTERN
#	Checks whether there are devices which has KEY value matching
#	PATTERN.  storage-fixup determines applies actions to devices
#	which match all hal matches, so all rules should have at least
#	one hal match.
#
# act ACTION
#	Executes ACTION on matched devices.  ACTION can contain $DEV
#	which will be substituted with device file of matching device.
#
# PATTERN is bash glob pattern.
#
# For example, the following (useless) rule disables APM on the first
# harddrive of my machine.
#
# rule p5w64
# dmi baseboard-product-name	P5W64 WS Pro
# dmi baseboard-manufacturer	ASUSTeK Computer INC.
# hal storage.model		WDC WD5000YS-01M
# hal storage.serial		*-01_WD-WMANU1217262
# act hdparm -B 255 $DEV
#

declare usage="
Usage: storage-fixup [-h] [-V] [-v] [-b] [-c config_file]

       -h      Print this help message and exit
       -V      Print version and exit
       -v      Verbose
       -d      Dry run, don't actually execute action
       -c      Use config_file instead of /etc/storage-fixup.conf
"

declare hal_find_by_capability=${HAL_FIND_BY_CAPABILITY:-hal-find-by-capability}
declare hal_get_property=${HAL_GET_PROPERTY:-hal-get-property}
declare dmidecode=${DMIDECODE:-dmidecode}

declare version=0.1
declare conf_file=/etc/storage-fixup.conf

declare newline=$'\n'
declare dry_run=0 verbose=0 lineno=0 skip=0 rule_name="" reply
declare -a storage_ids
declare -a hal_cache
declare -a matches

log() {
    echo "storage-fixup: $@"
}

warn() {
   log "$@" 1>&2
}

debug() {
    if [ $verbose -ne 0 ]; then
	warn "$@"
    fi
}

#
# do_dmi - perform DMI match
# @key: DMI key to be passed as --string argument to dmidecode
# @pattern: glob pattern to match
#
# Returns 0 on match, 1 on mismatch, 2 on invalid match (triggers
# warning).
#
do_dmi() {
    local key="$1" pattern="$2"
    local val

    if [ -z "$key" -o -z "$pattern" ]; then
	return 1
    fi

    val=$($dmidecode --string "$key")
    if [ "$?" -ne 0 ]; then
	return 2
    fi

    if [ -z "${val##$pattern}" ]; then
	debug "Y $lineno $rule_name dmi $key=$pattern"
	return 0
    fi

    debug "N $lineno $rule_name dmi $key=$pattern"
    return 1
}

#
# search_hal_cache - search hal cache
# @id: udi of the device to search for
# @key: key of hal property to search
#
# Searches hal cache and returns 0 if found, 1 if @key properties are
# cached but matching entry is not found, 2 if @key properties are not
# cached yet.  On success, the matched property is returned in $reply.
#
search_hal_cache() {
    local id="$1" key="$2"
    local i key_found=0 cache len match

    reply=

    for ((i=0;i<${#hal_cache[@]};i++)); do
	cache=${hal_cache[i]}
	len=${#cache}

	match="${cache#$key }"
	if [ ${#match} -ne $len ]; then
	    key_found=1
	elif [ $key_found -eq 1 ]; then
	    return 1
	fi

	match="${cache#$key $id }"
	if [ ${#match} -ne $len ]; then
	    reply="$match"
	    return 0
	fi
    done

    if [ $key_found -eq 1 ]; then
	return 1
    else
	return 2
    fi
}

#
# fetch_hal_property - fetch hal property matching id and key
# @id: udi of the device to fetch property for
# @key: key of the property to fetch
#
# Fetch @key property for udi @id.  If @key properties are already
# cached, it's returned from cache.  If not, cache is populated with
# @key properties and searched again.
#
# Returns 0 if found, 1 if not found, 2 if something went wrong.  On
# success, the matched property is returned in $reply.
#
fetch_hal_property() {
    local id="$1" key="$2" property
    local i ret tid cnt=0

    # search cache
    search_hal_cache "$id" "$key"
    ret=$?
    if [ $ret -ne 2 ]; then
	return $ret
    fi

    # $key wasn't in the cache, populate the cache

    # placeholder indicating $key has been populated
    hal_cache+=("$key ")

    # run hal-get-property on each storage device and put the result in cache
    for ((i=0;i<${#storage_ids[@]};i++)); do
	tid="${storage_ids[i]}"
	property="$($hal_get_property --udi "$tid" --key "$key")"
	if [ -n "$property" ]; then
	    hal_cache+=("$key $tid $property")
	    true $((cnt++))
	fi
    done

    debug "C $cnt entries added to hal cache for $key"

    # and retry
    search_hal_cache "$id" "$key"
    return $?
}

#
# do_hal - perform HAL match
# @key: property key of interest
# @pattern: pattern to match
#
# Walk through $matches array and match each id against @key and
# @pattern.  Entries which don't match are removed from $matches.
#
# Returns 0 if $matches contain any entry after matching, 1 if it's
# empty, 2 if something went wrong.
#
do_hal() {
    local key="$1" pattern="$2" property i
    local -a old_matches=("${matches[@]}")

    if [ -z "$1" -o -z "$2" ]; then
	return 2
    fi

    matches=()

    for ((i=0;i<${#old_matches[@]};i++)); do
	fetch_hal_property "${old_matches[i]}" "$key"
	if [ $? -eq 0 -a -z "${reply##$pattern}" ]; then
	    matches+=("${old_matches[i]}")
	fi
    done

    if [ ${#matches[@]} -eq 0 ]; then
	debug "N $lineno $rule_name hal $1=$2"
	return 1
    fi

    debug "Y $lineno $rule_name hal nr_devs=${#matches[@]} $1=$2"

    return 0
}

#
# do_act - execute action
# @act: action to execute
#
# Execute @act for each device in $matches.  "$DEV" in @act is
# substituted with the /dev node of each match.  If $dry_run is set,
# the action is logged but not actually executed.
#
# Returns 0.
#
do_act() {
    local act="$1"
    local id dev

    for id in "${matches[@]}"; do
	if ! DEV=$($hal_get_property --udi "$id" --key block.device); then
	    warn "can't find device node for $id"
	    continue
	fi

	if [ $dry_run -eq 0 ]; then
	    eval log "$rule_name: executing \"$act\""
	    eval "$1"
	else
	    eval log "$rule_name: dry-run \"$act\""
	fi
    done

    return 0
}

#
# Execution starts here
#
while getopts "dvVc:h" option; do
    case $option in
	d)
	    dry_run=1;;
	v)
	    verbose=1;;
	V)
	    echo "$version"
	    exit 0;;
	c)
	    conf_file=$OPTARG;;
	*)
	    echo "$usage" 2>&1
	    exit 1;;
    esac
done

storage_ids=($($hal_find_by_capability --capability storage))
debug "I ${#storage_ids[@]} storage devices"

while read f0 f1 f2; do
    true $((lineno++))
    if [ -z ${f0###*} ]; then
	continue
    fi

    if [ "$f0" = rule ]; then
	rule_name=$f1
	skip=0
	matches=("${storage_ids[@]}")
	continue
    fi

    if [ $skip -ne 0 ]; then
	continue
    fi

    case "$f0" in
    dmi)
	    do_dmi "$f1" "$f2"
	    ;;
    hal)
	    do_hal "$f1" "$f2"
	    ;;
    act)
	    do_act "$f1 $f2"
	    ;;
    *)
	    false
	    ;;
    esac

    ret=$?
    if [ $ret -ne 0 ]; then
	if [ $ret -eq 2 ]; then
	    warn "malformed line $lineno \"$f0 $f1 $f2\","\
	         "skipping rule $rule_name" 2>&1
	fi
	skip=1
    fi
done < $conf_file

--------------090707060501090909080902
Content-Type: text/plain;
 name="storage-fixup.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="storage-fixup.conf"

#
# /etc/storage-fixup.conf - Configuration file for storage-fixup
#
# Blank lines and lines starting with # are ignored.  Please read
# comment at the top of storage-fixup for more information.
#
# Drive model patterns are generalized to cover drives from the same
# family.  Drive manufacturers usually have datasheets or web pages
# listing all models of the same family.
#
# The DMI part is difficult to generalize as there's no such
# information.  We'll have to generalize as we collect entries.
#
# If you have a harddrive which does crazy unloading but not listed
# here, please write to linux-ide@vger.kernel.org with the outputs of
# "dmidecode" and "hdparm -I DRIVE", on a laptop the DRIVE is usually
# /dev/sda.
#

# Reported drive model: Hitachi HTS722020K9SA00
rule tp-t60
dmi system-manufacturer		LENOVO
dmi system-product-name		1952W5R
dmi system-version		ThinkPad T60
hal storage.model		Hitachi HTS7220*K9*A*
act hdparm -B 255 $DEV

# Reported drive model: SAMSUNG HM250JI
rule hp-dv6500
dmi system-manufacturer		Hewlett-Packard
dmi system-product-name		HP Pavilion dv6500 Notebook PC
dmi system-version		Rev 1
hal storage.model		SAMSUNG HM*I
act hdparm -B 255 $DEV

# Reported drive model: ST9100824AS
rule dell-e1505
dmi system-manufacturer		Dell Inc.
dmi system-product-name		MM061
hal storage.model		ST9*AS
act hdparm -B 255 $DEV

--------------090707060501090909080902--
