From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] RESEND: libata: check cdb len per dev instead of per host
Date: Fri, 02 Feb 2007 12:36:25 -0500
Message-ID: <45C37699.7000306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3018 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945987AbXBBRgZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 12:36:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>

Resending, with s/printk/DPRINTK/ as pointed out by Alan.

Fix libata to perform CDB len validation per device
rather than per host.  This way, validation still works
when we have a mix of 12-byte and 16-byte devices on
a common host interface.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/ata/libata-core.c new/drivers/ata/libata-core.c
--- old/drivers/ata/libata-core.c	2007-02-02 12:26:28.000000000 -0500
+++ new/drivers/ata/libata-core.c	2007-02-02 12:23:39.000000000 -0500
@@ -1573,20 +1573,6 @@
 		snprintf(desc, desc_sz, "NCQ (depth %d/%d)", hdepth, ddepth);
 }
 
-static void ata_set_port_max_cmd_len(struct ata_port *ap)
-{
-	int i;
-
-	if (ap->scsi_host) {
-		unsigned int len = 0;
-
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			len = max(len, ap->device[i].cdb_len);
-
-		ap->scsi_host->max_cmd_len = len;
-	}
-}
-
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -1767,8 +1753,6 @@
 		}
 	}
 
-	ata_set_port_max_cmd_len(ap);
-
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
 		if (ata_msg_drv(ap) && print_info)
@@ -5675,7 +5659,7 @@
 	shost->max_id = 16;
 	shost->max_lun = 1;
 	shost->max_channel = 1;
-	shost->max_cmd_len = 12;
+	shost->max_cmd_len = 16;
 }
 
 /**
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/ata/libata-scsi.c new/drivers/ata/libata-scsi.c
--- old/drivers/ata/libata-scsi.c	2007-02-02 12:26:28.000000000 -0500
+++ new/drivers/ata/libata-scsi.c	2007-02-02 12:25:20.000000000 -0500
@@ -2748,8 +2748,9 @@
 {
 	int rc = 0;
 
-	if (unlikely(!scmd->cmd_len)) {
-		ata_dev_printk(dev, KERN_WARNING, "WARNING: zero len CDB\n");
+	if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len)) {
+		DPRINTK("bad CDB len=%u, max=%u\n",
+			scmd->cmd_len, dev->cdb_len);
 		scmd->result = DID_ERROR << 16;
 		done(scmd);
 		return 0;
