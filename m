From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 83/86] pata_via: add via_fixup()
Date: Wed, 25 Nov 2009 18:12:25 +0100
Message-ID: <20091125171225.5446.58040.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934838AbZKYRNP@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_via: add via_fixup()

Factor out common code from via_[re]init_one() to via_fixup().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_via.c |   53 +++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

Index: b/drivers/ata/pata_via.c
===================================================================
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -468,6 +468,27 @@ static void via_config_fifo(struct pci_d
 	}
 }
 
+static void via_fixup(struct pci_dev *pdev, const struct via_isa_bridge *config)
+{
+	u32 timing;
+
+	/* Initialise the FIFO for the enabled channels. */
+	via_config_fifo(pdev, config->flags);
+
+	if ((config->flags & VIA_UDMA) == VIA_UDMA_66) {
+		/* The 66 MHz devices require we enable the clock */
+		pci_read_config_dword(pdev, 0x50, &timing);
+		timing |= 0x80008;
+		pci_write_config_dword(pdev, 0x50, timing);
+	}
+	if (config->flags & VIA_BAD_CLK66) {
+		/* Disable the 66MHz clock on problem devices */
+		pci_read_config_dword(pdev, 0x50, &timing);
+		timing &= ~0x80008;
+		pci_write_config_dword(pdev, 0x50, timing);
+	}
+}
+
 /**
  *	via_init_one		-	discovery callback
  *	@pdev: PCI device
@@ -530,7 +551,6 @@ static int via_init_one(struct pci_dev *
 	const struct via_isa_bridge *config;
 	static int printed_version;
 	u8 enable;
-	u32 timing;
 	unsigned long flags = id->driver_data;
 	int rc;
 
@@ -568,9 +588,6 @@ static int via_init_one(struct pci_dev *
 			return -ENODEV;
 	}
 
-	/* Initialise the FIFO for the enabled channels. */
-	via_config_fifo(pdev, config->flags);
-
 	/* Clock set up */
 	switch(config->flags & VIA_UDMA) {
 		case VIA_UDMA_NONE:
@@ -584,10 +601,6 @@ static int via_init_one(struct pci_dev *
 			break;
 		case VIA_UDMA_66:
 			ppi[0] = &via_udma66_info;
-			/* The 66 MHz devices require we enable the clock */
-			pci_read_config_dword(pdev, 0x50, &timing);
-			timing |= 0x80008;
-			pci_write_config_dword(pdev, 0x50, timing);
 			break;
 		case VIA_UDMA_100:
 			ppi[0] = &via_udma100_info;
@@ -600,12 +613,7 @@ static int via_init_one(struct pci_dev *
 			return -ENODEV;
 	}
 
-	if (config->flags & VIA_BAD_CLK66) {
-		/* Disable the 66MHz clock on problem devices */
-		pci_read_config_dword(pdev, 0x50, &timing);
-		timing &= ~0x80008;
-		pci_write_config_dword(pdev, 0x50, timing);
-	}
+	via_fixup(pdev, config);
 
 	/* We have established the device type, now fire it up */
 	return ata_pci_sff_init_one(pdev, ppi, &via_sht, (void *)config);
@@ -624,29 +632,14 @@ static int via_init_one(struct pci_dev *
 
 static int via_reinit_one(struct pci_dev *pdev)
 {
-	u32 timing;
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	const struct via_isa_bridge *config = host->private_data;
 	int rc;
 
 	rc = ata_pci_device_do_resume(pdev);
 	if (rc)
 		return rc;
 
-	via_config_fifo(pdev, config->flags);
-
-	if ((config->flags & VIA_UDMA) == VIA_UDMA_66) {
-		/* The 66 MHz devices require we enable the clock */
-		pci_read_config_dword(pdev, 0x50, &timing);
-		timing |= 0x80008;
-		pci_write_config_dword(pdev, 0x50, timing);
-	}
-	if (config->flags & VIA_BAD_CLK66) {
-		/* Disable the 66MHz clock on problem devices */
-		pci_read_config_dword(pdev, 0x50, &timing);
-		timing &= ~0x80008;
-		pci_write_config_dword(pdev, 0x50, timing);
-	}
+	via_fixup(pdev, host->private_data);
 
 	ata_host_resume(host);
 	return 0;
