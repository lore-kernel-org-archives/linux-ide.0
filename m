From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata:upstream] remove compiler warnings
Date: Mon, 22 Aug 2005 18:11:29 +0900
Message-ID: <20050822091129.GA15373@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:1929 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751391AbVHVWYG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:24:06 -0400
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M9CpW1008554
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 02:12:52 -0700
Received: by wproxy.gmail.com with SMTP id i20so924629wra
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 02:11:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

 Hello, Jeff.

 This patch removes compiler warnings which are caused by using
ioports values (unsigned long) for the address argument of
read/write[bwl]() functions without casting.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -103,26 +103,31 @@ static void k2_sata_tf_load(struct ata_p
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, ioaddr->ctl_addr);
+		writeb(tf->ctl, (void __iomem *)ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		u16 feature = tf->feature | (((u16)tf->hob_feature) << 8);
+		u16 nsect = tf->nsect | (((u16)tf->hob_nsect) << 8);
+		u16 lbal = tf->lbal | (((u16)tf->hob_lbal) << 8);
+		u16 lbam = tf->lbam | (((u16)tf->hob_lbam) << 8);
+		u16 lbah = tf->lbah | (((u16)tf->hob_lbah) << 8);
+		writew(feature, (void __iomem *)ioaddr->feature_addr);
+		writew(nsect, (void __iomem *)ioaddr->nsect_addr);
+		writew(lbal, (void __iomem *)ioaddr->lbal_addr);
+		writew(lbam, (void __iomem *)ioaddr->lbam_addr);
+		writew(lbah, (void __iomem *)ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void __iomem *)ioaddr->feature_addr);
+		writew(tf->nsect, (void __iomem *)ioaddr->nsect_addr);
+		writew(tf->lbal, (void __iomem *)ioaddr->lbal_addr);
+		writew(tf->lbam, (void __iomem *)ioaddr->lbam_addr);
+		writew(tf->lbah, (void __iomem *)ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void __iomem *)ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -133,14 +138,14 @@ static void k2_sata_tf_read(struct ata_p
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah;
 
-	nsect = tf->nsect = readw(ioaddr->nsect_addr);
-	lbal = tf->lbal = readw(ioaddr->lbal_addr);
-	lbam = tf->lbam = readw(ioaddr->lbam_addr);
-	lbah = tf->lbah = readw(ioaddr->lbah_addr);
-	tf->device = readw(ioaddr->device_addr);
+	nsect = tf->nsect = readw((void __iomem *)ioaddr->nsect_addr);
+	lbal = tf->lbal = readw((void __iomem *)ioaddr->lbal_addr);
+	lbam = tf->lbam = readw((void __iomem *)ioaddr->lbam_addr);
+	lbah = tf->lbah = readw((void __iomem *)ioaddr->lbah_addr);
+	tf->device = readw((void __iomem *)ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
+		tf->hob_feature = readw((void __iomem *)ioaddr->error_addr) >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -81,10 +81,10 @@ static void vsc_sata_scr_write (struct a
 
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
 {
-	unsigned long mask_addr;
+	void __iomem *mask_addr;
 	u8 mask;
 
-	mask_addr = (unsigned long) ap->host_set->mmio_base +
+	mask_addr = ap->host_set->mmio_base +
 		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
 	mask = readb(mask_addr);
 	if (ctl & ATA_NIEN)
@@ -110,21 +110,26 @@ static void vsc_sata_tf_load(struct ata_
 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		u16 feature = tf->feature | (((u16)tf->hob_feature) << 8);
+		u16 nsect = tf->nsect | (((u16)tf->hob_nsect) << 8);
+		u16 lbal = tf->lbal | (((u16)tf->hob_lbal) << 8);
+		u16 lbam = tf->lbam | (((u16)tf->hob_lbam) << 8);
+		u16 lbah = tf->lbah | (((u16)tf->hob_lbah) << 8);
+		writew(feature, (void __iomem *)ioaddr->feature_addr);
+		writew(nsect, (void __iomem *)ioaddr->nsect_addr);
+		writew(lbal, (void __iomem *)ioaddr->lbal_addr);
+		writew(lbam, (void __iomem *)ioaddr->lbam_addr);
+		writew(lbah, (void __iomem *)ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void __iomem *)ioaddr->feature_addr);
+		writew(tf->nsect, (void __iomem *)ioaddr->nsect_addr);
+		writew(tf->lbal, (void __iomem *)ioaddr->lbal_addr);
+		writew(tf->lbam, (void __iomem *)ioaddr->lbam_addr);
+		writew(tf->lbah, (void __iomem *)ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void __iomem *)ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -135,14 +140,14 @@ static void vsc_sata_tf_read(struct ata_
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah;
 
-	nsect = tf->nsect = readw(ioaddr->nsect_addr);
-	lbal = tf->lbal = readw(ioaddr->lbal_addr);
-	lbam = tf->lbam = readw(ioaddr->lbam_addr);
-	lbah = tf->lbah = readw(ioaddr->lbah_addr);
-	tf->device = readw(ioaddr->device_addr);
+	nsect = tf->nsect = readw((void __iomem *)ioaddr->nsect_addr);
+	lbal = tf->lbal = readw((void __iomem *)ioaddr->lbal_addr);
+	lbam = tf->lbam = readw((void __iomem *)ioaddr->lbam_addr);
+	lbah = tf->lbah = readw((void __iomem *)ioaddr->lbah_addr);
+	tf->device = readw((void __iomem *)ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readb(ioaddr->error_addr);
+		tf->hob_feature = readb((void __iomem *)ioaddr->error_addr);
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
@@ -251,8 +256,8 @@ static void __devinit vsc_sata_setup_por
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
-	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
-	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
+	writel(0, (void __iomem *)base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
+	writel(0, (void __iomem *)base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
 }
 
 
