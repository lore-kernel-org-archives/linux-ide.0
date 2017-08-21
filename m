From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 5/9] ata: ceva: Make RxWaterMark value as module parameter
Date: Mon, 21 Aug 2017 13:17:20 +0200
Message-ID: <4f99d8aded415dc3c2eec77c9fc52b92a12fd7a6.1503314240.git.michal.simek@xilinx.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37432 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbdHULRi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Aug 2017 07:17:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id z91so17343203wrc.4
        for <linux-ide@vger.kernel.org>; Mon, 21 Aug 2017 04:17:38 -0700 (PDT)
In-Reply-To: <cover.1503314240.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1503314240.git.michal.simek@xilinx.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

This patch updates the driver to make Rx Fifo water mark value
as a module parameter.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

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

