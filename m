From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/2] ata: ahci_platform: runtime resume the device before use
Date: Wed, 16 Oct 2013 14:42:53 +0300
Message-ID: <1381923773-10596-3-git-send-email-rogerq@ti.com>
References: <1381923773-10596-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381923773-10596-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: sergei.shtylyov@cogentembedded.com, kishon@ti.com, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-ide@vger.kernel.org

On OMAP platforms the device needs to be runtime resumed before
it can be accessed. The OMAP HWMOD framework takes care of
enabling the module and its resources based on the
device's runtime PM state.

In this patch we runtime resume during .probe() and runtime suspend
during .remove() (i.e. ahci_host_stop()).

We also update the runtime PM state during .resume().

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/ata/ahci_platform.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 5a0f1418..0da3b95 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
+#include <linux/pm_runtime.h>
 #include "ahci.h"
 
 static void ahci_host_stop(struct ata_host *host);
@@ -141,6 +142,9 @@ static int ahci_probe(struct platform_device *pdev)
 		}
 	}
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	hpriv->phy = devm_phy_get(dev, "sata-phy");
 	if (IS_ERR(hpriv->phy)) {
 		dev_dbg(dev, "can't get sata-phy\n");
@@ -268,6 +272,9 @@ static void ahci_host_stop(struct ata_host *host)
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -339,6 +346,11 @@ static int ahci_resume(struct device *dev)
 
 	ata_host_resume(host);
 
+	/* We resumed so update PM runtime state */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return 0;
 
 disable_unprepare_clk:
-- 
1.7.9.5
