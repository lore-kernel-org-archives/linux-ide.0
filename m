From: Pat LaVarre <p.lavarre@ieee.org>
Subject: [PATCH] ata_check_bmdma
Date: 02 Jun 2004 19:06:05 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086224765.4401.3.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:37109 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265418AbUFCBGL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 21:06:11 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Forwarded per your request.  Patch inline only, not also attached.

-----Forwarded Message-----

From: Pat LaVarre <p.lavarre@ieee.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] atapi request sense work
Date: 27 May 2004 18:13:25 -0600

Jeff G:

> As a first step, ...
> create a patch versus mainline, that does
> nothing but add this function (and uses it)?

Here you go.

"Here I chose { inline } over { static inline } because lately I saw you
counting libata.ko bytes."

"Here I chose u8 over int because lxr.linux.no/source/ suggests Linux
readb and inb return u8."

This patch names the repeated five lines without changing where they are
called.  I have included it inline but not also attached.  I confirmed
the lines repeat via diff -b.  I compiled, linked, cleared unit
attentions by unsolicited sense, read, and wrote.
...

Pat LaVarre

diff -Nurp linux-2.6.7-rc1-bk4/include/linux/ata.h linux-2.6.7-rc1-bk4-pel/include/linux/ata.h
diff -Nurp linux-2.6.7-rc1-bk4/include/linux/libata.h linux-2.6.7-rc1-bk4-pel/include/linux/libata.h
diff -Nurp linux-2.6.7-rc1-bk4/drivers/scsi/libata-core.c linux-2.6.7-rc1-bk4-pel/drivers/scsi/libata-core.c
--- linux-2.6.7-rc1-bk4/drivers/scsi/libata-core.c	2004-05-27 16:40:42.000000000 -0600
+++ linux-2.6.7-rc1-bk4-pel/drivers/scsi/libata-core.c	2004-05-27 17:56:57.192826736 -0600
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
diff -Nurp linux-2.6.7-rc1-bk4/drivers/scsi/libata-scsi.c linux-2.6.7-rc1-bk4-pel/drivers/scsi/libata-scsi.c


