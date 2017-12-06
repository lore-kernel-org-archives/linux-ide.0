From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v5] pata_pdc2027x: Fix pdc_adjust_pll() to return the error value
Date: Wed,  6 Dec 2017 22:52:54 +0530
Message-ID: <8a90e02cc2ccca6277702b6b7ec8f5ca1f85ba4d.1512580696.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44324 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdLFRXG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2017 12:23:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This change is to ensure that function pdc_adjust_pll() returns the
error value to avoid the unnecessary error check for pdc_hardware_init()
in pdc2027x_reinit_one().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
               Make function return type 'void' instead of 'int.
               Add sapce between ':'.
changes in v3 :
               Fix the checkpatch.pl errors in a sperate patch.
changes in v4 :
               return the error value from pdc_adjust_pll()
changes in v5 :
               remove this empty line (between *return* and }).

 drivers/ata/pata_pdc2027x.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index ffd8d33..81f9178 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -515,7 +515,7 @@ static long pdc_read_counter(struct ata_host *host)
  * @host: target ATA host
  * @pll_clock: The input of PLL in HZ
  */
-static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int board_idx)
+static int pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int board_idx)
 {
 	void __iomem *mmio_base = host->iomap[PDC_MMIO_BAR];
 	u16 pll_ctl;
@@ -527,7 +527,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	/* Sanity check */
 	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
 		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
-		return;
+		return -EINVAL;
 	}
 
 #ifdef PDC_DEBUG
@@ -559,7 +559,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	} else {
 		/* Invalid ratio */
 		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
-		return;
+		return -EINVAL;
 	}
 
 	F = (ratio * (R+2)) / 1000 - 2;
@@ -567,7 +567,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	if (unlikely(F < 0 || F > 127)) {
 		/* Invalid F */
 		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
-		return;
+		return -EINVAL;
 	}
 
 	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
@@ -592,7 +592,7 @@ static void pdc_adjust_pll(struct ata_host *host, long pll_clock, unsigned int b
 	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
 #endif
 
-	return;
+	return 0;
 }
 
 /**
@@ -664,9 +664,7 @@ static int pdc_hardware_init(struct ata_host *host, unsigned int board_idx)
 	dev_info(host->dev, "PLL input clock %ld kHz\n", pll_clock/1000);
 
 	/* Adjust PLL control register */
-	pdc_adjust_pll(host, pll_clock, board_idx);
-
-	return 0;
+	return pdc_adjust_pll(host, pll_clock, board_idx);
 }
 
 /**
-- 
2.7.4

