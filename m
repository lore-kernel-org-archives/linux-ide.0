From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 21 May 2004 18:33:42 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085186021.4510.0.camel@patibmrh9>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pati
	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9> <
	40AE9493.1040701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:33275 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264488AbUEVAdv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 20:33:51 -0400
In-Reply-To: <40AE9493.1040701@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

I recommend we apply the following patch, so that non-data commands no
longer provoke "irq" "nobody cared!".

Open-ioctl-close of /dev/scd$n now mostly works.

(Read/ write still has issues I will report separately.)

Pat LaVarre

diff -Nurp linux-2.6.6-bk8/drivers/scsi/libata-core.c linux-2.6.6-bk8-pel/drivers/scsi/libata-core.c
--- linux-2.6.6-bk8/drivers/scsi/libata-core.c	2004-05-21 09:44:22.000000000 -0600
+++ linux-2.6.6-bk8-pel/drivers/scsi/libata-core.c	2004-05-21 18:17:57.228369336 -0600
@@ -2616,16 +2616,17 @@ inline unsigned int ata_host_intr (struc
 	u8 status, host_stat;
 	unsigned int handled = 0;
 
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+
 	switch (qc->tf.protocol) {
 
 	/* BMDMA completion */
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
 
 		if (!(host_stat & ATA_DMA_INTR)) {
@@ -2648,8 +2649,9 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		DPRINTK("BUS_NODATA (drv_stat 0x%X host_stat 0x%X)\n",
+			status, host_stat);
+		ata_dma_complete(qc, host_stat); /* not ata_qc_complete */
 		handled = 1;
 		break;
 
diff -Nurp linux-2.6.6-bk8/drivers/scsi/libata-scsi.c linux-2.6.6-bk8-pel/drivers/scsi/libata-scsi.c


