From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata: Handle drives that require a spin-up command before
 first access
Date: Tue, 17 Apr 2007 18:26:07 -0400
Message-ID: <4625497F.7010109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1540 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161383AbXDQW0L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 18:26:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>


(S)ATA drives can be configured for "power-up in standby",
a mode whereby a specific "spin up now!" command is required
before the first media access.

Currently, a drive with this feature enabled can not be used at all
with libata, and once in this mode, the drive becomes a doorstop.

The older drivers/ide subsystem at least enumerates the drive,
so that it can be woken up after the fact from a userspace HDIO_*
command, but not libata.

This patch adds support to libata for the "power-up in standby"
mode where a "spin up now!" command (SET_FEATURES) is needed.
With this, libata will recognize such drives, spin them up,
and then re-IDENTIFY them if necessary to get a full/complete
set of drive features data.

Drives in this state are determined by looking for
special values in id[2], as documented in the current ATA specs.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
diff -u --recursive --new-file --exclude-from=linux-2.6.20//Documentation/dontdiff linux-2.6.20/drivers/ata/libata-core.c linux/drivers/ata/libata-core.c
--- linux-2.6.20/drivers/ata/libata-core.c	2007-02-04 13:44:54.000000000 -0500
+++ linux/drivers/ata/libata-core.c	2007-02-22 15:19:41.000000000 -0500
@@ -1453,6 +1453,7 @@
 	struct ata_taskfile tf;
 	unsigned int err_mask = 0;
 	const char *reason;
+	int tried_spinup = 0;
 	int rc;
 
 	if (ata_msg_ctl(ap))
@@ -1460,7 +1461,6 @@
 			       __FUNCTION__, ap->id, dev->devno);
 
 	ata_dev_select(ap, dev->devno, 1, 1); /* select device 0/1 */
-
  retry:
 	ata_tf_init(dev, &tf);
 
@@ -1508,6 +1508,32 @@
 			goto err_out;
 	}
 
+	if (!tried_spinup && (id[2] == 0x37c8 || id[2] == 0x738c)) {
+		tried_spinup = 1;
+		/*
+		 * Drive powered-up in standby mode, and requires a specific
+		 * SET_FEATURES spin-up subcommand before it will accept
+		 * anything other than the original IDENTIFY command.
+		 */
+		ata_tf_init(dev, &tf);
+		tf.command = ATA_CMD_SET_FEATURES;
+		tf.feature = SETFEATURES_SPINUP;
+		tf.protocol = ATA_PROT_NODATA;
+		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+		if (err_mask) {
+			rc = -EIO;
+			reason = "SPINUP failed";
+			goto err_out;
+		}
+		/*
+		 * If the drive initially returned incomplete IDENTIFY info,
+		 * we now must reissue the IDENTIFY command.
+		 */
+		if (id[2] == 0x37c8)
+			goto retry;
+	}
+
 	if ((flags & ATA_READID_POSTRESET) && class == ATA_DEV_ATA) {
 		/*
 		 * The exact sequence expected by certain pre-ATA4 drives is:
diff -u --recursive --new-file --exclude-from=linux-2.6.20//Documentation/dontdiff linux-2.6.20/include/linux/ata.h linux/include/linux/ata.h
--- linux-2.6.20/include/linux/ata.h	2007-02-04 13:44:54.000000000 -0500
+++ linux/include/linux/ata.h	2007-02-22 13:52:45.000000000 -0500
@@ -190,6 +190,8 @@
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
+	SETFEATURES_SPINUP	= 0x07, /* Spin-up drive */
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
