From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [RFC PATCH] drivers: ata: Add [save|restore]_initial_config override functions
Date: Tue, 14 Mar 2017 17:29:21 +0530
Message-ID: <1489492761-815-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:61982
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750771AbdCNL7h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 14 Mar 2017 07:59:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: anirudh@xilinx.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Anurag Kumar Vulisha <anuragku@xilinx.com>

Since there are SATA controllers that configure vendor specific registers
for AXI bus, OOB timing, threshold related settings. These settings may get
reset to the default values on resetting the SATA controller.
So this patch adds the support for adding [save|restore]_initial_config
override functions for saving and restoring controller values from the driver
instead of doing it in AHCI stack

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 drivers/ata/ahci.c             | 5 ++++-
 drivers/ata/ahci.h             | 9 +++++++++
 drivers/ata/libahci.c          | 5 ++++-
 drivers/ata/libahci_platform.c | 5 ++++-
 drivers/ata/sata_highbank.c    | 6 ++++--
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2fc5240..ed76c9e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -613,7 +613,10 @@ static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 			  "Disabling your PATA port. Use the boot option 'ahci.marvell_enable=0' to avoid this.\n");
 	}
 
-	ahci_save_initial_config(&pdev->dev, hpriv);
+	if (hpriv->save_initial_config == NULL)
+		ahci_save_initial_config(dev, hpriv);
+	else
+		hpriv->save_initial_config(dev, hpriv);
 }
 
 static int ahci_pci_reset_controller(struct ata_host *host)
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 5db6ab2..2929e27 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -363,6 +363,15 @@ struct ahci_host_priv {
 	/* only required for per-port MSI(-X) support */
 	int			(*get_irq_vector)(struct ata_host *host,
 						  int port);
+
+	/*
+	 * Optional ahci_save_initial_config & ahci_restore_initial_config
+	 * override, if not set then default ahci_save_initial_config and
+	 * ahci_restore_initial_config in libahci.c will be used
+	 */
+	void (*save_initial_config)(struct device *dev,
+				struct ahci_host_priv *hpriv);
+	void (*restore_initial_config)(struct ata_host *host);
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3159f9e..fb57525 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -940,7 +940,10 @@ int ahci_reset_controller(struct ata_host *host)
 		/* Some registers might be cleared on reset.  Restore
 		 * initial values.
 		 */
-		ahci_restore_initial_config(host);
+		if (hpriv->restore_initial_config == NULL)
+			ahci_restore_initial_config(host);
+		else
+			hpriv->restore_initial_config(host);
 	} else
 		dev_info(host->dev, "skipping global host reset\n");
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index aaa761b..15ba5f8 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -523,7 +523,10 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	/* prepare host */
 	pi.private_data = (void *)(unsigned long)hpriv->flags;
 
-	ahci_save_initial_config(dev, hpriv);
+	if (hpriv->save_initial_config == NULL)
+		ahci_save_initial_config(dev, hpriv);
+	else
+		hpriv->save_initial_config(dev, hpriv);
 
 	if (hpriv->cap & HOST_CAP_NCQ)
 		pi.flags |= ATA_FLAG_NCQ;
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index aafb8cc..61af3c6 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -512,8 +512,10 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-
-	ahci_save_initial_config(dev, hpriv);
+	if (hpriv->save_initial_config == NULL)
+		ahci_save_initial_config(dev, hpriv);
+	else
+		hpriv->save_initial_config(dev, hpriv);
 
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ)
-- 
2.1.1

