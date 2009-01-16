From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/2] pata_atiixp: update port enabledness
 test handling
Date: Fri, 16 Jan 2009 15:27:27 +0900
Message-ID: <497028CF.7030408@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43873 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbZAPG1a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 01:27:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, bugsbuggy@ymail.com

Port enabledness test fits much better into init_one() instead of
pre_reset().  The reason why these tests are in pre_reset() is purely
historical at this point.  Move it to init_one().  This will help
further changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_atiixp.c |   32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

Index: work/drivers/ata/pata_atiixp.c
===================================================================
--- work.orig/drivers/ata/pata_atiixp.c
+++ work/drivers/ata/pata_atiixp.c
@@ -32,21 +32,6 @@ enum {
 	ATIIXP_IDE_UDMA_MODE 	= 0x56
 };
 
-static int atiixp_pre_reset(struct ata_link *link, unsigned long deadline)
-{
-	struct ata_port *ap = link->ap;
-	static const struct pci_bits atiixp_enable_bits[] = {
-		{ 0x48, 1, 0x01, 0x00 },
-		{ 0x48, 1, 0x08, 0x00 }
-	};
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
-	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
-		return -ENOENT;
-
-	return ata_sff_prereset(link, deadline);
-}
-
 static int atiixp_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -229,10 +214,9 @@ static struct ata_port_operations atiixp
 	.cable_detect	= atiixp_cable_detect,
 	.set_piomode	= atiixp_set_piomode,
 	.set_dmamode	= atiixp_set_dmamode,
-	.prereset	= atiixp_pre_reset,
 };
 
-static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct ata_port_info info = {
 		.flags = ATA_FLAG_SLAVE_POSS,
@@ -241,8 +225,18 @@ static int atiixp_init_one(struct pci_de
 		.udma_mask = 0x3F,
 		.port_ops = &atiixp_port_ops
 	};
-	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_sff_init_one(dev, ppi, &atiixp_sht, NULL);
+	static const struct pci_bits atiixp_enable_bits[] = {
+		{ 0x48, 1, 0x01, 0x00 },
+		{ 0x48, 1, 0x08, 0x00 }
+	};
+	const struct ata_port_info *ppi[] = { &info, &info };
+	int i;
+
+	for (i = 0; i < 2; i++)
+		if (!pci_test_config_bits(pdev, &atiixp_enable_bits[i]))
+			ppi[i] = &ata_dummy_port_info;
+
+	return ata_pci_sff_init_one(pdev, ppi, &atiixp_sht, NULL);
 }
 
 static const struct pci_device_id atiixp[] = {
