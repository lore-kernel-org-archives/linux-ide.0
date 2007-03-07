From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt3x2n: Cable detect handling
Date: Wed, 7 Mar 2007 16:17:23 +0000
Message-ID: <20070307161723.49b4b4aa@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57053 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783AbXCGPNP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:13:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_hpt3x2n.c linux-2.6.21-rc2-mm2/drivers/ata/pata_hpt3x2n.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_hpt3x2n.c	2007-03-06 23:06:26.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_hpt3x2n.c	2007-03-06 17:31:59.000000000 +0000
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.2"
+#define DRV_VERSION	"0.3.3"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -115,14 +115,13 @@
 }
 
 /**
- *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
- *	@ap: ATA port to reset
+ *	hpt3x2n_cable_detect	-	Detect the cable type
+ *	@ap: ATA port to detect on
  *
- *	Perform the initial reset handling for the 3x2n series controllers.
- *	Reset the hardware and state machine, obtain the cable type.
+ *	Return the cable type attached to this port
  */
 
-static int hpt3xn_pre_reset(struct ata_port *ap)
+static int hpt3x2n_cable_detect(struct ata_port *ap)
 {
 	u8 scr2, ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
@@ -135,15 +134,26 @@
 	pci_write_config_byte(pdev, 0x5B, scr2);
 
 	if (ata66 & (1 << ap->port_no))
-		ap->cbl = ATA_CBL_PATA40;
+		return ATA_CBL_PATA40;
 	else
-		ap->cbl = ATA_CBL_PATA80;
+		return ATA_CBL_PATA80;
+}
+
+/**
+ *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
+ *	@ap: ATA port to reset
+ *
+ *	Perform the initial reset handling for the 3x2n series controllers.
+ *	Reset the hardware and state machine,
+ */
 
+static int hpt3xn_pre_reset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	/* Reset the state machine */
 	pci_write_config_byte(pdev, 0x50, 0x37);
 	pci_write_config_byte(pdev, 0x54, 0x37);
 	udelay(100);
-
 	return ata_std_prereset(ap);
 }
 
@@ -364,6 +374,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= hpt3x2n_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= hpt3x2n_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
