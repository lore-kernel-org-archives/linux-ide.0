From: Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v5 1/2] ahci-platform: Bump max number of clocks to 5
Date: Mon, 22 Sep 2014 15:09:45 -0500
Message-ID: <1411416586-18320-1-git-send-email-galak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Kumar Gala <galak@codeaurora.org>, linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Qualcomm IPQ806x SoCs with SATA controllers need 5 clocks to be enabled.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
v4/v5:
* Updated to upstream changes

 drivers/ata/ahci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 59ae0ee..90156ff 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -53,7 +53,7 @@
 
 enum {
 	AHCI_MAX_PORTS		= 32,
-	AHCI_MAX_CLKS		= 4,
+	AHCI_MAX_CLKS		= 5,
 	AHCI_MAX_SG		= 168, /* hardware max is 64K */
 	AHCI_DMA_BOUNDARY	= 0xffffffff,
 	AHCI_MAX_CMDS		= 32,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
