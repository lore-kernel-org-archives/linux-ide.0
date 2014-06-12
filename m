From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] ahci: Check and set 64-bit DMA mask for platform AHCI driver
Date: Thu, 12 Jun 2014 12:40:23 -0500
Message-ID: <1402594824-4151-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1402594824-4151-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402594824-4151-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, b.zolnierkie@samsung.com
Cc: hdegoede@redhat.com, lho@apm.com, tphan@apm.com, stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: linux-ide@vger.kernel.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

The current platform AHCI driver does not set the dma_mask correctly
for 64-bit DMA capable AHCI controller. This patch checks the AHCI
capability bit and set the dma_mask and coherent_dma_mask accordingly.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/libahci_platform.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 3a5b4ed..a958a2b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -364,6 +364,19 @@ int ahci_platform_init_host(struct platform_device *pdev,
 			ap->ops = &ata_dummy_port_ops;
 	}
 
+	if (hpriv->cap & HOST_CAP_64) {
+		rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+		if (rc) {
+			rc = dma_coerce_mask_and_coherent(dev,
+							  DMA_BIT_MASK(32));
+			if (rc) {
+				dev_err(dev, "Failed to enable 64-bit DMA.\n");
+				return rc;
+			}
+			dev_warn(dev, "Enable 32-bit DMA instead of 64-bit.\n");
+		}
+	}
+
 	rc = ahci_reset_controller(host);
 	if (rc)
 		return rc;
-- 
1.9.0
