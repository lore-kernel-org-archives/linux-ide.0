From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/2] libata: ata_pio_complete() and ata_pio_block() return
 value
Date: Fri, 02 Sep 2005 23:53:33 +0800
Message-ID: <4318757D.5000705@tw.ibm.com>
References: <43187433.9080204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000905070100090606090600"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.130]:23970 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751510AbVIBPxs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Sep 2005 11:53:48 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j82FrdKL137152
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 11:53:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j82FrvM9252906
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 09:53:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j82Frcbp020661
	for <linux-ide@vger.kernel.org>; Fri, 2 Sep 2005 09:53:39 -0600
In-Reply-To: <43187433.9080204@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>

This is a multi-part message in MIME format.
--------------000905070100090606090600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

PATCH 1/2:
Modify ata_pio_complete() and ata_pio_block() to return
whether qc has been completed.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------000905070100090606090600
Content-Type: text/plain;
 name="pio1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pio1.diff"

--- linux/drivers/scsi/libata-core.c.ori	2005-09-02 17:59:15.000000000 +0800
+++ pio1/drivers/scsi/libata-core.c	2005-09-02 18:37:26.000000000 +0800
@@ -2461,9 +2461,12 @@
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
+ *
+ *	RETURNS:
+ *	Zero if qc completed, non-zero otherwise.
  */
 
-static void ata_pio_complete (struct ata_port *ap)
+static int ata_pio_complete (struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 drv_stat;
@@ -2482,14 +2485,14 @@
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 			ap->pio_task_state = PIO_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
+			return 1; /* qc not completed */
 		}
 	}
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		ap->pio_task_state = PIO_ST_ERR;
-		return;
+		return 1; /* qc not completed */
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -2498,6 +2501,7 @@
 	ap->pio_task_state = PIO_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat);
+	return 0; /* qc completed */
 }
 
 
@@ -2813,9 +2817,12 @@
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
+ *
+ *	RETURNS:
+ *	Zero if qc completed, non-zero otherwise.
  */
 
-static void ata_pio_block(struct ata_port *ap)
+static int ata_pio_block(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 status;
@@ -2835,7 +2842,7 @@
 		if (status & ATA_BUSY) {
 			ap->pio_task_state = PIO_ST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
+			return 1; /* qc not completed */
 		}
 	}
 
@@ -2848,7 +2855,7 @@
 			ap->pio_task_state = PIO_ST_IDLE;
 
 			ata_poll_qc_complete(qc, status);
-			return;
+			return 0; /* qc completed */
 		}
 
 		atapi_pio_bytes(qc);
@@ -2856,11 +2863,13 @@
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
 			ap->pio_task_state = PIO_ST_ERR;
-			return;
+			return 1; /* qc not completed */
 		}
 
 		ata_pio_sector(qc);
 	}
+
+	return 1; /* qc not completed */
 }
 
 static void ata_pio_error(struct ata_port *ap)

--------------000905070100090606090600--

