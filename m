From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.20-rc3] fix broken retval test in sr_block_ioctl
Date: Tue, 2 Jan 2007 17:30:07 -0500
Message-ID: <200701021730.07356.liml@rtr.ca>
References: <200701021724.39613.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3051 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964965AbXABWaG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 17:30:06 -0500
In-Reply-To: <200701021724.39613.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

This patch adds support for passing ATA_12 and ATA_16 commands
through to ATAPI devices in libata.  In practice, the upper layers will
still currently prevent ATA_16 commands, as no (?) ATAPI drives support
them yet.  But it will work if such a drive is ever encountered.

This patch is necessary for using SG_IO from userspace,
and an upcoming hdparm release will be updated to use this interface.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
Allow ATA_12 / ATA_16 passthru commands to be issued for ATAPI devices


diff -u --recursive --new-file --exclude='.*' --exclude='*.[osa]' --exclude='*.ko' --exclude='*.mod.c' --exclude='*.orig' --exclude=System.map --exclude='*.lds' --exclude='*.symvers' old/drivers/ata/libata-scsi.c linux/drivers/ata/libata-scsi.c
--- old/drivers/ata/libata-scsi.c	2007-01-02 15:12:31.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2007-01-02 15:31:56.000000000 -0500
@@ -2650,6 +2650,12 @@
 
 static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
+	if (cmd == ATA_12 || cmd == ATA_16)
+		return ata_scsi_pass_thru;
+
+	if (dev->class == ATA_DEV_ATAPI)
+		return atapi_xlat;
+
 	switch (cmd) {
 	case READ_6:
 	case READ_10:
@@ -2669,10 +2675,6 @@
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
 
-	case ATA_12:
-	case ATA_16:
-		return ata_scsi_pass_thru;
-
 	case START_STOP:
 		return ata_scsi_start_stop_xlat;
 	}
@@ -2708,6 +2710,7 @@
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
+	ata_xlat_func_t xlat_func;
 	int rc = 0;
 
 	if (unlikely(!scmd->cmd_len)) {
@@ -2717,17 +2720,11 @@
 		return 0;
 	}
 
-	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      scmd->cmnd[0]);
-
-		if (xlat_func)
-			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
-		else
-			ata_scsi_simulate(dev, scmd, done);
-	} else
-		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
-
+	xlat_func = ata_get_xlat_func(dev, scmd->cmnd[0]);
+	if (xlat_func)
+		rc = ata_scsi_translate(dev, scmd, done, xlat_func);
+	else
+		ata_scsi_simulate(dev, scmd, done);
 	return rc;
 }
 
