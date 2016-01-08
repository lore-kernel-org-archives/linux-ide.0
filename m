From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/4] ata: ahci_brcmstb: disable DIPM support
Date: Thu,  7 Jan 2016 16:03:31 -0800
Message-ID: <1452211413-1350-3-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Danesh Petigara <dpetigara@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-ide@vger.kernel.org

From: Danesh Petigara <dpetigara@broadcom.com>

The Broadcom STB SATA host controller does not support device
initiated power management. Disable support for this feature
so the driver never sends SETFEATURES commands to the device
to enable/disable DIPM.

Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index f38a07ea59f4..f51e3d9ba86e 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -84,7 +84,7 @@ struct brcm_ahci_priv {
 };
 
 static const struct ata_port_info ahci_brcm_port_info = {
-	.flags		= AHCI_FLAG_COMMON,
+	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_platform_ops,
-- 
2.1.0
