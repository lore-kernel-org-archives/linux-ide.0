From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sis: Restore cable method, re-perform crapectory,
 restore bug fixes
Date: Thu, 8 Mar 2007 23:01:58 +0000
Message-ID: <20070308230158.7a45bc15@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50106 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965136AbXCHV5m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 16:57:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_sis.c linux-2.6.21-rc3-mm2/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_sis.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_sis.c	2007-03-08 16:37:57.000000000 +0000
@@ -35,7 +35,7 @@
 #include "sis.h"
 
 #define DRV_NAME	"pata_sis"
-#define DRV_VERSION	"0.5.0"
+#define DRV_VERSION	"0.5.1"
 
 struct sis_chipset {
 	u16 device;			/* PCI host ID */
@@ -86,109 +86,56 @@
 }
 
 /**
- *	sis_133_pre_reset	-	check for 40/80 pin
+ *	sis_133_cable_detect	-	check for 40/80 pin
  *	@ap: Port
- *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection for the later UDMA133 capable
  *	SiS chipset.
  */
 
-static int sis_133_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int sis_133_cable_detect(struct ata_port *ap)
 {
-	static const struct pci_bits sis_enable_bits[] = {
-		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
-		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
-	};
-
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 tmp;
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
-		return -ENOENT;
-
 	/* The top bit of this register is the cable detect bit */
 	pci_read_config_word(pdev, 0x50 + 2 * ap->port_no, &tmp);
 	if ((tmp & 0x8000) && !sis_short_ata40(pdev))
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
-
-	return ata_std_prereset(ap, deadline);
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
 }
 
 /**
- *	sis_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void sis_133_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, sis_133_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-
-/**
- *	sis_66_pre_reset	-	check for 40/80 pin
+ *	sis_66_cable_detect	-	check for 40/80 pin
  *	@ap: Port
- *	@deadline: deadline jiffies for the operation
  *
  *	Perform cable detection on the UDMA66, UDMA100 and early UDMA133
  *	SiS IDE controllers.
  */
 
-static int sis_66_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int sis_66_cable_detect(struct ata_port *ap)
 {
-	static const struct pci_bits sis_enable_bits[] = {
-		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
-		{ 0x4aU, 1U, 0x04UL, 0x04UL },	/* port 1 */
-	};
-
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
-		return 0;
-	}
 	/* Older chips keep cable detect in bits 4/5 of reg 0x48 */
 	pci_read_config_byte(pdev, 0x48, &tmp);
 	tmp >>= ap->port_no;
 	if ((tmp & 0x10) && !sis_short_ata40(pdev))
-		ap->cbl = ATA_CBL_PATA40;
-	else
-		ap->cbl = ATA_CBL_PATA80;
-
-	return ata_std_prereset(ap, deadline);
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
 }
 
-/**
- *	sis_66_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *	@classes:
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-static void sis_66_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, sis_66_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
 
 /**
- *	sis_old_pre_reset		-	probe begin
+ *	sis_pre_reset		-	probe begin
  *	@ap: ATA port
  *	@deadline: deadline jiffies for the operation
  *
  *	Set up cable type and use generic probe init
  */
 
-static int sis_old_pre_reset(struct ata_port *ap, unsigned long deadline)
+static int sis_pre_reset(struct ata_port *ap, unsigned long deadline)
 {
 	static const struct pci_bits sis_enable_bits[] = {
 		{ 0x4aU, 1U, 0x02UL, 0x02UL },	/* port 0 */
@@ -197,27 +144,23 @@
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
-		return 0;
-	}
-	ap->cbl = ATA_CBL_PATA40;
+	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
+		return -ENOENT;
 	return ata_std_prereset(ap, deadline);
 }
 
 
 /**
- *	sis_old_error_handler - Probe specified port on PATA host controller
+ *	sis_error_handler - Probe specified port on PATA host controller
  *	@ap: Port to probe
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
 
-static void sis_old_error_handler(struct ata_port *ap)
+static void sis_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, sis_old_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, sis_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
 /**
@@ -497,7 +440,7 @@
 	int drive_pci = sis_port_base(adev);
 	u16 timing;
 
-	const u16 udma_bits[]  = { 0x8F00, 0x8A00, 0x8700, 0x8500, 0x8300, 0x8200, 0x8100};
+	static const u16 udma_bits[]  = { 0x8F00, 0x8A00, 0x8700, 0x8500, 0x8300, 0x8200, 0x8100};
 
 	pci_read_config_word(pdev, drive_pci, &timing);
 
@@ -534,8 +477,8 @@
 	u32 reg54;
 
 	/* bits 4- cycle time 8 - cvs time */
-	const u32 timing_u100[] = { 0x6B0, 0x470, 0x350, 0x140, 0x120, 0x110, 0x000 };
-	const u32 timing_u133[] = { 0x9F0, 0x6A0, 0x470, 0x250, 0x230, 0x220, 0x210 };
+	static const u32 timing_u100[] = { 0x6B0, 0x470, 0x350, 0x140, 0x120, 0x110, 0x000 };
+	static const u32 timing_u133[] = { 0x9F0, 0x6A0, 0x470, 0x250, 0x230, 0x220, 0x210 };
 
 	/* If bit 14 is set then the registers are mapped at 0x70 not 0x40 */
 	pci_read_config_dword(pdev, 0x54, &reg54);
@@ -598,8 +541,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_133_error_handler,
+	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= sis_133_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -631,8 +575,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_66_error_handler,
+	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= sis_66_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -664,9 +609,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_66_error_handler,
+	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
-
+	.cable_detect		= sis_66_cable_detect,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -695,10 +640,11 @@
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
+	.cable_detect		= sis_66_cable_detect,
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_66_error_handler,
+	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.bmdma_setup		= ata_bmdma_setup,
@@ -731,8 +677,9 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= sis_old_error_handler,
+	.error_handler		= sis_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
