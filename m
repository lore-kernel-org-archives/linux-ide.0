From: Joe Perches <joe@perches.com>
Subject: [PATCH 18/35] drivers/ide: Convert remaining uses of pr_warning to pr_warn
Date: Thu, 16 Feb 2017 23:11:31 -0800
Message-ID: <94a040b80eec22d9d2b5cf929fe06880ab0bc31a.1487314667.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/ide

Prior to this patch, there were 2 uses of pr_warning and
0 uses of pr_warn in drivers/ide

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ide/tx4938ide.c | 2 +-
 drivers/ide/tx4939ide.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 40a3f55b08dd..962eb92501b5 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -46,7 +46,7 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 	while ((shwt * 4 + wt + (wt ? 2 : 3)) * cycle < t->cycle)
 		shwt++;
 	if (shwt > 7) {
-		pr_warning("tx4938ide: SHWT violation (%d)\n", shwt);
+		pr_warn("tx4938ide: SHWT violation (%d)\n", shwt);
 		shwt = 7;
 	}
 	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 67d4a7d4acc8..7fa4ff6fc099 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -364,9 +364,8 @@ static int tx4939ide_dma_test_irq(ide_drive_t *drive)
 	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
 		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_Stat);
 		if (!(dma_stat & ATA_DMA_INTR))
-			pr_warning("%s: weird interrupt status. "
-				   "DMA_Stat %#02x int_ctl %#04x\n",
-				   hwif->name, dma_stat, ctl);
+			pr_warn("%s: weird interrupt status. DMA_Stat %#02x int_ctl %#04x\n",
+				hwif->name, dma_stat, ctl);
 		found = 1;
 		break;
 	}
-- 
2.10.0.rc2.1.g053435c
