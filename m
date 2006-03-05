From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] sata_sil: replace register address constants with sil_port[] entry
Date: Sun, 5 Mar 2006 16:03:52 +0900
Message-ID: <11415422322316-git-send-email-htejun@gmail.com>
References: <11415422323592-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:6945 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752008AbWCEHD5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:03:57 -0500
Received: by zproxy.gmail.com with SMTP id 13so1009548nzn
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:03:56 -0800 (PST)
In-Reply-To: <11415422323592-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill SIL_FIFO_* and SIL_IDE2_BMDMA and replace them with proper
sil_port[] entry.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   39 +++++++++++----------------------------
 1 files changed, 11 insertions(+), 28 deletions(-)

a63a8c77b1ed35894f0d0627ec3942ede40b2290
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index b5401fa..f096cc9 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -56,15 +56,6 @@ enum {
 	sil_3512		= 1,
 	sil_3114		= 2,
 
-	SIL_FIFO_R0		= 0x40,
-	SIL_FIFO_W0		= 0x41,
-	SIL_FIFO_R1		= 0x44,
-	SIL_FIFO_W1		= 0x45,
-	SIL_FIFO_R2		= 0x240,
-	SIL_FIFO_W2		= 0x241,
-	SIL_FIFO_R3		= 0x244,
-	SIL_FIFO_W3		= 0x245,
-
 	SIL_SYSCFG		= 0x48,
 	SIL_MASK_IDE0_INT	= (1 << 22),
 	SIL_MASK_IDE1_INT	= (1 << 23),
@@ -74,8 +65,6 @@ enum {
 	SIL_MASK_4PORT		= SIL_MASK_2PORT |
 				  SIL_MASK_IDE2_INT | SIL_MASK_IDE3_INT,
 
-	SIL_IDE2_BMDMA		= 0x200,
-
 	SIL_INTR_STEERING	= (1 << 1),
 	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
@@ -216,16 +205,17 @@ static const struct {
 	unsigned long tf;	/* ATA taskfile register block */
 	unsigned long ctl;	/* ATA control/altstatus register block */
 	unsigned long bmdma;	/* DMA register block */
+	unsigned long fifo_cfg;	/* FIFO Valid Byte Count and Control */
 	unsigned long scr;	/* SATA control register block */
 	unsigned long sien;	/* SATA Interrupt Enable register */
 	unsigned long xfer_mode;/* data transfer mode register */
 	unsigned long sfis_cfg;	/* SATA FIS reception config register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4, 0x14c },
-	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4, 0x1cc },
-	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4, 0x34c },
-	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4, 0x3cc },
+	{ 0x80, 0x8A, 0x00, 0x40, 0x100, 0x148, 0xb4, 0x14c },
+	{ 0xC0, 0xCA, 0x08, 0x44, 0x180, 0x1c8, 0xf4, 0x1cc },
+	{ 0x280, 0x28A, 0x200, 0x240, 0x300, 0x348, 0x2b4, 0x34c },
+	{ 0x2C0, 0x2CA, 0x208, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
 };
 
@@ -448,19 +438,12 @@ static int sil_init_one (struct pci_dev 
 	if (cls) {
 		cls >>= 3;
 		cls++;  /* cls = (line_size/8)+1 */
-		writeb(cls, mmio_base + SIL_FIFO_R0);
-		writeb(cls, mmio_base + SIL_FIFO_W0);
-		writeb(cls, mmio_base + SIL_FIFO_R1);
-		writeb(cls, mmio_base + SIL_FIFO_W1);
-		if (ent->driver_data == sil_3114) {
-			writeb(cls, mmio_base + SIL_FIFO_R2);
-			writeb(cls, mmio_base + SIL_FIFO_W2);
-			writeb(cls, mmio_base + SIL_FIFO_R3);
-			writeb(cls, mmio_base + SIL_FIFO_W3);
-		}
+		for (i = 0; i < probe_ent->n_ports; i++)
+			writew(cls << 8 | cls,
+			       mmio_base + sil_port[i].fifo_cfg);
 	} else
 		dev_printk(KERN_WARNING, &pdev->dev,
-			 "cache line size not set.  Driver may not function\n");
+			   "cache line size not set.  Driver may not function\n");
 
 	/* Apply R_ERR on DMA activate FIS errata workaround */
 	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
@@ -483,10 +466,10 @@ static int sil_init_one (struct pci_dev 
 		irq_mask = SIL_MASK_4PORT;
 
 		/* flip the magic "make 4 ports work" bit */
-		tmp = readl(mmio_base + SIL_IDE2_BMDMA);
+		tmp = readl(mmio_base + sil_port[2].bmdma);
 		if ((tmp & SIL_INTR_STEERING) == 0)
 			writel(tmp | SIL_INTR_STEERING,
-			       mmio_base + SIL_IDE2_BMDMA);
+			       mmio_base + sil_port[2].bmdma);
 
 	} else {
 		irq_mask = SIL_MASK_2PORT;
-- 
1.2.1


