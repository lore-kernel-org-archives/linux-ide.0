From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 02 Jun 2004 16:36:48 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086215808.16228.6.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org><1085930101.3135.
	4.camel@patibmrh9>  <1086019779.3144.6.camel@patibmrh9><1086134487.12245.0.
	camel@patibmrh9>  <1086209532.8016.2.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:43221 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264922AbUFBWgx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 18:36:53 -0400
In-Reply-To: <1086209532.8016.2.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

[At last, a small success ...]

Yes despite SATAPI we can appear to have in'ned & out'ted task file
registers.

The following bench patch yields the dmesg:

ata_host_intr: BUS_DMA (host_stat 0x24)
xdump: x 06 00 00 00 06 08 00 00 00 00 00 05 00 00 00 00 A0 A0 00 00
ata_host_intr: tf_load
ata_tf_load_pio: feat 0x5 nsect 0x0 lba 0x0 0x33 0x44
ata_tf_load_pio: device 0xA0
ata_host_intr: tf_read
xdump: x 06 00 00 00 06 08 00 00 00 00 00 05 00 00 33 44 A0 A0 00 00
ata_dma_complete: ENTER

That plain hex is an include/linux/ata.h struct ata_taskfile.

The x 05 00 00 33 44 A0 fragment corresponds to the registers that
PATAPI made visible, leading with the x05 DMA IN of DMADIR DMA, ending
with the xA0 select of Device 0, showing the x33:44 alteration.

Pat LaVarre

diff -urp o/include/linux/ata.h linux-2.6.7-rc2-pel/include/linux/ata.h
diff -urp o/include/linux/libata.h linux-2.6.7-rc2-pel/include/linux/libata.h
diff -urp o/drivers/scsi/libata-core.c linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c
--- o/drivers/scsi/libata-core.c	2004-05-30 08:53:41.000000000 -0600
+++ linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c	2004-06-02 16:08:45.742595728 -0600
@@ -2608,6 +2608,22 @@ static void ata_dma_complete(struct ata_
 }
 
 /**
+ */
+
+static void xdump(void * vo, int length)
+{
+	unsigned char * uchars = vo;
+	char chars[123];
+	int to = sprintf(chars, "x");
+	int from;
+	for (from = 0; from < length; ++from) {
+		if (((sizeof chars) - to) < 4) break;
+		to += sprintf(&chars[to], " %02X", uchars[from]);
+	}
+	VPRINTK("%s\n", chars);
+}
+
+/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -2636,6 +2652,17 @@ inline unsigned int ata_host_intr (struc
 	case ATA_PROT_ATAPI_DMA:
 		host_stat = ata_check_bmdma(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
+do {
+		struct ata_taskfile * tf = &qc->tf;
+		xdump(tf, sizeof *tf);
+		tf->lbam = 0x33;
+		tf->lbah = 0x44;
+		DPRINTK("tf_load\n");
+		ap->ops->tf_load(ap, tf);
+		DPRINTK("tf_read\n");
+		ap->ops->tf_read(ap, tf);
+		xdump(tf, sizeof *tf);
+} while (0);
 
 		if (!(host_stat & ATA_DMA_INTR)) {
 			ap->stats.idle_irq++;
diff -urp o/drivers/scsi/libata-scsi.c linux-2.6.7-rc2-pel/drivers/scsi/libata-scsi.c


