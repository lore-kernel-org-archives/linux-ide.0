From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ata: macio: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:20 -0600
Message-ID: <20181205195050.4759-4-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9588e685d994..9e2501da4638 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -948,7 +948,7 @@ static void pata_macio_invariants(struct pata_macio_priv *priv)
 		priv->kind = controller_k2_ata6;
 	        priv->timings = pata_macio_kauai_timings;
 	} else if (of_device_is_compatible(priv->node, "keylargo-ata")) {
-		if (strcmp(priv->node->name, "ata-4") == 0) {
+		if (of_node_name_eq(priv->node, "ata-4")) {
 			priv->kind = controller_kl_ata4;
 			priv->timings = pata_macio_kl66_timings;
 		} else {
-- 
2.19.1
