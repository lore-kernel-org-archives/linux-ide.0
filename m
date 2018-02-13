From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ata: sata_rcar: Remove unused variable in sata_rcar_init_controller()
Date: Tue, 13 Feb 2018 13:43:23 +0100
Message-ID: <1518525803-17378-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

drivers/ata/sata_rcar.c: In function 'sata_rcar_init_controller':
drivers/ata/sata_rcar.c:821:8: warning: unused variable 'base' [-Wunused-variable]

Fixes: da77d76b95a0e894 ("sata_rcar: Reset SATA PHY when Salvator-X board resumes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/sata_rcar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 6f47ca34767d74fe..6456e07db72a7ea4 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -818,7 +818,6 @@ static void sata_rcar_init_module(struct sata_rcar_priv *priv)
 static void sata_rcar_init_controller(struct ata_host *host)
 {
 	struct sata_rcar_priv *priv = host->private_data;
-	void __iomem *base = priv->base;
 
 	/* reset and setup phy */
 	switch (priv->type) {
-- 
2.7.4
