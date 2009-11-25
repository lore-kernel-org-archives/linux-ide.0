From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 21/86] pata_cmd64x: add enablebits checking
Date: Wed, 25 Nov 2009 18:04:50 +0100
Message-ID: <20091125170450.5446.70158.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759217AbZKYR0V@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: add enablebits checking

There shouldn't be any problems with it as IDE cmd64x host driver
has been supporting enablebits checking for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cmd64x.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -2,6 +2,7 @@
  * pata_cmd64x.c 	- CMD64x PATA for new ATA layer
  *			  (C) 2005 Red Hat Inc
  *			  Alan Cox <alan@lxorguk.ukuu.org.uk>
+ *			  (C) 2009 Bartlomiej Zolnierkiewicz
  *
  * Based upon
  * linux/drivers/ide/pci/cmd64x.c		Version 1.30	Sept 10, 2002
@@ -88,6 +89,40 @@ static int cmd648_cable_detect(struct at
 }
 
 /**
+ *	cmd64x_prereset	-	perform reset handling
+ *	@link: ATA link
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Reset sequence checking enable bits to see which ports are
+ *	active.
+ */
+
+static int cmd64x_prereset(struct ata_link *link, unsigned long deadline)
+{
+	static const struct pci_bits cmd64x_enable_bits[] = {
+		{ 0x51, 1, 0x04, 0x04 },
+		{ 0x51, 1, 0x08, 0x08 }
+	};
+
+	struct ata_port *ap = link->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	/*
+	 * The original PCI0643 and PCI0646 didn't have the primary
+	 * channel enable bit, it appeared starting with PCI0646U
+	 * (i.e. revision ID 3).
+	 */
+	if (pdev->device == PCI_DEVICE_ID_CMD_643 ||
+	    (pdev->device == PCI_DEVICE_ID_CMD_646 && pdev->revision < 3))
+		goto out;
+
+	if (!pci_test_config_bits(pdev, &cmd64x_enable_bits[ap->port_no]))
+		return -ENOENT;
+out:
+	return ata_sff_prereset(link, deadline);
+}
+
+/**
  *	cmd64x_set_piomode	-	set PIO and MWDMA timing
  *	@ap: ATA interface
  *	@adev: ATA device
@@ -278,6 +313,7 @@ static const struct ata_port_operations
 static struct ata_port_operations cmd64x_port_ops = {
 	.inherits	= &cmd64x_base_ops,
 	.cable_detect	= ata_cable_40wire,
+	.prereset	= cmd64x_prereset,
 };
 
 static struct ata_port_operations cmd646r1_port_ops = {
