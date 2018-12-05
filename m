From: Rob Herring <robh@kernel.org>
Subject: [PATCH] ide: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:25 -0600
Message-ID: <20181205195050.4759-9-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-ide@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ide/pmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index c5b902b86b44..ec46aa84d18d 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1045,7 +1045,7 @@ static int pmac_ide_setup_device(pmac_ide_hwif_t *pmif, struct ide_hw *hw)
 		d.port_ops = &pmac_ide_ata4_port_ops;
 		d.udma_mask = ATA_UDMA5;
 	} else if (of_device_is_compatible(np, "keylargo-ata")) {
-		if (strcmp(np->name, "ata-4") == 0) {
+		if (of_node_name_eq(np, "ata-4")) {
 			pmif->kind = controller_kl_ata4;
 			d.port_ops = &pmac_ide_ata4_port_ops;
 			d.udma_mask = ATA_UDMA4;
-- 
2.19.1
