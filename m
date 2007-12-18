From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/5] pata_amd: update mode selection for NV PATAs
Date: Tue, 18 Dec 2007 16:33:07 +0900
Message-ID: <11979631882886-git-send-email-htejun@gmail.com>
References: <1197963187184-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:64085 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934776AbXLRHdT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 02:33:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2173663rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 17 Dec 2007 23:33:19 -0800 (PST)
In-Reply-To: <1197963187184-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Cable detection on NV PATA hosts isn't implemented and the CBLID-
cable isn't wired according to the sepc either, so both host-side and
generic drive-side cable detections are broken.  Till now,
nv_cable_detect() relied on peeking BIOS and ACPI configurations to
upgrade to 80C but this often results in misdetection of 40C cable as
80C.  Also, the original implementation was broken in that by the time
BIOS configuration is read it has already been cleared by programming
PIO0 during reset.

This patch reimplements NV mode selection such that...

* BIOS configuration value is stored during driver attach and restored
  on detach.

* Cable type is fixed to ATA_CBL_PATA_IGN and mode selection is soley
  done by nv_mode_filter() which peeks both BIOS and ACPI
  configurations and filter accordingly.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/pata_amd.c |  129 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 93 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index e71125a..761a666 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -220,6 +220,62 @@ static void amd133_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	timing_setup(ap, adev, 0x40, adev->dma_mode, 4);
 }
 
+/* Both host-side and drive-side detection results are worthless on NV
+ * PATAs.  Ignore them and just follow what BIOS configured.  Both the
+ * current configuration in PCI config reg and ACPI GTM result are
+ * cached during driver attach and are consulted to select transfer
+ * mode.
+ */
+static unsigned long nv_mode_filter(struct ata_device *dev,
+				    unsigned long xfer_mask)
+{
+	static const unsigned int udma_mask_map[] =
+		{ ATA_UDMA2, ATA_UDMA1, ATA_UDMA0, 0,
+		  ATA_UDMA3, ATA_UDMA4, ATA_UDMA5, ATA_UDMA6 };
+	struct ata_port *ap = dev->link->ap;
+	char acpi_str[32] = "";
+	u32 saved_udma, udma;
+	const struct ata_acpi_gtm *gtm;
+	unsigned long bios_limit = 0, acpi_limit = 0, limit;
+
+	/* find out what BIOS configured */
+	udma = saved_udma = (unsigned long)ap->host->private_data;
+
+	if (ap->port_no == 0)
+		udma >>= 16;
+	if (dev->devno == 0)
+		udma >>= 8;
+
+	if ((udma & 0xc0) == 0xc0)
+		bios_limit = ata_pack_xfermask(0, 0, udma_mask_map[udma & 0x7]);
+
+	/* consult ACPI GTM too */
+	gtm = ata_acpi_init_gtm(ap);
+	if (gtm) {
+		acpi_limit = ata_acpi_gtm_xfermask(dev, gtm);
+
+		snprintf(acpi_str, sizeof(acpi_str), " (%u:%u:0x%x)",
+			 gtm->drive[0].dma, gtm->drive[1].dma, gtm->flags);
+	}
+
+	/* be optimistic, EH can take care of things if something goes wrong */
+	limit = bios_limit | acpi_limit;
+
+	/* If PIO or DMA isn't configured at all, don't limit.  Let EH
+	 * handle it.
+	 */
+	if (!(limit & ATA_MASK_PIO))
+		limit |= ATA_MASK_PIO;
+	if (!(limit & (ATA_MASK_MWDMA | ATA_MASK_UDMA)))
+		limit |= ATA_MASK_MWDMA | ATA_MASK_UDMA;
+
+	ata_port_printk(ap, KERN_DEBUG, "nv_mode_filter: 0x%lx&0x%lx->0x%lx, "
+			"BIOS=0x%lx (0x%x) ACPI=0x%lx%s\n",
+			xfer_mask, limit, xfer_mask & limit, bios_limit,
+			saved_udma, acpi_limit, acpi_str);
+
+	return xfer_mask & limit;
+}
 
 /**
  *	nv_probe_init	-	cable detection
@@ -252,32 +308,6 @@ static void nv_error_handler(struct ata_port *ap)
 			       ata_std_postreset);
 }
 
-static int nv_cable_detect(struct ata_port *ap)
-{
-	static const u8 bitmask[2] = {0x03, 0x0C};
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u8 ata66;
-	u16 udma;
-	int cbl;
-
-	pci_read_config_byte(pdev, 0x52, &ata66);
-	if (ata66 & bitmask[ap->port_no])
-		cbl = ATA_CBL_PATA80;
-	else
-		cbl = ATA_CBL_PATA40;
-
- 	/* We now have to double check because the Nvidia boxes BIOS
- 	   doesn't always set the cable bits but does set mode bits */
- 	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
- 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
-		cbl = ATA_CBL_PATA80;
-	/* And a triple check across suspend/resume with ACPI around */
-	if (ata_acpi_init_gtm(ap) &&
-	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
-		cbl = ATA_CBL_PATA80;
-	return cbl;
-}
-
 /**
  *	nv100_set_piomode	-	set initial PIO mode data
  *	@ap: ATA interface
@@ -315,6 +345,14 @@ static void nv133_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	timing_setup(ap, adev, 0x50, adev->dma_mode, 4);
 }
 
+static void nv_host_stop(struct ata_host *host)
+{
+	u32 udma = (unsigned long)host->private_data;
+
+	/* restore PCI config register 0x60 */
+	pci_write_config_dword(to_pci_dev(host->dev), 0x60, udma);
+}
+
 static struct scsi_host_template amd_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -479,7 +517,8 @@ static struct ata_port_operations nv100_port_ops = {
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= nv_cable_detect,
+	.cable_detect	= ata_cable_ignore,
+	.mode_filter	= nv_mode_filter,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -496,6 +535,7 @@ static struct ata_port_operations nv100_port_ops = {
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
+	.host_stop	= nv_host_stop,
 };
 
 static struct ata_port_operations nv133_port_ops = {
@@ -512,7 +552,8 @@ static struct ata_port_operations nv133_port_ops = {
 	.thaw		= ata_bmdma_thaw,
 	.error_handler	= nv_error_handler,
 	.post_internal_cmd = ata_bmdma_post_internal_cmd,
-	.cable_detect	= nv_cable_detect,
+	.cable_detect	= ata_cable_ignore,
+	.mode_filter	= nv_mode_filter,
 
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
@@ -529,6 +570,7 @@ static struct ata_port_operations nv133_port_ops = {
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
+	.host_stop	= nv_host_stop,
 };
 
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -615,7 +657,8 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd100_port_ops
 		}
 	};
-	const struct ata_port_info *ppi[] = { NULL, NULL };
+	struct ata_port_info pi;
+	const struct ata_port_info *ppi[] = { &pi, NULL };
 	static int printed_version;
 	int type = id->driver_data;
 	u8 fifo;
@@ -629,6 +672,19 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (type == 1 && pdev->revision > 0x7)
 		type = 2;
 
+	/* Serenade ? */
+	if (type == 5 && pdev->subsystem_vendor == PCI_VENDOR_ID_AMD &&
+			 pdev->subsystem_device == PCI_DEVICE_ID_AMD_SERENADE)
+		type = 6;	/* UDMA 100 only */
+
+	/*
+	 * Okay, type is determined now.  Apply type-specific workarounds.
+	 */
+	pi = info[type];
+
+	if (type < 3)
+		ata_pci_clear_simplex(pdev);
+
 	/* Check for AMD7411 */
 	if (type == 3)
 		/* FIFO is broken */
@@ -636,16 +692,17 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		pci_write_config_byte(pdev, 0x41, fifo | 0xF0);
 
-	/* Serenade ? */
-	if (type == 5 && pdev->subsystem_vendor == PCI_VENDOR_ID_AMD &&
-			 pdev->subsystem_device == PCI_DEVICE_ID_AMD_SERENADE)
-		type = 6;	/* UDMA 100 only */
+	/* Cable detection on Nvidia chips doesn't work too well,
+	 * cache BIOS programmed UDMA mode.
+	 */
+	if (type == 7 || type == 8) {
+		u32 udma;
 
-	if (type < 3)
-		ata_pci_clear_simplex(pdev);
+		pci_read_config_dword(pdev, 0x60, &udma);
+		pi.private_data = (void *)(unsigned long)udma;
+	}
 
 	/* And fire it up */
-	ppi[0] = &info[type];
 	return ata_pci_init_one(pdev, ppi);
 }
 
-- 
1.5.2.4

