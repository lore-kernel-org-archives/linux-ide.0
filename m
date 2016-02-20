From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [RFC PATCH] drivers: ata: Read Rx water mark value from device-tree
Date: Sat, 20 Feb 2016 18:48:22 +0530
Message-ID: <1455974302-7082-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:12238
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757173AbcBTNdz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Feb 2016 08:33:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tj@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, anirudh@xilinx.com, svemula@xilinx.com, punnaia@xilinx.com, Anurag Kumar Vulisha <anuragku@xilinx.com>

This patch updates the driver to read the RX FIFO watermark value
from device tree. This read value is used by the driver for programming
FIFO RxWaterMark level, which sets the minimum number of free
locations within the RX FIFO.When the rx fifo level crosses the
programmed watermark level, sata controller will transmit HOLDS to
the device asking it to wait.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 .../devicetree/bindings/ata/ahci-ceva.txt          |    2 ++
 drivers/ata/ahci_ceva.c                            |   10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
index 7ca8b97..7e48dfc 100644
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
@@ -8,6 +8,7 @@ Required properties:
 
 Optional properties:
   - ceva,broken-gen2: limit to gen1 speed instead of gen2.
+  - ceva,rx-watermark: RX fifo water mark level for SATA controller.
 
 Examples:
 	ahci@fd0c0000 {
@@ -17,4 +18,5 @@ Examples:
 		interrupts = <0 133 4>;
 		clocks = <&clkc SATA_CLK_ID>;
 		ceva,broken-gen2;
+		ceva,rx-watermark = <0x40>;
 	};
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 207649d..ea01f7d 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -88,6 +88,7 @@
 struct ceva_ahci_priv {
 	struct platform_device *ahci_pdev;
 	int flags;
+	u32 rx_watermark;
 };
 
 static struct ata_port_operations ahci_ceva_ops = {
@@ -147,7 +148,7 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 		writel(tmp, mmio + AHCI_VEND_PP5C);
 
 		/* Rx Watermark setting  */
-		tmp = PTC_RX_WM_VAL | PTC_RSVD;
+		tmp = cevapriv->rx_watermark | PTC_RSVD;
 		writel(tmp, mmio + AHCI_VEND_PTC);
 
 		/* Default to Gen 2 Speed and Gen 1 if Gen2 is broken */
@@ -187,6 +188,13 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
 
+	/* Read RX WATERMARK value from device tree */
+	if (of_property_read_u32(np, "ceva,rx-watermark",
+				&cevapriv->rx_watermark) < 0) {
+		/* using default RX water mark, if not in device tree */
+		cevapriv->rx_watermark = PTC_RX_WM_VAL;
+	}
+
 	hpriv->plat_data = cevapriv;
 
 	/* CEVA specific initialization */
-- 
1.7.1

