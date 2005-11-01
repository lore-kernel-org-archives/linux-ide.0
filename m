From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 4/4] irq-pio: add read/write multiple support
Date: Tue, 01 Nov 2005 19:33:20 +0800
Message-ID: <43675280.2050400@tw.ibm.com>
References: <43674D9A.9010007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:48301 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750755AbVKALdX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 06:33:23 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jA1BXHCo009260
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 06:33:17 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id jA1BXHfJ480744
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:33:17 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jA1BXGq0032117
	for <linux-ide@vger.kernel.org>; Tue, 1 Nov 2005 04:33:17 -0700
In-Reply-To: <43674D9A.9010007@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

patch 4/4: 
  add read/write multiple support

Changes:
   - add is_multi_taskfile() to ata.h
   - initialize ata_device->multi_count with device identify data
   - use ata_pio_sectors() to support r/w multiple commands

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

========

--- linux-ori/include/linux/ata.h	2005-11-01 17:22:45.000000000 +0800
+++ id4/include/linux/ata.h	2005-11-01 18:27:08.000000000 +0800
@@ -293,6 +293,14 @@ static inline int is_atapi_taskfile(cons
 	       (tf->protocol == ATA_PROT_ATAPI_DMA);
 }
 
+static inline int is_multi_taskfile(struct ata_taskfile *tf)
+{
+	return (tf->command == ATA_CMD_READ_MULTI) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI) ||
+	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
+	       (tf->command == ATA_CMD_WRITE_MULTI_EXT);
+}
+
 static inline int ata_ok(u8 status)
 {
 	return ((status & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ | ATA_ERR))
--- id3/drivers/scsi/libata-core.c	2005-11-01 18:45:50.000000000 +0800
+++ id4/drivers/scsi/libata-core.c	2005-11-01 18:36:08.000000000 +0800
@@ -1261,6 +1261,12 @@ retry:
 
 		}
 
+		if (dev->id[59] & 0x100) {
+			dev->multi_count = dev->id[59] & 0xff;
+			DPRINTK("ata%u: dev %u multi count %u\n",
+				ap->id, device, dev->multi_count);
+		}
+
 		ap->host->max_cmd_len = 16;
 	}
 
@@ -2711,7 +2717,7 @@ static int ata_pio_complete (struct ata_
 	 * we enter, BSY will be cleared in a chk-status or two.  If not,
 	 * the drive is probably seeking or something.  Snooze for a couple
 	 * msecs, then chk-status again.  If still busy, fall back to
-	 * HSM_ST_POLL state.
+	 * HSM_ST_LAST_POLL state.
 	 */
 	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
 	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
@@ -2928,6 +2934,32 @@ static void ata_pio_sector(struct ata_qu
 }
 
 /**
+ *	ata_pio_sectors - Transfer one or many 512-byte sectors.
+ *	@qc: Command on going
+ *
+ *	Transfer one or many ATA_SECT_SIZE of data from/to the 
+ *	ATA device for the DRQ request.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+static void ata_pio_sectors(struct ata_queued_cmd *qc)
+{
+	if (is_multi_taskfile(&qc->tf)) {
+		/* READ/WRITE MULTIPLE */
+		unsigned int nsect;
+
+		assert(qc->dev->multi_count);
+
+		nsect = min(qc->nsect - qc->cursect, qc->dev->multi_count);
+		while (nsect--)
+			ata_pio_sector(qc);
+	} else
+		ata_pio_sector(qc);
+}
+
+/**
  *	atapi_send_cdb - Write CDB bytes to hardware
  *	@ap: Port to which ATAPI device is attached.
  *	@qc: Taskfile currently active
@@ -3025,11 +3057,11 @@ static int ata_pio_first_block(struct at
 		 * send first data block.
 		 */
 
-		/* ata_pio_sector() might change the state to HSM_ST_LAST.
-		 * so, the state is changed here before ata_pio_sector().
+		/* ata_pio_sectors() might change the state to HSM_ST_LAST.
+		 * so, the state is changed here before ata_pio_sectors().
 		 */
 		ap->hsm_task_state = HSM_ST;
-		ata_pio_sector(qc);
+		ata_pio_sectors(qc);
 		ata_altstatus(ap); /* flush */
 	} else
 		/* send CDB */
@@ -3234,7 +3266,7 @@ static void ata_pio_block(struct ata_por
 			return;
 		}
 
-		ata_pio_sector(qc);
+		ata_pio_sectors(qc);
 	}
 
 	ata_altstatus(ap); /* flush */
@@ -4120,7 +4152,7 @@ fsm_start:
 				goto fsm_start;
 			}
 
-			ata_pio_sector(qc);
+			ata_pio_sectors(qc);
 
 			if (ap->hsm_task_state == HSM_ST_LAST &&
 			    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {


