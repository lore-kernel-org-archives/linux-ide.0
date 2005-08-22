From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata:upstream] fix atapi_packet_task vs. intr race (take 2)
Date: Mon, 22 Aug 2005 14:59:24 +0900
Message-ID: <20050822055924.GA32362@htj.dyndns.org>
References: <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org> <43091BFA.2020101@pobox.com> <20050822035956.GB28721@htj.dyndns.org> <43095156.7080500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:28811 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751482AbVHVWkB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:40:01 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.207])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M60Tq2029335
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 23:00:29 -0700
Received: by rproxy.gmail.com with SMTP id r35so916636rna
        for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 22:59:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <43095156.7080500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

 Hello, Jeff.

 Here's the updated patch.  Though I have a question.  Why always use
spin_lock_irqsave()?  To improve maintainability?

--

 Interrupts from devices sharing the same IRQ could cause
ata_host_intr to finish commands being processed by atapi_packet_task
if the commands are using ATA_PROT_ATAPI_NODATA or ATA_PROT_ATAPI_DMA
protocol.  This is because libata interrupt handler is unaware that
interrupts are not expected during that period.  This patch adds
ATA_FLAG_NOINTR flag to tell the interrupt handler that we're not
expecting interrupts.

 Note that once proper HSM is implemented for interrupt-driven PIO,
this should be merged into it and this flag will be removed.

 ahci.c is a different kind of beast, so it's left alone.

* The following drivers use ata_qc_issue_prot and ata_interrupt, so
  changes in libata core will do.

  ata_piix sata_sil sata_svw sata_via sata_sis sata_uli

* The following drivers use ata_qc_issue_prot and custom intr handler.
  They need this change to work correctly.

  sata_nv sata_vsc

* The following drivers use custom issue function and intr handler.
  Currently all custom issue functions don't support ATAPI, so this
  change is irrelevant, updated for consistency and to avoid later
  mistakes.

  sata_promise sata_qstor sata_sx4

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3218,11 +3218,13 @@ int ata_qc_issue_prot(struct ata_queued_
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
+		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
+		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		queue_work(ata_wq, &ap->packet_task);
@@ -3576,7 +3578,8 @@ irqreturn_t ata_interrupt (int irq, void
 		struct ata_port *ap;
 
 		ap = host_set->ports[i];
-		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -3628,19 +3631,27 @@ static void atapi_packet_task(void *_dat
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
+		unsigned long flags;
+
+		/* Once we're done issuing command and kicking bmdma,
+		 * irq handler takes over.  To not lose irq, we need
+		 * to clear NOINTR flag before sending cdb, but
+		 * interrupt handler shouldn't be invoked before we're
+		 * finished.  Hence, the following locking.
+		 */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ap->flags &= ~ATA_FLAG_NOINTR;
+		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
+			ap->ops->bmdma_start(qc);	/* initiate bmdma */
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	} else {
+		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
 
-	/* PIO commands are handled by polling */
-	else {
+		/* PIO commands are handled by polling */
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
 	}
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -291,7 +291,8 @@ static irqreturn_t nv_interrupt (int irq
 		struct ata_port *ap;
 
 		ap = host_set->ports[i];
-		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -441,7 +441,8 @@ static irqreturn_t pdc_interrupt (int ir
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
-		if (tmp && ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (tmp && ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -386,7 +386,8 @@ static inline unsigned int qs_intr_pkt(s
 			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
 					sff1, sff0, port_no, sHST, sDST);
 			handled = 1;
-			if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			if (ap && !(ap->flags &
+				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
@@ -417,7 +418,8 @@ static inline unsigned int qs_intr_mmio(
 	for (port_no = 0; port_no < host_set->n_ports; ++port_no) {
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
-		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -825,7 +825,8 @@ static irqreturn_t pdc20621_interrupt (i
 			ap = host_set->ports[port_no];
 		tmp = mask & (1 << i);
 		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
-		if (tmp && ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (tmp && ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -173,7 +173,8 @@ static irqreturn_t vsc_sata_interrupt (i
 			struct ata_port *ap;
 
 			ap = host_set->ports[i];
-			if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			if (ap && !(ap->flags &
+				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -113,6 +113,8 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
+					     * proper HSM is in place. */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
