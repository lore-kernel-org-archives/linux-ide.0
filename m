From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 01/02] libata: implement ata_poll_qc_complete and use it in polling functions
Date: Sat, 20 Aug 2005 23:15:34 +0900 (KST)
Message-ID: <20050820141408.5788A466@htj.dyndns.org>
References: <20050820141408.62050C34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.200]:7258 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751242AbVHTOPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 10:15:42 -0400
Received: by wproxy.gmail.com with SMTP id i2so779770wra
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 07:15:39 -0700 (PDT)
In-Reply-To: <20050820141408.62050C34@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

01_libata_add-ata_poll_qc_complete.patch

	Previously, libata polling functions turned irq back on and
	completed qc commands without holding host lock.  This creates
	a race condition between the polling task and interrupts from
	other ports on the same host set or spurious interrupt from
	itself.

	This patch implements ata_poll_qc_complete which enables irq
	and completes qc atomically and convert all polling functions.

	Note: Unlike other functions, atapi_packet_task() didn't use
	to turn irq back on on error exits.  This patch makes it use
	ata_poll_qc_complete, so irq is now turned back on on error
	exits.

	Note: With this change, ALL invocations of ata_qc_complete()
	are now done under host_set lock.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 libata-core.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-08-20 23:13:40.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-08-20 23:13:40.000000000 +0900
@@ -2402,6 +2402,24 @@ static int ata_sg_setup(struct ata_queue
 }
 
 /**
+ *	ata_poll_qc_complete - turn irq back on and finish qc
+ *	@qc: Command to complete
+ *	@drv_stat: ATA status register content
+ *
+ *	LOCKING:
+ *	None.  (grabs host lock)
+ */
+void ata_poll_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct ata_port *ap = qc->ap;
+
+	spin_lock_irq(&ap->host_set->lock);
+	ata_irq_on(ap);
+	ata_qc_complete(qc, drv_stat);
+	spin_unlock_irq(&ap->host_set->lock);
+}
+
+/**
  *	ata_pio_poll -
  *	@ap:
  *
@@ -2492,9 +2510,7 @@ static void ata_pio_complete (struct ata
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
-	ata_irq_on(ap);
-
-	ata_qc_complete(qc, drv_stat);
+	ata_poll_qc_complete(qc, drv_stat);
 }
 
 
@@ -2717,9 +2733,7 @@ static void ata_pio_block(struct ata_por
 		if ((status & ATA_DRQ) == 0) {
 			ap->pio_task_state = PIO_ST_IDLE;
 
-			ata_irq_on(ap);
-
-			ata_qc_complete(qc, status);
+			ata_poll_qc_complete(qc, status);
 			return;
 		}
 
@@ -2749,9 +2763,7 @@ static void ata_pio_error(struct ata_por
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
-	ata_irq_on(ap);
-
-	ata_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
 }
 
 static void ata_pio_task(void *_data)
@@ -3656,7 +3668,7 @@ static void atapi_packet_task(void *_dat
 	return;
 
 err_out:
-	ata_qc_complete(qc, ATA_ERR);
+	ata_poll_qc_complete(qc, ATA_ERR);
 }
 
 

