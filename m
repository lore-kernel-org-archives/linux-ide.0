From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] sata_sil: implement R_ERR on DMA activate FIS errata fix
Date: Sat, 25 Feb 2006 13:30:46 +0900
Message-ID: <11408418461209-git-send-email-htejun@gmail.com>
References: <1140841846157-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:6934 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932666AbWBYE3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 23:29:41 -0500
Received: by zproxy.gmail.com with SMTP id 8so474264nzo
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 20:29:40 -0800 (PST)
In-Reply-To: <1140841846157-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Silicon Image has disclosed a new sil3114/3152 errata and workaround
which causes the controller to return R_ERR on DMA activate FIS if the
FIS is received while the next PRD is being fetched.  This patch
implements the workaround.

This errata results in lock up and doesn't trigger if m15w workaround
is in effect.  We stopped applying m15w to 3512 and 3114 in 2.6.14-rc1
which makes 3512/3114 lock up with some drives on all kernel versions
since 2.6.14-rc1 upto now (2.6.16-rc4).  This patch should fix the
regression.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

e2a8f0212f3532a92dfd6160f924c46316a30270
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 510c2e0..9face3c 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -49,6 +49,7 @@
 #define DRV_VERSION	"0.9"
 
 enum {
+	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	sil_3112		= 0,
@@ -202,7 +203,8 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -212,7 +214,8 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -229,12 +232,13 @@ static const struct {
 	unsigned long scr;	/* SATA control register block */
 	unsigned long sien;	/* SATA Interrupt Enable register */
 	unsigned long xfer_mode;/* data transfer mode register */
+	unsigned long sfis_cfg;	/* SATA FIS reception config register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
-	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
-	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
-	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
+	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4, 0x14c },
+	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4, 0x1cc },
+	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4, 0x34c },
+	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
 };
 
@@ -484,6 +488,23 @@ static int sil_init_one (struct pci_dev 
 		dev_printk(KERN_WARNING, &pdev->dev,
 			 "cache line size not set.  Driver may not function\n");
 
+	/* Apply R_ERR on DMA activate FIS errata workaround */
+	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+		int cnt;
+
+		for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
+			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
+			if ((tmp & 0x3) != 0x01)
+				continue;
+			if (!cnt)
+				dev_printk(KERN_INFO, &pdev->dev,
+					   "Applying R_ERR on DMA activate "
+					   "FIS errata fix\n");
+			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
+			cnt++;
+		}
+	}
+
 	if (ent->driver_data == sil_3114) {
 		irq_mask = SIL_MASK_4PORT;
 
-- 
1.2.1


