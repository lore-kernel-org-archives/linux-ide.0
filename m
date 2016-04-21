From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 18/23] ata: sata_dwc_460ex: switch to new dmaengine_terminate_* API
Date: Thu, 21 Apr 2016 21:15:39 +0300
Message-ID: <1461262544-115408-19-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

Convert dmaengine_terminate_all() calls to synchronous and asynchronous
versions where appropriate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 7810405..229e122 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -968,7 +968,7 @@ static void sata_dwc_port_stop(struct ata_port *ap)
 
 	dev_dbg(ap->dev, "%s: ap->id = %d\n", __func__, ap->print_id);
 
-	dmaengine_terminate_all(hsdevp->chan);
+	dmaengine_terminate_sync(hsdevp->chan);
 	dma_release_channel(hsdevp->chan);
 	phy_power_off(hsdev->phy);
 
-- 
2.8.0.rc3
