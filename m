From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt366: Switch back to cable method again
Date: Thu, 8 Mar 2007 19:34:28 +0000
Message-ID: <20070308193428.191003d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34196 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932641AbXCHSaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 13:30:18 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt366.c linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt366.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_hpt366.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_hpt366.c	2007-03-08 16:24:17.000000000 +0000
@@ -27,7 +27,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.0"
+#define DRV_VERSION	"0.6.1"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -210,24 +209,26 @@
 	return 0xffffffffU;	/* silence compiler warning */
 }
 
+static int hpt36x_cable_detect(struct ata_port *ap)
+{
+	u8 ata66;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	pci_read_config_byte(pdev, 0x5A, &ata66);
+	if (ata66 & (1 << ap->port_no))
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
+}
+
 static int hpt36x_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits hpt36x_enable_bits[] = {
 		{ 0x50, 1, 0x04, 0x04 },
 		{ 0x54, 1, 0x04, 0x04 }
 	};
-
-	u8 ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
 	if (!pci_test_config_bits(pdev, &hpt36x_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	pci_read_config_byte(pdev, 0x5A, &ata66);
-	if (ata66 & (1 << ap->port_no))
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -354,6 +355,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt36x_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= hpt36x_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
