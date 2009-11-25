From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/86] pata_atiixp: add proper ->prereset method
Date: Wed, 25 Nov 2009 18:03:44 +0100
Message-ID: <20091125170344.5446.54715.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759096AbZKYRE0@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atiixp: add proper ->prereset method

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atiixp.c |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

Index: b/drivers/ata/pata_atiixp.c
===================================================================
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -47,6 +47,31 @@ static int atiixp_cable_detect(struct at
 }
 
 /**
+ *	atiixp_prereset	-	perform reset handling
+ *	@link: ATA link
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Reset sequence checking enable bits to see which ports are
+ *	active.
+ */
+
+static int atiixp_prereset(struct ata_link *link, unsigned long deadline)
+{
+	static const struct pci_bits atiixp_enable_bits[] = {
+		{ 0x48, 1, 0x01, 0x00 },
+		{ 0x48, 1, 0x08, 0x00 }
+	};
+
+	struct ata_port *ap = link->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
+		return -ENOENT;
+
+	return ata_sff_prereset(link, deadline);
+}
+
+/**
  *	atiixp_set_pio_timing	-	set initial PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -151,6 +176,7 @@ static struct ata_port_operations atiixp
 
 	.qc_prep 	= ata_sff_dumb_qc_prep,
 
+	.prereset	= atiixp_prereset,
 	.cable_detect	= atiixp_cable_detect,
 	.set_piomode	= atiixp_set_piomode,
 	.set_dmamode	= atiixp_set_dmamode,
@@ -165,16 +191,7 @@ static int atiixp_init_one(struct pci_de
 		.udma_mask = ATA_UDMA5,
 		.port_ops = &atiixp_port_ops
 	};
-	static const struct pci_bits atiixp_enable_bits[] = {
-		{ 0x48, 1, 0x01, 0x00 },
-		{ 0x48, 1, 0x08, 0x00 }
-	};
 	const struct ata_port_info *ppi[] = { &info, &info };
-	int i;
-
-	for (i = 0; i < 2; i++)
-		if (!pci_test_config_bits(pdev, &atiixp_enable_bits[i]))
-			ppi[i] = &ata_dummy_port_info;
 
 	return ata_pci_sff_init_one(pdev, ppi, &atiixp_sht, NULL);
 }
