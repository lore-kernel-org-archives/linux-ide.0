From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 55/86] pata_ns87415: Power Management fix
Date: Wed, 25 Nov 2009 18:08:55 +0100
Message-ID: <20091125170855.5446.87352.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933249AbZKYRJk@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_ns87415: Power Management fix

Fix ->resume method to do chipset specific setup.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_ns87415.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_ns87415.c
===================================================================
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -325,6 +325,13 @@ static struct scsi_host_template ns87415
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
+static void ns87415_fixup(struct pci_dev *pdev)
+{
+	/* Select 512 byte sectors */
+	pci_write_config_byte(pdev, 0x55, 0xEE);
+	/* Select PIO0 8bit clocking */
+	pci_write_config_byte(pdev, 0x54, 0xB7);
+}
 
 /**
  *	ns87415_init_one - Register 87415 ATA PCI device with kernel services
@@ -371,10 +378,8 @@ static int ns87415_init_one (struct pci_
 	if (rc)
 		return rc;
 
-	/* Select 512 byte sectors */
-	pci_write_config_byte(pdev, 0x55, 0xEE);
-	/* Select PIO0 8bit clocking */
-	pci_write_config_byte(pdev, 0x54, 0xB7);
+	ns87415_fixup(pdev);
+
 	return ata_pci_sff_init_one(pdev, ppi, &ns87415_sht, NULL);
 }
 
@@ -384,6 +389,23 @@ static const struct pci_device_id ns8741
 	{ }	/* terminate list */
 };
 
+#ifdef CONFIG_PM
+static int ns87415_reinit_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
+	ns87415_fixup(pdev);
+
+	ata_host_resume(host);
+	return 0;
+}
+#endif
+
 static struct pci_driver ns87415_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= ns87415_pci_tbl,
@@ -391,7 +413,7 @@ static struct pci_driver ns87415_pci_dri
 	.remove			= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
+	.resume			= ns87415_reinit_one,
 #endif
 };
 
