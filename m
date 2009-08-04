From: Tony Vroon <tony@linx.net>
Subject: [PATCH 2.6.32] MCP5x conditional MSI support for sata_nv
Date: Wed,  5 Aug 2009 00:32:34 +0100 (BST)
Message-ID: <20090804233234.7251110075@gold.linx.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:46424 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbZHDXjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 19:39:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Philip Langdale <philipl@overt.org>

The nVidia MCP55 controller quite happily supports MSI.
This adds an option to use it. It is disabled by default and 
will only be honoured on MCP5x series controllers.
This was suggested in 2007 back when the driver was less mature, 
perhaps now is a better time for it.

Signed-off-by: Tony Vroon <tony@linx.net>

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b2d11f3..469d4c7 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -602,6 +602,7 @@ MODULE_VERSION(DRV_VERSION);
 
 static int adma_enabled;
 static int swncq_enabled = 1;
+static int msi_enabled;
 
 static void nv_adma_register_mode(struct ata_port *ap)
 {
@@ -2459,6 +2460,12 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	} else if (type == SWNCQ)
 		nv_swncq_host_init(host);
 
+	/* enable MSI if requested */
+	if (type >= MCP5x && msi_enabled) {
+		dev_printk(KERN_NOTICE, &pdev->dev, "Using MSI\n");
+		pci_enable_msi(pdev);
+	}
+
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ipriv->irq_handler,
 				 IRQF_SHARED, ipriv->sht);
@@ -2558,4 +2565,6 @@ module_param_named(adma, adma_enabled, bool, 0444);
 MODULE_PARM_DESC(adma, "Enable use of ADMA (Default: false)");
 module_param_named(swncq, swncq_enabled, bool, 0444);
 MODULE_PARM_DESC(swncq, "Enable use of SWNCQ (Default: true)");
+module_param_named(msi, msi_enabled, bool, 0444);
+MODULE_PARM_DESC(msi, "Enable use of MSI (Default: false)");
 
