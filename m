From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata: cable methods
Date: Wed, 11 Apr 2007 00:04:20 +0100
Message-ID: <20070411000420.2eebcc1d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:45159 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161024AbXDJXBZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 19:01:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Versus upstream as requested

Last of the trivial switches to cable_detect methods.

Signed-off-by: Alan Cox <alan@redhat.com>

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index d8e7988..92a491d 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -33,35 +33,6 @@
  */
 
 /**
- *	generic_pre_reset		-	probe begin
- *	@ap: ATA port
- *
- *	Set up cable type and use generic probe init
- */
-
-static int generic_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
-}
-
-
-/**
- *	generic_error_handler - Probe specified port on PATA host controller
- *	@ap: Port to probe
- *	@classes:
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-
-
-static void generic_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, generic_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
-/**
  *	generic_set_mode	-	mode setting
  *	@ap: interface to set up
  *	@unused: returned device on error
@@ -144,8 +115,9 @@ static struct ata_port_operations generi
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= generic_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index a2c5756..55d306a 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -93,7 +93,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"2.10ac1"
+#define DRV_VERSION	"2.11"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
@@ -155,11 +155,11 @@ struct piix_host_priv {
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
 static void piix_pata_error_handler(struct ata_port *ap);
-static void ich_pata_error_handler(struct ata_port *ap);
 static void piix_sata_error_handler(struct ata_port *ap);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode (struct ata_port *ap, struct ata_device *adev);
+static int ich_pata_cable_detect(struct ata_port *ap);
 
 static unsigned int in_module_init = 1;
 
@@ -305,6 +305,7 @@ static const struct ata_port_operations 
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -336,8 +337,9 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ich_pata_error_handler,
+	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ich_pata_cable_detect,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -586,7 +588,7 @@ static const struct ich_laptop ich_lapto
 };
 
 /**
- *	piix_pata_cbl_detect - Probe host controller cable detect info
+ *	ich_pata_cable_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
  *
  *	Read 80c cable indicator from ATA PCI device's PCI config
@@ -596,23 +598,18 @@ static const struct ich_laptop ich_lapto
  *	None (inherited from caller).
  */
 
-static void ich_pata_cbl_detect(struct ata_port *ap)
+static int ich_pata_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	const struct ich_laptop *lap = &ich_laptop[0];
 	u8 tmp, mask;
 
-	/* no 80c support in host controller? */
-	if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
-		goto cbl40;
-
 	/* Check for specials - Acer Aspire 5602WLMi */
 	while (lap->device) {
 		if (lap->device == pdev->device &&
 		    lap->subvendor == pdev->subsystem_vendor &&
 		    lap->subdevice == pdev->subsystem_device) {
-			ap->cbl = ATA_CBL_PATA40_SHORT;
-		    	return;
+			return ATA_CBL_PATA40_SHORT;
 		}
 		lap++;
 	}
@@ -621,20 +618,14 @@ static void ich_pata_cbl_detect(struct a
 	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
-		goto cbl40;
-
-	ap->cbl = ATA_CBL_PATA80;
-	return;
-
-cbl40:
-	ap->cbl = ATA_CBL_PATA40;
+		return ATA_CBL_PATA40;
+	return ATA_CBL_PATA80;
 }
 
 /**
  *	piix_pata_prereset - prereset for PATA host controller
  *	@ap: Target port
  *
- *
  *	LOCKING:
  *	None (inherited from caller).
  */
@@ -644,8 +635,6 @@ static int piix_pata_prereset(struct ata
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
 		return -ENOENT;
-
-	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
 
@@ -656,30 +645,6 @@ static void piix_pata_error_handler(stru
 }
 
 
-/**
- *	ich_pata_prereset - prereset for PATA host controller
- *	@ap: Target port
- *
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-static int ich_pata_prereset(struct ata_port *ap)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
-		return -ENOENT;
-	ich_pata_cbl_detect(ap);
-	return ata_std_prereset(ap);
-}
-
-static void ich_pata_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, ich_pata_prereset, ata_std_softreset, NULL,
-			   ata_std_postreset);
-}
-
 static void piix_sata_error_handler(struct ata_port *ap)
 {
 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 1838176..5a77e4e 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.8"
+#define DRV_VERSION "0.3.8"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -119,32 +119,25 @@ static void timing_setup(struct ata_port
 }
 
 /**
- *	amd_probe_init		-	cable detection
+ *	amd_probe_init		-	perform reset handling
  *	@ap: ATA port
  *
- *	Perform cable detection. The BIOS stores this in PCI config
- *	space for us.
+ *	Reset sequence checking enable bits to see which ports are
+ *	active.
  */
 
 static int amd_pre_reset(struct ata_port *ap)
 {
-	static const u32 bitmask[2] = {0x03, 0x0C};
 	static const struct pci_bits amd_enable_bits[] = {
 		{ 0x40, 1, 0x02, 0x02 },
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 ata66;
 
 	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	pci_read_config_byte(pdev, 0x42, &ata66);
-	if (ata66 & bitmask[ap->port_no])
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 
 }
@@ -156,28 +149,16 @@ static void amd_error_handler(struct ata
 				      ata_std_postreset);
 }
 
-static int amd_early_pre_reset(struct ata_port *ap)
+static int amd_cable_detect(struct ata_port *ap)
 {
+	static const u32 bitmask[2] = {0x03, 0x0C};
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	static struct pci_bits amd_enable_bits[] = {
-		{ 0x40, 1, 0x02, 0x02 },
-		{ 0x40, 1, 0x01, 0x01 }
-	};
-
-	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
-		return -ENOENT;
-
-	/* No host side cable detection */
-	ap->cbl = ATA_CBL_PATA80;
-	return ata_std_prereset(ap);
-
-}
+	u8 ata66;
 
-static void amd_early_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, amd_early_pre_reset,
-			       ata_std_softreset, NULL,
-			       ata_std_postreset);
+	pci_read_config_byte(pdev, 0x42, &ata66);
+	if (ata66 & bitmask[ap->port_no])
+		return ATA_CBL_PATA80;
+	return ATA_CBL_PATA40;
 }
 
 /**
@@ -247,31 +228,16 @@ static void amd133_set_dmamode(struct at
  */
 
 static int nv_pre_reset(struct ata_port *ap) {
-	static const u8 bitmask[2] = {0x03, 0x0C};
 	static const struct pci_bits nv_enable_bits[] = {
 		{ 0x50, 1, 0x02, 0x02 },
 		{ 0x50, 1, 0x01, 0x01 }
 	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 ata66;
-	u16 udma;
 
 	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no]))
 		return -ENOENT;
 
-	pci_read_config_byte(pdev, 0x52, &ata66);
-	if (ata66 & bitmask[ap->port_no])
-		ap->cbl = ATA_CBL_PATA80;
-	else
-		ap->cbl = ATA_CBL_PATA40;
-
-	/* We now have to double check because the Nvidia boxes BIOS
-	   doesn't always set the cable bits but does set mode bits */
-
-	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
-	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
-		ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap);
 }
 
@@ -281,6 +247,29 @@ static void nv_error_handler(struct ata_
 			       ata_std_softreset, NULL,
 			       ata_std_postreset);
 }
+
+static int nv_cable_detect(struct ata_port *ap)
+{
+	static const u8 bitmask[2] = {0x03, 0x0C};
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 ata66;
+	u16 udma;
+	int cbl;
+
+	pci_read_config_byte(pdev, 0x52, &ata66);
+	if (ata66 & bitmask[ap->port_no])
+		cbl = ATA_CBL_PATA80;
+	else
+		cbl = ATA_CBL_PATA40;
+
+ 	/* We now have to double check because the Nvidia boxes BIOS
+ 	   doesn't always set the cable bits but does set mode bits */
+ 	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
+ 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
+		cbl = ATA_CBL_PATA80;
+	return cbl;
+}
+
 /**
  *	nv100_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -353,8 +342,9 @@ static struct ata_port_operations amd33_
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_early_error_handler,
+	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -387,8 +377,9 @@ static struct ata_port_operations amd66_
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= amd_early_error_handler,
+	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -423,6 +414,7 @@ static struct ata_port_operations amd100
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_unknown,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -457,6 +449,7 @@ static struct ata_port_operations amd133
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= amd_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= amd_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -491,6 +484,7 @@ static struct ata_port_operations nv100_
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= nv_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -525,6 +519,7 @@ static struct ata_port_operations nv133_
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= nv_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -644,6 +639,11 @@ static int amd_init_one(struct pci_dev *
 	if (type == 1 && rev > 0x7)
 		type = 2;
 
+#if defined(CONFIG_ATA_ACPI)
+	/* Prefer the ACPI driver for Nvidia hardware */
+	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA && ata_pata_acpi_present(pdev))
+		return -ENODEV;
+#endif
 	/* Check for AMD7411 */
 	if (type == 3)
 		/* FIFO is broken */
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 1572e5c..08cccc9 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -70,36 +70,23 @@
 #define CS5535_BAD_PIO(timings) ( (timings&~0x80000000UL)==0x00009172 )
 
 /**
- *	cs5535_pre_reset	-	detect cable type
+ *	cs5535_cable_detect	-	detect cable type
  *	@ap: Port to detect on
  *
  *	Perform cable detection for ATA66 capable cable. Return a libata
  *	cable type.
  */
 
-static int cs5535_pre_reset(struct ata_port *ap)
+static int cs5535_cable_detect(struct ata_port *ap)
 {
 	u8 cable;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
 	pci_read_config_byte(pdev, CS5535_CABLE_DETECT, &cable);
 	if (cable & 1)
-		ap->cbl = ATA_CBL_PATA80;
+		return ATA_CBL_PATA80;
 	else
-		ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-/**
- *	cs5535_error_handler		-	reset/probe
- *	@ap: Port to reset
- *
- *	Reset and configure a port
- */
-
-static void cs5535_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, cs5535_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+		return ATA_CBL_PATA40;
 }
 
 /**
@@ -205,8 +192,9 @@ static struct ata_port_operations cs5535
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cs5535_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= cs5535_cable_detect,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index f69dde5..6ec049c 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -41,17 +41,6 @@ enum {
 	CY82_INDEX_TIMEOUT	= 0x32
 };
 
-static int cy82c693_pre_reset(struct ata_port *ap)
-{
-	ap->cbl = ATA_CBL_PATA40;
-	return ata_std_prereset(ap);
-}
-
-static void cy82c693_error_handler(struct ata_port *ap)
-{
-	ata_bmdma_drive_eh(ap, cy82c693_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
-}
-
 /**
  *	cy82c693_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -156,8 +145,9 @@ static struct ata_port_operations cy82c6
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
-	.error_handler	= cy82c693_error_handler,
+	.error_handler	= ata_bmdma_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index c3e5ea3..93cfa6d 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -169,7 +169,6 @@ static int hpt_dma_blacklisted(const str
 
 /**
  *	hpt366_filter	-	mode selection filter
- *	@ap: ATA interface
  *	@adev: ATA device
  *
  *	Block UDMA on devices that cause trouble with this controller.
