From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata bugfix: HDIO_DRIVE_TASK
Date: Wed, 07 Feb 2007 11:40:12 -0500
Message-ID: <45CA00EC.7070507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3036 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965667AbXBGQkQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 11:40:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

I was trying to use HDIO_DRIVE_TASK for something today,
and discovered that the libata implementation does not copy
over the upper four LBA bits from args[6].

This is serious, as any tools using this ioctl would have their
commands applied to the wrong sectors on the drive, possibly resulting
in disk corruption.

Ideally, newer apps should use SG_IO/ATA_16 directly,
avoiding this bug.  But with libata poised to displace drivers/ide,
better compatibility here is a must.

This patch fixes libata to use the upper four LBA bits passed
in from the ioctl.

The original drivers/ide implementation copies over all bits
except for the master/slave select bit.  With this patch,
libata will copy only the four high-order LBA bits,
just in case there are assumptions elsewhere in libata (?).

Signed-Off-By:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/ata/libata-scsi.c.orig	2007-02-02 12:30:21.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2007-02-07 11:32:52.000000000 -0500
@@ -295,6 +295,7 @@
 	scsi_cmd[8]  = args[3];
 	scsi_cmd[10] = args[4];
 	scsi_cmd[12] = args[5];
+	scsi_cmd[13] = args[6] & 0x0f;
 	scsi_cmd[14] = args[0];
 
 	/* Good values for timeout and retries?  Values below
