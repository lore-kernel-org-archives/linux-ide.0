From: John Garry <john.garry@huawei.com>
Subject: [PATCH] ata: libahci: Only warn for AHCI_HFLAG_MULTI_MSI set when genuine custom irq handler implemented
Date: Tue, 19 Feb 2019 01:43:33 +0800
Message-ID: <1550511813-133136-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk
Cc: linuxarm@huawei.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, John Garry <john.garry@huawei.com>
List-Id: linux-ide@vger.kernel.org

For an AHCI controller with AHCI_HFLAG_MULTI_MSI flag set, we may get the
following log, regardless of whether a custom irq handler was implemented
or not:

[   14.700238] ahci 0000:74:03.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented

This is because we can set hpriv->irq_handler to
ahci_single_level_irq_intr() if not already set, in
ahci_init_one()->ahci_pci_save_initial_config()->ahci_save_initial_config().

Stop having this warn being misleading by adding a check for
hpriv->irq_handler != ahci_single_level_irq_intr.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index b5f57c69c487..692782dddc0f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2599,7 +2599,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
-		if (hpriv->irq_handler)
+		if (hpriv->irq_handler &&
+		    hpriv->irq_handler != ahci_single_level_irq_intr)
 			dev_warn(host->dev,
 			         "both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented\n");
 		if (!hpriv->get_irq_vector) {
-- 
2.17.1
