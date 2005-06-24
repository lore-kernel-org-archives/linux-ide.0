From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata: Fix race condition in ata_pio_task()
Date: Fri, 24 Jun 2005 11:47:54 +0800
Message-ID: <42BB826A.6040209@tw.ibm.com>
References: <42BA775B.1050601@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020101030903000903010801"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:62436 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S263078AbVFXDtt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Jun 2005 23:49:49 -0400
In-Reply-To: <42BA775B.1050601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020101030903000903010801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Jeff,

This is patch 1/2. (The previous subject is incorrect. Resend it here.)
Problem:
    'assert(qc != NULL)' failed in ata_pio_block() and ata_pio_complete().

Root cause:
    Race condition in ata_pio_task() when accessing 'ap->pio_task_state' after ata_qc_complete():
If the next command is queued after ata_qc_complete() and before ata_pio_task() checks 'ap->pio_task_state',
'ap->pio_task_state' might have been changed from PIO_ST_IDLE to PIO_ST by ata_qc_issue_prot().
This will cause ata_pio_task() to run extra steps even if the command is finished.
The extra steps race with the next command and causing trouble.

Changes:
- Let ata_pio_complete() and ata_pio_block() return explicitly whether queuing next step is needed.
- Use the return value to determine whether next step is needed, instead of checking the volatile 'ap->pio_task_state' variable.

Attached please find the patch against the linux-2.6.git tree (HEAD ee98689be1b054897ff17655008c3048fe88be94)
for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------020101030903000903010801
Content-Type: text/plain;
 name="patch1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1.diff"

--- linux-ori/drivers/scsi/libata-core.c	2005-06-23 15:34:21.000000000 +0800
+++ linux/drivers/scsi/libata-core.c	2005-06-23 15:57:16.000000000 +0800
@@ -2455,7 +2455,7 @@
  *	None.  (executing in kernel thread context)
  */
 
-static void ata_pio_complete (struct ata_port *ap)
+static int ata_pio_complete (struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 drv_stat;
@@ -2475,14 +2475,14 @@
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 			ap->pio_task_state = PIO_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
+			return 1; /* queue next step */
 		}
 	}
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		ap->pio_task_state = PIO_ST_ERR;
-		return;
+		return 1; /* queue next step */
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -2493,6 +2493,7 @@
 	ata_irq_on(ap);
 
 	ata_qc_complete(qc, drv_stat);
+	return 0; /* last step */
 }
 
 
@@ -2683,7 +2684,7 @@
  *	None.  (executing in kernel thread context)
  */
 
-static void ata_pio_block(struct ata_port *ap)
+static int ata_pio_block(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 status;
@@ -2703,7 +2704,7 @@
 		if (status & ATA_BUSY) {
 			ap->pio_task_state = PIO_ST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
+			return 1; /* queue next step */
 		}
 	}
 
@@ -2718,7 +2719,7 @@
 			ata_irq_on(ap);
 
 			ata_qc_complete(qc, status);
-			return;
+			return 0; /* last step */
 		}
 
 		atapi_pio_bytes(qc);
@@ -2726,11 +2727,13 @@
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
 			ap->pio_task_state = PIO_ST_ERR;
-			return;
+			return 1; /* queue next step */
 		}
 
 		ata_pio_sector(qc);
 	}
+
+	return 1; /* queue next step */
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -2756,21 +2759,20 @@
 {
 	struct ata_port *ap = _data;
 	unsigned long timeout = 0;
+	int next_step;
 
 	switch (ap->pio_task_state) {
-	case PIO_ST_IDLE:
-		return;
-
 	case PIO_ST:
-		ata_pio_block(ap);
+		next_step = ata_pio_block(ap);
 		break;
 
 	case PIO_ST_LAST:
-		ata_pio_complete(ap);
+		next_step = ata_pio_complete(ap);
 		break;
 
 	case PIO_ST_POLL:
 	case PIO_ST_LAST_POLL:
+		next_step = 1;
 		timeout = ata_pio_poll(ap);
 		break;
 
@@ -2778,11 +2780,26 @@
 	case PIO_ST_ERR:
 		ata_pio_error(ap);
 		return;
+	default:
+		printk(KERN_ERR "Unknown PIO task state %u\n", 
+		       ap->pio_task_state);
+		return;
 	}
 
+	/* Don't access ap->pio_task_state here.
+	 *
+	 * Access ap->pio_task_state here will cause race condition
+	 * between this code path and the ata_qc_issue_prot() code path:
+	 * If ata_qc_complete() has been called above, the SCSI layer 
+	 * might have sent the next command to libata for queuing.
+	 * And ap->pio_task_state might have been changed
+	 * by ata_qc_issue_prot(). 
+	 */
+	if (!next_step)
+		return;
+
 	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task,
-				   timeout);
+		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
 	else
 		queue_work(ata_wq, &ap->pio_task);
 }

--------------020101030903000903010801--


