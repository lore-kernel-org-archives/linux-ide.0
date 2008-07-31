From: Tejun Heo <tj@kernel.org>
Subject: Re: storage-fixup.conf
Date: Thu, 31 Jul 2008 20:10:18 +0900
Message-ID: <48919D9A.2030803@kernel.org>
References: <4886F429.8070701@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090300090902060700030500"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55997 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbYGaLKn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 07:10:43 -0400
In-Reply-To: <4886F429.8070701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrea Turrini <andrea.turrini@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300090902060700030500
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Andrea Turrini wrote:
> Hi all,
> I've an Acer Aspire 1691wlmi with an Western Digital disk which does
> crazy unloads with openSUSE 11.0.
> The same happens to a mac mini which runs an openSUSE 10.3.
> 
> I've attached dmidecode and hdparm outputs for both systems.

Added.  Can you please verify the attached storage-fixup.conf works for you?

-- 
tejun

--------------090300090902060700030500
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

--------------090300090902060700030500--
