From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 02/02] atapi: fix atapi_packet_task vs. ata_host_intr race
Date: Sat, 20 Aug 2005 18:17:32 +0900 (KST)
Message-ID: <20050820091651.0C7C50B9@htj.dyndns.org>
References: <20050820091651.486821E0@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.204]:60235 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVHTJRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 05:17:39 -0400
Received: by rproxy.gmail.com with SMTP id i8so664544rne
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 02:17:37 -0700 (PDT)
In-Reply-To: <20050820091651.486821E0@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

02_atapi_fix-atapi_packet_task-race.patch

	Protect ATAPI_NODATA and ATAPI_DMA commands from being
	finished by ata_host_intr before atapi_packet_task is done w/
	the commands.  Previously, such ATAPI commands could have been
	completed by interrupts from other ports in the same host_set
	or by spurious interrupt, making atapi_packet_task access
	already finished commands.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 libata-core.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-08-20 18:12:30.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-08-20 18:16:49.000000000 +0900
@@ -3218,11 +3218,13 @@ int ata_qc_issue_prot(struct ata_queued_
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
+		ata_qc_set_polling(qc);
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
+		ata_qc_set_polling(qc);
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		queue_work(ata_wq, &ap->packet_task);
@@ -3580,8 +3582,8 @@ irqreturn_t ata_interrupt (int irq, void
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
-			    (qc->flags & ATA_QCFLAG_ACTIVE))
+			if ((!(ap->last_ctl & ATA_NIEN)) &&
+			    qc && (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
 	}
@@ -3628,19 +3630,25 @@ static void atapi_packet_task(void *_dat
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
 	assert(ap->cdb_len >= 12);
-	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
 
-	/* if we are DMA'ing, irq handler takes over from here */
-	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
-
-	/* non-data commands are also handled via irq */
-	else if (qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
-		/* do nothing */
-	}
+	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
+	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
+		/* Once we're done issuing command and kicking bmdma,
+		 * irq handler takes over.  To not lose irq, we need
+		 * to enable irq before sending cdb, but interrupt
+		 * handler shouldn't be invoked before we're finished.
+		 * Hence, the following locking.
+		 */
+		spin_lock_irq(&ap->host_set->lock);
+		ata_irq_on(ap);
+		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
+			ap->ops->bmdma_start(qc);	/* initiate bmdma */
+		spin_unlock_irq(&ap->host_set->lock);
+	} else {
+		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
 
-	/* PIO commands are handled by polling */
-	else {
+		/* PIO commands are handled by polling */
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
 	}

