From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/64] pata_efar: enable parallel scan
Date: Mon, 18 Jan 2010 18:16:31 +0100
Message-ID: <20100118171631.14623.68700.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754794Ab0ARRRt@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_efar: enable parallel scan

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_efar.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: b/drivers/ata/pata_efar.c
===================================================================
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -238,12 +238,27 @@ static int efar_init_one (struct pci_dev
 		.port_ops	= &efar_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
+	struct ata_host *host;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_sff_init_one(pdev, ppi, &efar_sht, NULL);
+	/* enable device and prepare host */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = ata_pci_sff_prepare_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
+
+	host->flags |= ATA_HOST_PARALLEL_SCAN;
+
+	pci_set_master(pdev);
+
+	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &efar_sht);
 }
 
 static const struct pci_device_id efar_pci_tbl[] = {
