From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] sata_sil: cosmetic flag/constant changes
Date: Sun, 5 Mar 2006 16:03:52 +0900
Message-ID: <11415422321767-git-send-email-htejun@gmail.com>
References: <11415422323592-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:50968 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752082AbWCEHEB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:04:01 -0500
Received: by zproxy.gmail.com with SMTP id i1so1015421nzh
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:04:00 -0800 (PST)
In-Reply-To: <11415422323592-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Collect common host flags into SIL_DFL_HOST_FLAGS and add comments to
constants.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

792d3b8f3bb747b2c359aed4c004c2e42ef18db2
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index fb86e36..56a92a9 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -49,14 +49,30 @@
 #define DRV_VERSION	"0.9"
 
 enum {
+	/*
+	 * host flags
+	 */
 	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
+	SIL_DFL_HOST_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
 
+	/*
+	 * Controller IDs
+	 */
 	sil_3112		= 0,
 	sil_3512		= 1,
 	sil_3114		= 2,
 
+	/*
+	 * Register offsets
+	 */
 	SIL_SYSCFG		= 0x48,
+
+	/*
+	 * Register bits
+	 */
+	/* SYSCFG */
 	SIL_MASK_IDE0_INT	= (1 << 22),
 	SIL_MASK_IDE1_INT	= (1 << 23),
 	SIL_MASK_IDE2_INT	= (1 << 24),
@@ -65,7 +81,12 @@ enum {
 	SIL_MASK_4PORT		= SIL_MASK_2PORT |
 				  SIL_MASK_IDE2_INT | SIL_MASK_IDE3_INT,
 
+	/* BMDMA/BMDMA2 */
 	SIL_INTR_STEERING	= (1 << 1),
+
+	/*
+	 * Others
+	 */
 	SIL_QUIRK_MOD15WRITE	= (1 << 0),
 	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
@@ -168,8 +189,7 @@ static const struct ata_port_info sil_po
 	/* sil_3112 */
 	{
 		.sht		= &sil_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | SIL_FLAG_MOD15WRITE,
+		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -178,9 +198,7 @@ static const struct ata_port_info sil_po
 	/* sil_3512 */
 	{
 		.sht		= &sil_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO |
-				  SIL_FLAG_RERR_ON_DMA_ACT,
+		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -189,9 +207,7 @@ static const struct ata_port_info sil_po
 	/* sil_3114 */
 	{
 		.sht		= &sil_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO |
-				  SIL_FLAG_RERR_ON_DMA_ACT,
+		.host_flags	= SIL_DFL_HOST_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
-- 
1.2.1


