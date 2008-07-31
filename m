From: Tejun Heo <tj@kernel.org>
Subject: Re: Entry for Samsung Q45 /etc/storage-fixup.conf
Date: Thu, 31 Jul 2008 20:09:54 +0900
Message-ID: <48919D82.3060306@kernel.org>
References: <4876107E.308@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090306060209070001040502"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55983 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbYGaLKW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 07:10:22 -0400
In-Reply-To: <4876107E.308@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frank Seidel <fseidel@suse.de>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306060209070001040502
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Frank Seidel wrote:
> Hi,
> 
> my new Samsung Q45 containing a Toshiba drive
> also has the problem of a high amount of load_unload
> cycles. So i added it with this rules to /etc/storage-fixup.conf:
> ---
> # Reported drive model: Toshiba MK2546GSX
> rule samsung-q45
> dmi system-manufacturer         SAMSUNG ELECTRONICS CO., LTD.
> dmi system-product-name         SQ45S70S
> ata model                       TOSHIBA MK2546GSX
> act hdparm -B 254 $DEV
> ---
> 
> Perhaps you'd want to include this? Attached you find the
> output of dmidecode and hdparm -I as quested.

Added.  Can you please verify the attached storage-fixup.conf works for you?

-- 
tejun

--------------090306060209070001040502
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
act hdparm -B 254 $DEV

# Reported drive model: Toshiba MK2546GSX
rule samsung-q45
dmi system-manufacturer		SAMSUNG ELECTRONICS CO., LTD.
dmi system-product-name		SQ45S70S
ata model			TOSHIBA MK*46GSX
act hdparm -B 254 $DEV

# Reported drive model: FUJITSU MHV2080BHPL
rule macmini1_1
dmi system-manufacturer		Apple Computer, Inc.
dmi system-product-name		Macmini1,1
ata model			FUJITSU MHV2*
act hdparm -B 255 $DEV

# Reported drive model: WDC WD1200BEVE-00WZT0
rule acer-aspire-1690
dmi system-manufacturer		Acer, inc.
dmi system-product-name		Aspire 1690
ata model			WDC WD*BEVE*
act hdparm -B 255 $DEV

--------------090306060209070001040502--
