From: Richard Knutsson <ricknu-0@student.ltu.se>
Subject: [PATCH 2.6.15-rc2-mm1] scsi: fix compiler-warning for sata_vsc.c
Date: Sun, 27 Nov 2005 00:36:16 +0100
Message-ID: <4388F170.9050703@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:1702 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S1750784AbVKZXaz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Nov 2005 18:30:55 -0500
Received: from [130.240.205.31] (thinktank.campus.luth.se [130.240.205.31])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id jAQNUrDT028221
	for <linux-ide@vger.kernel.org>; Sun, 27 Nov 2005 00:30:54 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Fix compiler-warning "... makes pointer from integer without a cast".

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
Jeremy Higdon, sorry but I couldn't find your mail-address.

 sata_vsc.c |   67 ++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 36 insertions(+), 31 deletions(-)

--- a/drivers/scsi/sata_vsc.c	2005-11-26 23:10:56.000000000 +0100
+++ b/drivers/scsi/sata_vsc.c	2005-11-26 23:41:53.000000000 +0100
@@ -130,21 +130,26 @@ static void vsc_sata_tf_load(struct ata_
 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8),
+		       (void *) ioaddr->feature_addr);
+		writew(tf->nsect   | (((u16)tf->hob_nsect) << 8),
+		       (void *) ioaddr->nsect_addr);
+		writew(tf->lbal    | (((u16)tf->hob_lbal) << 8),
+		       (void *) ioaddr->lbal_addr);
+		writew(tf->lbam    | (((u16)tf->hob_lbam) << 8),
+		       (void *) ioaddr->lbam_addr);
+		writew(tf->lbah    | (((u16)tf->hob_lbah) << 8),
+		       (void *) ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature,	(void *) ioaddr->feature_addr);
+		writew(tf->nsect,	(void *) ioaddr->nsect_addr);
+		writew(tf->lbal,	(void *) ioaddr->lbal_addr);
+		writew(tf->lbam,	(void *) ioaddr->lbam_addr);
+		writew(tf->lbah,	(void *) ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device,	(void *) ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -155,26 +160,26 @@ static void vsc_sata_tf_read(struct ata_
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah, feature;
 
-	tf->command = ata_check_status(ap);
-	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
-	nsect = readw(ioaddr->nsect_addr);
-	lbal = readw(ioaddr->lbal_addr);
-	lbam = readw(ioaddr->lbam_addr);
-	lbah = readw(ioaddr->lbah_addr);
-
-	tf->feature = feature;
-	tf->nsect = nsect;
-	tf->lbal = lbal;
-	tf->lbam = lbam;
-	tf->lbah = lbah;
+	tf->command	= ata_check_status(ap);
+	tf->device	= readw((void *) ioaddr->device_addr);
+	feature		= readw((void *) ioaddr->error_addr);
+	nsect		= readw((void *) ioaddr->nsect_addr);
+	lbal		= readw((void *) ioaddr->lbal_addr);
+	lbam		= readw((void *) ioaddr->lbam_addr);
+	lbah		= readw((void *) ioaddr->lbah_addr);
+
+	tf->feature	= feature;
+	tf->nsect	= nsect;
+	tf->lbal	= lbal;
+	tf->lbam	= lbam;
+	tf->lbah	= lbah;
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = feature >> 8;
-		tf->hob_nsect = nsect >> 8;
-		tf->hob_lbal = lbal >> 8;
-		tf->hob_lbam = lbam >> 8;
-		tf->hob_lbah = lbah >> 8;
+		tf->hob_feature	= feature >> 8;
+		tf->hob_nsect	= nsect >> 8;
+		tf->hob_lbal	= lbal >> 8;
+		tf->hob_lbam	= lbam >> 8;
+		tf->hob_lbah	= lbah >> 8;
         }
 }
 
@@ -280,8 +285,8 @@ static void __devinit vsc_sata_setup_por
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
-	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
-	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
+	writel(0, (void *) base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
+	writel(0, (void *) base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
 }
 
 


