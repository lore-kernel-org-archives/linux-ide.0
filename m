From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 18:06:47 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085184407.3289.6.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:5062 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265014AbUEVAGy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 20:06:54 -0400
In-Reply-To: <40AE9493.1040701@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > kernel: ata_host_intr: BUS_NODATA (drv_stat 0x50)
> > kernel: irq 18: nobody cared!
>
> Can you print out the BMDMA status register (often called 'host_stat' in 
> the code)?

Thanks for asking.

> I wonder if that indicates ATA_DMA_INTR for example.

I see ending host_stat = (x20 | ATA_DMA_INTR) same for ATA_PROT_ATAPI as
for ATA_PROT_ATAPI_DMA.  (Next I'll go look to see how hard
ATA_PROT_ATAPI_DMA works to clear that.)

Specifically I see:

kernel: atapi_packet_task: busy wait
kernel: atapi_packet_task: send cdb
kernel: ata_host_intr: (host_stat 0x24)
kernel: ata_host_intr: BUS_NODATA (drv_stat 0x50)
kernel: irq 18: nobody cared!

when I apply the following patch (plus the usual #define's) and then
retry the no data case.

Pat LaVarre

diff -Nurp linux-2.6.6-bk8/drivers/scsi/libata-core.c linux-2.6.6-bk8-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk8/drivers/scsi/libata-core.c	2004-05-21 09:44:22.000000000 -0600
+++ linux-2.6.6-bk8-pel/drivers/scsi/libata-core.c	2004-05-21 17:53:03.000000000 -0600
@@ -2303,6 +2303,9 @@ void ata_qc_complete(struct ata_queued_c
 		ata_sg_clean(qc);
 
 	if (cmd) {
+#if 1 /* pretend good */ 
+		cmd->result = SAM_STAT_GOOD;
+#else /* FIXME: admit lost write data, stale read data, etc. */
 		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ))) {
 			if (is_atapi_taskfile(&qc->tf))
 				cmd->result = SAM_STAT_CHECK_CONDITION;
@@ -2311,6 +2314,7 @@ void ata_qc_complete(struct ata_queued_c
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}
+#endif
 
 		qc->scsidone(cmd);
 	}
@@ -2616,16 +2620,18 @@ inline unsigned int ata_host_intr (struc
 	u8 status, host_stat;
 	unsigned int handled = 0;
 
-	switch (qc->tf.protocol) {
-
-	/* BMDMA completion */
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
 		if (ap->flags & ATA_FLAG_MMIO) {
 			void *mmio = (void *) ap->ioaddr.bmdma_addr;
 			host_stat = readb(mmio + ATA_DMA_STATUS);
 		} else
 			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		VPRINTK("(host_stat 0x%X)\n", host_stat);
+
+	switch (qc->tf.protocol) {
+
+	/* BMDMA completion */
+	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
 
 		if (!(host_stat & ATA_DMA_INTR)) {
diff -Nurp linux-2.6.6-bk8/drivers/scsi/libata-scsi.c linux-2.6.6-bk8-pel/drivers/scsi/libata-scsi.c


