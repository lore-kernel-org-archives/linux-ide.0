From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata use ATA_12 in HDIO_* ioctls for ATAPI compatibility
Date: Tue, 2 Jan 2007 17:36:51 -0500
Message-ID: <200701021736.51465.liml@rtr.ca>
References: <200701021724.39613.liml@rtr.ca> <200701021730.07356.liml@rtr.ca> <200701021732.35120.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3837 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965010AbXABWgt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 17:36:49 -0500
In-Reply-To: <200701021732.35120.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Existing ATAPI devices do not support 16-byte commands,
so issuing ATA_16 against them gets rejected by the upper layers.

This patch updates the libata implementations of HDIO_DRIVE_CMD
and HDIO_DRIVE_TASK to use ATA_12 (rather than ATA_16) so that
they can now also be used for ATAPI devices.

Signed-off-by:  Mark Lord <mlord@pobox.com>
---
--- linux/drivers/ata/libata-scsi.c.1	2007-01-02 15:31:56.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2007-01-02 15:43:20.000000000 -0500
@@ -199,18 +199,17 @@
 		data_dir = DMA_NONE;
 	}
 
-	scsi_cmd[0] = ATA_16;
-
-	scsi_cmd[4] = args[2];
+	scsi_cmd[0] = ATA_12;
+	scsi_cmd[3] = args[2];
 	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
-		scsi_cmd[6]  = args[3];
-		scsi_cmd[8]  = args[1];
-		scsi_cmd[10] = 0x4f;
-		scsi_cmd[12] = 0xc2;
+		scsi_cmd[4] = args[3];
+		scsi_cmd[5] = args[1];
+		scsi_cmd[6] = 0x4f;
+		scsi_cmd[7] = 0xc2;
 	} else {
-		scsi_cmd[6]  = args[1];
+		scsi_cmd[4] = args[1];
 	}
-	scsi_cmd[14] = args[0];
+	scsi_cmd[9] = args[0];
 
 	/* Good values for timeout and retries?  Values below
 	   from scsi_ioctl_send_command() for default case... */
@@ -283,15 +282,15 @@
 		return -EFAULT;
 
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
-	scsi_cmd[0]  = ATA_16;
-	scsi_cmd[1]  = (3 << 1); /* Non-data */
+	scsi_cmd[0] = ATA_12;
+	scsi_cmd[1] = (3 << 1); /* Non-data */
 	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
-	scsi_cmd[4]  = args[1];
-	scsi_cmd[6]  = args[2];
-	scsi_cmd[8]  = args[3];
-	scsi_cmd[10] = args[4];
-	scsi_cmd[12] = args[5];
-	scsi_cmd[14] = args[0];
+	scsi_cmd[3] = args[1];
+	scsi_cmd[4] = args[2];
+	scsi_cmd[5] = args[3];
+	scsi_cmd[6] = args[4];
+	scsi_cmd[7] = args[5];
+	scsi_cmd[9] = args[0];
 
 	/* Good values for timeout and retries?  Values below
 	   from scsi_ioctl_send_command() for default case... */


