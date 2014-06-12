From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] ahci/xgene: Remove logic to set 64-bit DMA mask
Date: Thu, 12 Jun 2014 12:40:24 -0500
Message-ID: <1402594824-4151-3-git-send-email-suravee.suthikulpanit@amd.com>
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

Instead of doing the check here, this should be handled
in the common AHCI platform code.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Loc Ho <lho@apm.com>
Cc: Tuan Phan <tphan@apm.com>
Cc: Suman Triphati <stripathi@apm.com>
---
 drivers/ata/ahci_xgene.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 042a9bb..a9fc2ae 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -440,16 +440,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	/* Configure the host controller */
 	xgene_ahci_hw_init(hpriv);
 
-	/*
-	 * Setup DMA mask. This is preliminary until the DMA range is sorted
-	 * out.
-	 */
-	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (rc) {
-		dev_err(dev, "Unable to set dma mask\n");
-		goto disable_resources;
-	}
-
 	hflags = AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
 
 	rc = ahci_platform_init_host(pdev, hpriv, &xgene_ahci_port_info,
-- 
1.9.0
