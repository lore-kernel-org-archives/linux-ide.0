From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled,
 CD-ROM drive dead
Date: Mon, 15 Mar 2010 16:01:35 -0500
Message-ID: <4B9EA02F.2070704@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:56074 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738Ab0COVJW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Mar 2010 17:09:22 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 4FE306C093
	for <linux-ide@vger.kernel.org>; Mon, 15 Mar 2010 16:00:55 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

dmesg:
ata2.00: failed to set xfermode (err_mask=0x100)
ata2.00: disabled

hardware:
WD 500GB SATA on PCI Sil 3512 card (boot device)
Pioneer CD-ROM on PIIX4

kernel.org vanilla sources
2.6.31.1
2.6.32.9

Upon upgrading to 2.6.32.9 my CD-ROM is now dead.

With 2.6.31.1 I was using the libata driver along with the old style IDE
driver PIIX4 and both the HD and CD-ROM worked fine.

When I rolled the new 2.6.32.9 kernel, I decided to go all libata, thus
removing all the old IDE stuff in make menuconfig, and adding the PIIX4
support in the libata section along with SCSI CD-ROM support in the SCSI
section, per instructions I'd found.

Relevant .config snippets:
# Protocols
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_FD=y
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

# SCSI device support
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

# SCSI support type (disk, tape, CD-ROM)
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_SCSI_WAIT_SCAN=m

# SCSI Transports
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_SFF=y
CONFIG_ATA_PIIX=y
CONFIG_SATA_SIL=y

I always roll my drivers into the kernel.  It's just my preference, so let's
please not debate the merits of kernel modules in this thread.  I only
mention it as menuconfig for some odd reason doesn't give me the option to
roll CONFIG_SCSI_WAIT_SCAN into the kernel, but insists on making it a
module.  The one exception to this, apparently, is if I completely disable
module support, in which case it rolls it into the kernel.  It would be nice
if menuconfig gave an option to force it into the kernel even if module
support is enabled.  Seems silly to have all the SCSI stuff built into the
kernel except this one thing.  I don't think this is related to the current
problem, but I mention it just in case.  I'm not sure if the module is
actually loading.   This probably is not the right name to give modprobe but
I don't know what it would be:

~$ modprobe CONFIG_SCSI_WAIT_SCAN
FATAL: Module CONFIG_SCSI_WAIT_SCAN not found.

Anyway, should I roll another 2.6.32.9 reverting back to the dual IDE/libata
driver setup to get the CD-ROM working again, or is there some neat trick
you fine folks can share that will force libata to start playing nice with
PIIX4 and the CD-ROM?

Thanks.

-- 
Stan
