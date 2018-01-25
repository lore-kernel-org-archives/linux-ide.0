From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ata: sata_mv: Replace mdelay with usleep_range in mv_reset_channel
Date: Thu, 25 Jan 2018 18:26:52 +0800
Message-ID: <1516876013-12653-1-git-send-email-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, mlord@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-ide@vger.kernel.org

After checking all possible call chains to mv_reset_channel here,
my tool finds that mv_reset_channel is never called in atomic context, 
namely never in an interrupt handler or holding a spinlock.
Thus mdelay can be replaced with usleep_range to avoid busy wait.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ata/sata_mv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index cc208b7..42d4589 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3596,7 +3596,7 @@ static void mv_reset_channel(struct mv_host_priv *hpriv, void __iomem *mmio,
 	hpriv->ops->phy_errata(hpriv, mmio, port_no);
 
 	if (IS_GEN_I(hpriv))
-		mdelay(1);
+		usleep_range(500, 1000);
 }
 
 static void mv_pmp_select(struct ata_port *ap, int pmp)
-- 
1.7.9.5
