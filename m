From: "Eric A. Cottrell" <eac@shore.net>
Subject: Re: [PATCH 2.6.12-rc2 2/2] libata: add basic atapi error reporting
Date: Sat, 16 Apr 2005 21:55:23 -0400
Message-ID: <4261C20B.7010403@shore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.primushost.com ([209.58.220.66]:18903 "EHLO
	smtp2.primushost.com") by vger.kernel.org with ESMTP
	id S261237AbVDQBz1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Apr 2005 21:55:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Hello Jeff,

Problem:
ATAPI errors are not fully reported to the SCSI subsystem.  A check condition was returned but the SCSI subsystem does not get the 
sense from the device.  This causes problems when unimplemented and bad SCSI commands are sent to an atapi device.

Solution:
In libata-scsi.c add a function that reads the error register and translates it to a basic sense block.  The error register on ATAPI 
devices contains the sense key, ILI, and EOM bits. These are the same as the third byte of a SCSI sense block.  Call the function 
when there is an ATAPI error.


Signed-off-by: Eric A. Cottrell  eac@shore.net



--- a/drivers/scsi/libata-scsi.c	2005-04-09 19:34:35.000000000 -0400
+++ b/drivers/scsi/libata-scsi.c	2005-04-16 19:40:14.000000000 -0400
@@ -613,6 +613,38 @@
  		sb[6] = tf->lbal;
  	}
  }
+/**
+ *	ata_gen_atapi_sense - generate a SCSI fixed sense block from ATAPI error
+ *	@qc: Command that we are erroring out
+ *
+ *
+ *	LOCKING:
+ *	inherited from caller
+ */
+void ata_gen_atapi_sense(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+
+	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
+
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Read the controller registers.
+	 */
+	assert(NULL != qc->ap->ops->tf_read);
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		sb[2] = (tf->feature >> 4) & 0x0f;  // Get sense key
+		sb[2] |= ((tf->feature & 0x3) << 5); // Get ILI and EOM
+	}
+
+	sb[0] = 0x70;
+	sb[7] = 0x00;  // No additional sense bytes
+}

  /**
   *	ata_scsi_slave_config - Set SCSI device attributes
@@ -1659,13 +1691,8 @@
  	struct scsi_cmnd *cmd = qc->scsicmd;

  	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
-		DPRINTK("request check condition\n");
-
-		cmd->result = SAM_STAT_CHECK_CONDITION;
-
-		qc->scsidone(cmd);
-
-		return 1;
+		DPRINTK("generate atapi sense\n");
+		ata_gen_atapi_sense(qc);
  	} else {
  		u8 *scsicmd = cmd->cmnd;
