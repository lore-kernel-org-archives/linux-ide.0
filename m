From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
Date: Thu, 20 Sep 2018 12:16:41 -0700
Message-ID: <20180920191646.18198-8-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

On BCM63138, we need to reset the AHCI core prior to start utilizing it,
grab the reset controller device cookie and do that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index f3d557777d82..d535e87151dc 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/string.h>
 
 #include "ahci.h"
@@ -94,6 +95,7 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
+	struct reset_control *rcdev;
 };
 
 static inline u32 brcm_sata_readreg(void __iomem *addr)
@@ -411,6 +413,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	priv->rcdev = of_reset_control_get(pdev->dev.of_node, NULL);
+	if (!IS_ERR(priv->rcdev))
+		reset_control_deassert(priv->rcdev);
+
 	if ((priv->version == BRCM_SATA_BCM7425) ||
 		(priv->version == BRCM_SATA_NSP)) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;
@@ -464,6 +470,9 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 
 	brcm_sata_phys_disable(priv);
 
+	if (!IS_ERR(priv->rcdev))
+		reset_control_assert(priv->rcdev);
+
 	return 0;
 }
 
-- 
2.17.1
