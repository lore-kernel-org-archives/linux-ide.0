From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 01/02] libata: implement ata_poll_qc_complete and use it in polling functions
Date: Mon, 22 Aug 2005 17:12:45 +0900
Message-ID: <20050822081245.GA3252@htj.dyndns.org>
References: <20050820141408.62050C34@htj.dyndns.org> <20050820141408.5788A466@htj.dyndns.org> <4308DBD6.80208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:29577 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751448AbVHVW00 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:26:26 -0400
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M8Dtjn029169
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 01:13:55 -0700
Received: by zproxy.gmail.com with SMTP id i11so641040nzh
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 01:12:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4308DBD6.80208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Aug 21, 2005 at 03:53:58PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >01_libata_add-ata_poll_qc_complete.patch
> >
> >	Previously, libata polling functions turned irq back on and
> >	completed qc commands without holding host lock.  This creates
> >	a race condition between the polling task and interrupts from
> >	other ports on the same host set or spurious interrupt from
> >	itself.
> >
> >	This patch implements ata_poll_qc_complete which enables irq
> >	and completes qc atomically and convert all polling functions.
> >
> >	Note: Unlike other functions, atapi_packet_task() didn't use
> >	to turn irq back on on error exits.  This patch makes it use
> >	ata_poll_qc_complete, so irq is now turned back on on error
> >	exits.
> >
> >	Note: With this change, ALL invocations of ata_qc_complete()
> >	are now done under host_set lock.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> This one looks OK to me.  Given that I rejected the other three, would 
> you still like me to apply just this one?
> 

 Greetings, Jeff.  (Hello is getting a bit old today :-)

 Here's updated version which also clears ATA_FLAG_NOINTR.

--

[PATCH libata-dev-2.6:upstream] implement ata_poll_qc_complete and use it in polling functions

 Previously, libata polling functions turned irq back on and completed
qc commands without holding host lock.  This creates a race condition
between the polling task and interrupts from other ports on the same
host set or spurious interrupt from itself.

 This patch implements ata_poll_qc_complete which enables irq and
completes qc atomically and convert all polling functions.

 Note: atapi_packet_task() didn't use to turn irq back on or clear
ATA_FLAG_NOINTR on error exits.  This patch makes it use
ata_poll_qc_complete which does both.

 Note: With this change, ALL invocations of ata_qc_complete() are now
done under host_set lock.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2402,6 +2402,26 @@ static int ata_sg_setup(struct ata_queue
 }
 
 /**
+ *	ata_poll_qc_complete - turn irq back on and finish qc
+ *	@qc: Command to complete
+ *	@drv_stat: ATA status register content
+ *
+ *	LOCKING:
+ *	None.  (grabs host lock)
+ */
+
+void ata_poll_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct ata_port *ap = qc->ap;
+
+	spin_lock_irq(&ap->host_set->lock);
+	ap->flags &= ~ATA_FLAG_NOINTR;
+	ata_irq_on(ap);
+	ata_qc_complete(qc, drv_stat);
+	spin_unlock_irq(&ap->host_set->lock);
+}
+
+/**
  *	ata_pio_poll -
  *	@ap:
  *
@@ -2492,9 +2512,7 @@ static void ata_pio_complete (struct ata
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
-	ata_irq_on(ap);
-
-	ata_qc_complete(qc, drv_stat);
+	ata_poll_qc_complete(qc, drv_stat);
 }
 
 
@@ -2717,9 +2735,7 @@ static void ata_pio_block(struct ata_por
 		if ((status & ATA_DRQ) == 0) {
 			ap->pio_task_state = PIO_ST_IDLE;
 
-			ata_irq_on(ap);
-
-			ata_qc_complete(qc, status);
+			ata_poll_qc_complete(qc, status);
 			return;
 		}
 
@@ -2749,9 +2765,7 @@ static void ata_pio_error(struct ata_por
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
-	ata_irq_on(ap);
-
-	ata_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
 }
 
 static void ata_pio_task(void *_data)
@@ -3659,7 +3673,7 @@ static void atapi_packet_task(void *_dat
 	return;
 
 err_out:
-	ata_qc_complete(qc, ATA_ERR);
+	ata_poll_qc_complete(qc, ATA_ERR);
 }
 
 
