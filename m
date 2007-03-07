From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_atiixp: Switch to cable_detect method (with correct
 patch)
Date: Wed, 7 Mar 2007 17:10:30 +0000
Message-ID: <20070307171030.3557ff03@lxorguk.ukuu.org.uk>
References: <20070307170651.46de680d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35781 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932446AbXCGQGt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 11:06:49 -0500
In-Reply-To: <20070307170651.46de680d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

Lets try attaching the right patch file this time

Not clear we should keep this ugly BIOS mode hack, but for now it can
stay. Possibly an ACPI based solution will work, or just doing drive side
detection now that is hopefully fixed.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_atiixp.c linux-2.6.21-rc2-mm2/drivers/ata/pata_atiixp.c
--- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_atiixp.c	2007-03-06 23:09:46.000000000 +0000
+++ linux-2.6.21-rc2-mm2/drivers/ata/pata_atiixp.c	2007-03-06 23:34:56.000000000 +0000
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_atiixp"
-#define DRV_VERSION "0.4.4"
+#define DRV_VERSION "0.4.5"
 
 enum {
 	ATIIXP_IDE_PIO_TIMING	= 0x40,
@@ -35,23 +35,13 @@
 
 static int atiixp_pre_reset(struct ata_port *ap)
 {
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	static const struct pci_bits atiixp_enable_bits[] = {
 		{ 0x48, 1, 0x01, 0x00 },
 		{ 0x48, 1, 0x08, 0x00 }
 	};
-	u8 udma;
-
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	/* Hack from drivers/ide/pci. Really we want to know how to do the
-	   raw detection not play follow the bios mode guess */
-	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ap->port_no, &udma);
-	if ((udma & 0x07) >= 0x04 || (udma & 0x70) >= 0x40)
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
 
@@ -60,6 +50,19 @@
 	ata_bmdma_drive_eh(ap, atiixp_pre_reset, ata_std_softreset, NULL,   ata_std_postreset);
 }
 
+static int atiixp_cable_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 udma;
+
+	/* Hack from drivers/ide/pci. Really we want to know how to do the
+	   raw detection not play follow the bios mode guess */
+	pci_read_config_byte(pdev, ATIIXP_IDE_UDMA_MODE + ap->port_no, &udma);
+	if ((udma & 0x07) >= 0x04 || (udma & 0x70) >= 0x40)
+		return  ATA_CBL_PATA80;
+	return ATA_CBL_PATA40;
+}
+
 /**
  *	atiixp_set_pio_timing	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -245,6 +248,7 @@
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= atiixp_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= atiixp_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= atiixp_bmdma_start,
