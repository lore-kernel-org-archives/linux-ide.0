From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt366: add enablebits checking
Date: Fri, 27 Nov 2009 19:53:51 +0100
Message-ID: <200911271953.51400.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:11529 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZK0S6N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Nov 2009 13:58:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Based on Sergei's older work on IDE hpt366 host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt366.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

Index: b/drivers/ata/pata_hpt366.c
===================================================================
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -204,6 +204,37 @@ static int hpt36x_cable_detect(struct at
 	return ATA_CBL_PATA80;
 }
 
+/**
+ *	hpt36x_prereset	-	perform reset handling
+ *	@link: ATA link to reset
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Perform the initial reset handling for the HPT36x.
+ */
+
+static int hpt36x_prereset(struct ata_link *link, unsigned long deadline)
+{
+	static const struct pci_bits hpt36x_enable_bits[] = {
+		{ 0x50, 1, 0x10, 0x10 },
+		{ 0x50, 1, 0x20, 0x20 }
+	};
+
+	struct ata_port *ap = link->ap;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	/*
+	 * HPT36x chips have one channel per function and have
+	 * both channel enable bits located differently and visible
+	 * to both functions -- really stupid design decision... :-(
+	 * Bit 4 is for the primary channel, bit 5 for the secondary.
+	 */
+	if (!pci_test_config_bits(pdev,
+			&hpt36x_enable_bits[PCI_FUNC(pdev->devfn) & 1]))
+		return -ENOENT;
+
+	return ata_sff_prereset(link, deadline);
+}
+
 static void hpt366_set_mode(struct ata_port *ap, struct ata_device *adev,
 			    u8 mode)
 {
@@ -284,6 +315,7 @@ static struct scsi_host_template hpt36x_
 
 static struct ata_port_operations hpt366_port_ops = {
 	.inherits	= &ata_bmdma32_port_ops,
+	.prereset	= hpt36x_prereset,
 	.cable_detect	= hpt36x_cable_detect,
 	.mode_filter	= hpt366_filter,
 	.set_piomode	= hpt366_set_piomode,
