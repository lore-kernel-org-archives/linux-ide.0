From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5/9] ata: ceva: Make RxWaterMark value as module parameter
Date: Fri,  4 Aug 2017 15:18:14 +0200
Message-ID: <1fae8fe46887c6d8986c6362be4bf83ed3752331.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

This patch updates the driver to make Rx Fifo water mark value
as a module parameter.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/ata/ahci_ceva.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index b63fab2507fa..eff40ec86065 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -71,6 +71,10 @@
 #define DRV_NAME	"ahci-ceva"
 #define CEVA_FLAG_BROKEN_GEN2	1
 
+static unsigned int rx_watermark = PTC_RX_WM_VAL;
+module_param(rx_watermark, uint, 0644);
+MODULE_PARM_DESC(rx_watermark, "RxWaterMark value (0 - 0x80)");
+
 struct ceva_ahci_priv {
 	struct platform_device *ahci_pdev;
 	/* Port Phy2Cfg Register */
@@ -152,7 +156,7 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 		writel(cevapriv->pp5c[i], mmio + AHCI_VEND_PP5C);
 
 		/* Rx Watermark setting  */
-		tmp = PTC_RX_WM_VAL | PTC_RSVD;
+		tmp = rx_watermark | PTC_RSVD;
 		writel(tmp, mmio + AHCI_VEND_PTC);
 
 		/* Default to Gen 3 Speed and Gen 1 if Gen2 is broken */
-- 
1.9.1
