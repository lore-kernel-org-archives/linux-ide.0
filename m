From: Tejun Heo <htejun@gmail.com>
Subject: regarding crazy head unloads
Date: Fri, 23 May 2008 10:36:08 +0900
Message-ID: <48361F88.7040400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060504070408090003020400"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:50567 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbYEWBgT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 May 2008 21:36:19 -0400
Received: by wx-out-0506.google.com with SMTP id h29so293221wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 22 May 2008 18:36:17 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: roland.kletzing@materna.de, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, scott@ubuntu.com

This is a multi-part message in MIME format.
--------------060504070408090003020400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, ATA/SMART fellows.

This message is regarding crazy head unloads on certain laptops.  In a 
desperate attempt to increase battery time, some vendors configure ATA 
APM (advanced power management) too aggressive to the point of being 
fragile (can even be triggered on Windows) and the drive unloads head 
like crazy and kills itself quickly (in months).  For more information, 
please take a look at the following links.

https://bugzilla.novell.com/show_bug.cgi?id=386555
https://bugs.launchpad.net/ubuntu/+source/acpi-support/+bug/59695
http://www.thinkwiki.org/wiki/Problem_with_hard_drive_clicking

This primarily is those hardware vendors' faults and updating their 
firmware is probably the best way to fix it; however, it can actually 
kill the harddrive which usually causes a lot of anxiety and stress on 
the user, so I think we need to take some measures.

Attached are storage-fixup script which is to be called during boot and 
resume and configuration file to go under /etc.  The script can match 
dmi and hal properties and execute commands on the matching devices. 
The config file currently only contains three rules.

Here are two ideas to better handle this problem:

1. Describe the problem on linux-ata.org and ask people to report 
dmidecode and hdparm -I output on affected machines.  Share 
storage-fixup (or any other alternative) and storage-fixup.conf on the page.

2. This is from Roland.  Make smartd aware of the problem and warn user 
if load/unload count per powered on hours goes too high.  Maybe the 
warning can direct the user to linux-ata.org page?

Thanks.

-- 
tejun

--------------060504070408090003020400
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
# dmi KEY VALUE
#	Checks whether DMI value for KEY matches VALUE.  If not, the
#	rule is skipped.
#
# hal KEY VALUE
#	Checks whether there are devices which has KEY value matching
#	VALUE.  storage-fixup determines applies actions to devices
#	which match all hal matches, so all rules should have at least
#	one hal match.
#
# act ACTION
#	Executes ACTION on matched devices.  ACTION can contain $DEV
#	which will be substituted with device file of matching device.
#
# For example, the following (useless) rule disables APM on the first
# harddrive of my machine.
#
# rule p5w64
# dmi baseboard-product-name	P5W64 WS Pro
# dmi baseboard-manufacturer	ASUSTeK Computer INC.
# hal storage.model		WDC WD5000YS-01M
# hal storage.serial		SATA_WDC_WD5000YS-01_WD-WMANU1217262
# act hdparm -B 255 $DEV
#

conf_file=${CONF_FILE:-/etc/storage-fixup.conf}
hal_find_by_property=${HAL_FIND_BY_PROPERTY:-hal-find-by-property}
hal_get_property=${HAL_GET_PROPERTY:-hal-get-property}
dmidecode=${DMIDECODE:-dmidecode}

verbose=0
lineno=0
skip=0
rule_name=""
declare -a dev_ids
newline=$'\n'

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
# Match functions - do_dmi() and do_hal() - execute DMI and HAL
# matches respectively.  Return value 0 indicates match, 1 invalid
# match (triggers warning) and 2 mismatch.
#
do_dmi() {
    local val

    if [ -z "$1" -o -z "$2" ]; then
	return 1
    fi

    val=$($dmidecode --string "$1")
    if [ "$?" -ne 0 ]; then
	return 1
    fi

    if [ "$val" = "$2" ]; then
	debug "Y $lineno $rule_name dmi $1=$2"
	return 0;
    fi

    debug "N $lineno $rule_name dmi $1=$2"
    return 2
}

do_hal() {
    local i out ifs_store append=0

    if [ -z "$1" -o -z "$2" ]; then
	return 1
    fi

    if [ ${#dev_ids[@]} -eq 0 ]; then
	append=1
    fi

    #
    # bash really isn't a good programming language for this kind of
    # stuff and makes it look much more complex than it needs to be.
    # The following loop executes hal-find-by-property and ands the
    # result with the previous result.
    #
    ifs_store="$IFS"
    IFS="$newline"
    dev_ids=(
	$($hal_find_by_property --key "$1" --string "$2" \
	    | while read found; do
		if [ $append -ne 0 ]; then
		    echo "$found"
		else
		    for id in "${dev_ids[@]}"; do
			if [ "$id" = "$found" ]; then
			    echo "$found"
			    break
			fi
		    done
		fi
	    done))
    IFS="$ifs_store"

    if [ "$?" -ne 0 ]; then
	debug "N $lineno $rule_name hal $1=$2"
	return 2
    fi

    debug "Y $lineno $rule_name hal nr_devs=${#dev_ids[@]} $1=$2"

    return 0
}

do_act() {
    local id dev

    for id in "${dev_ids[@]}"; do
	if ! DEV=$($hal_get_property --udi "$id" --key block.device); then
	    warn "can't find device node for $id"
	    continue
	fi

	eval log "$rule_name: executing \"$1\""
	eval "$1"
    done

    return 0
}

while read f0 f1 f2; do
    true $((lineno++))
    if [ -z ${f0###*} ]; then
	continue
    fi

    if [ "$f0" = rule ]; then
	rule_name=$f1
	skip=0
	dev_ids=()
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
	if [ $ret -eq 1 ]; then
	    warn "malformed line $lineno \"$f0 $f1 $f2\","\
	         "skipping rule $rule_name" 2>&1
	fi
	skip=1
    fi
done < $conf_file

--------------060504070408090003020400
Content-Type: text/plain;
 name="storage-fixup.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="storage-fixup.conf"

rule tp-t60
dmi system-manufacturer		LENOVO
dmi system-product-name		1952W5R
dmi system-version		ThinkPad T60
hal storage.model		Hitachi HTS722020K9SA00
act hdparm -B 255 $DEV

rule hp-dv6500
dmi system-manufacturer		Hewlett-Packard
dmi system-product-name		HP Pavilion dv6500 Notebook PC
dmi system-version		Rev 1
hal storage.model		SAMSUNG HM250JI
act hdparm -B 255 $DEV

rule dell-e1505
dmi system-manufacturer		Dell Inc.
dmi system-product-name		MM061
hal storage.model		ST9100824AS
act hdparm -B 255 $DEV

--------------060504070408090003020400--
