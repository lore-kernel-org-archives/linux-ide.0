From: Pat LaVarre <p.lavarre@ieee.org>
Subject: [PATCH] libata SATAPI no data
Date: 26 May 2004 15:41:55 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085607715.4148.128.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:14299 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265816AbUEZVl6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 May 2004 17:41:58 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> Subject: Re: [PATCH] atapi request sense work
> ...
> I'll try naming the fragment of code that
> fetches the host_stat so I can concisely say
> do that only when appropriate.

As discussed previously, we need a patch to make SATAPI work when the
device agrees to actually copy no data without error, quite apart from
us making auto sense work in the "[PATCH] atapi request sense work"
thread.

Do you like this conceptually trivial patch?  I name this
satapi.hn.patch.  I think its essence is:

@@ -2650,11 +2658,14 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_NODATA:
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		host_stat = ata_check_bmdma(ap);
+		DPRINTK("BUS_NODATA (host_stat 0x%X)\n", host_stat);
+		ata_dma_complete(qc, host_stat);

Here I chose { inline } over { static inline } because lately I saw you
counting libata.ko bytes.

Here I chose u8 over int because lxr.linux.no/source/ suggests Linux
readb and inb return u8.

Here I chose DPRINTK over VPRINTK to match the choices nearby.

Here I haven't yet seen the { DPRINTK("irq trappable\n"); } trigger
fire.

I'm not especially surprised to discover that PCI IDE BMDMA seemingly
passes back a PCI interrupt whenever it catches an IDE interrupt, no
matter if DMA was recently in progress or not, but I also haven't found
a datasheet to tell me explicitly to expect that behaviour.

Pat LaVarre

P.S.

diff -b within the patch assures me I did delete two occurrences of five
source lines and substitute two calls and a third new call to those same
five lines.

(To my newbie surprise, I find I cannot easily compare binary to prove
some of my change has no substantive effect.  Instead I find inserting
blank lines changes the libata.ko binary, even if I think to turn off
ATA_VERBOSE_DEBUG and ATA_DEBUG.)

diff -Nurp linux-2.6.7-rc1-bk3/drivers/scsi/libata-core.c linux-2.6.7-rc1-bk3-pel/drivers/scsi/libata-core.c
--- linux-2.6.7-rc1-bk3/drivers/scsi/libata-core.c	2004-05-25 14:47:00.000000000 -0600
+++ linux-2.6.7-rc1-bk3-pel/drivers/scsi/libata-core.c	2004-05-26 15:35:31.512139768 -0600
@@ -2146,6 +2146,22 @@ static void ata_pio_task(void *_data)
 }
 
 /**
+ *	ata_check_bmdma - read PCI IDE BMDMA status
+ *	@ap: struct ata_port
+ */
+
+static u8 ata_check_bmdma(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
+}
+
+/**
  *	ata_eng_timeout - Handle timeout of queued command
  *	@ap: Port on which timed-out command is active
  *
@@ -2188,11 +2204,7 @@ void ata_eng_timeout(struct ata_port *ap
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		host_stat = ata_check_bmdma(ap);
 
 		printk(KERN_ERR "ata%u: DMA timeout, stat 0x%x\n",
 		       ap->id, host_stat);
@@ -2622,11 +2634,7 @@ inline unsigned int ata_host_intr (struc
 	/* BMDMA completion */
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		host_stat = ata_check_bmdma(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
 
 		if (!(host_stat & ATA_DMA_INTR)) {
@@ -2650,11 +2658,14 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_NODATA:
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		host_stat = ata_check_bmdma(ap);
+		DPRINTK("BUS_NODATA (host_stat 0x%X)\n", host_stat);
+		ata_dma_complete(qc, host_stat);
 		handled = 1;
 		break;
 
 	default:
+		DPRINTK("irq trappable\n");
 		ap->stats.idle_irq++;
 
 #ifdef ATA_IRQ_TRAP
diff -Nurp linux-2.6.7-rc1-bk3/drivers/scsi/libata-scsi.c linux-2.6.7-rc1-bk3-pel/drivers/scsi/libata-scsi.c


