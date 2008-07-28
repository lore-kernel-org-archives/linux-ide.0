From: Tejun Heo <teheo@suse.de>
Subject: Re: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl
 output
Date: Mon, 28 Jul 2008 16:28:28 +0900
Message-ID: <488D751C.5080302@suse.de>
References: <488B27CE.5060106@i-nz.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030909080709090302050400"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44184 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbYG1H2z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 03:28:55 -0400
In-Reply-To: <488B27CE.5060106@i-nz.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ivan N. Zlatev" <contact@i-nz.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030909080709090302050400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ivan N. Zlatev wrote:
> I am having frequent head unloads on a Dell Vostro 1400 laptop with a
> Seagate HDD. As explained on the Wiki[1] I am attaching for you the
> output of:
> 
>    * hdparm -I
>    * dmidecode
>    * smartctl --all (in addition)
> 
> I hope this information is useful for you.
> 
> I am currently using a workaround to prevent the unloads as described
> here - http://en.opensuse.org/Disk_Power_Management .
> 
> [1]
> http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux

Can you please test the attached storage-fixup.conf?  If you're on suse,
just do "zypper install storage-fixup" and replace
/etc/storage-fixup.conf with the attached file, remove the manual
workaround and see whether the problem is gone.

Thanks.

-- 
tejun

--------------030909080709090302050400
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
# "dmidecode" and "hdparm -I DRIVE" attached.  On a laptop the DRIVE
# is usually /dev/sda.
#

# Reported drive model: Hitachi HTS722020K9SA00
rule tp-t60
dmi system-manufacturer		LENOVO
dmi system-product-name		1952W5R
dmi system-version		ThinkPad T60
ata model			Hitachi HTS7220*K9*A*
act hdparm -B 255 $DEV

# Reported drive model: SAMSUNG HM250JI
rule hp-dv6500
dmi system-manufacturer		Hewlett-Packard
dmi system-product-name		HP Pavilion dv6500 Notebook PC
dmi system-version		Rev 1
ata model			SAMSUNG HM*I
act hdparm -B 255 $DEV

# Reported drive model: ST9100824AS
rule dell-e1505
dmi system-manufacturer		Dell Inc.
dmi system-product-name		MM061
ata model			ST9*AS
act hdparm -B 255 $DEV

# Reported drive model: ST9120822AS
rule dell-Vostro-1400
dmi system-manufacturer		Dell Inc.
dmi system-product-name		Vostro 1400
ata model			ST9*AS
act hdparm -B 255 $DEV

--------------030909080709090302050400--
