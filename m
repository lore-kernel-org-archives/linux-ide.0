From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] pata_amd: fix and improve cable detection
Date: Sat, 03 Nov 2007 00:22:24 +0900
Message-ID: <472B40B0.6010702@gmail.com>
References: <472B402A.4030009@gmail.com> <472B4078.90009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11873 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbXKBPWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 11:22:34 -0400
Received: by nz-out-0506.google.com with SMTP id s18so683874nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 08:22:33 -0700 (PDT)
In-Reply-To: <472B4078.90009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Cable detection on Nvidia PATA hosts is pathetic.  The current
nv_cable_detect() assumes that the native cable detection only
mistakes 80c as 40c but this isn't true.  On ASUS A8N-E, cable
register almost always says 80c is attached and it also manages to
trick the drive that the cable is 80c.

Also, BIOS checking, and before the get_acpi_cbl() update ACPI
checking too, in the current implementation were useless because they
read the setting _after_ reset is complete which forces the host into
PIO0, so they never triggered.

Reimplement nv_cable_detect() such that...

* BIOS setting is cached during controller initialization and restored
  on driver detach.

* BIOS and ACPI cable results are considered more important.  Native
  cable bits are used iff both BIOS and ACPI results are PATA_UNK.  If
  BIOS or ACPI indicates 80c, it's 80c.  If none indicates 80c, it's
  40c.

This change makes cable detection work correctly all the time on ASUS
A8N-E and should also work well on other NV PATA configurations.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_amd.c |  112 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 22 deletions(-)

Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -255,26 +255,69 @@ static int nv_cable_detect(struct ata_po
 {
 	static const u8 bitmask[2] = {0x03, 0x0C};
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct ata_device *dev;
+	char acpi_str[32] = "";
+	int native_cbl, bios_cbl, acpi_cbl, verdict;
+	u32 saved_udma, udma;
 	u8 ata66;
-	u16 udma;
-	int cbl;
 
+	/* native method, this is usually broken */
 	pci_read_config_byte(pdev, 0x52, &ata66);
 	if (ata66 & bitmask[ap->port_no])
-		cbl = ATA_CBL_PATA80;
+		native_cbl = ATA_CBL_PATA80;
 	else
-		cbl = ATA_CBL_PATA40;
+		native_cbl = ATA_CBL_PATA40;
 
- 	/* We now have to double check because the Nvidia boxes BIOS
- 	   doesn't always set the cable bits but does set mode bits */
- 	pci_read_config_word(pdev, 0x62 - 2 * ap->port_no, &udma);
- 	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
-		cbl = ATA_CBL_PATA80;
-	/* And a triple check across suspend/resume with ACPI around */
-	if ((ap->pflags & ATA_PFLAG_INIT_GTM_VALID) &&
-	    ata_acpi_cbl(ap, &ap->acpi_init_gtm) == ATA_CBL_PATA80)
-		cbl = ATA_CBL_PATA80;
-	return cbl;
+	/* peek BIOS configuration */
+	bios_cbl = ATA_CBL_PATA_UNK;
+
+	saved_udma = udma = (unsigned long)ap->host->private_data;
+	if (ap->port_no == 0)
+		udma >>= 16;
+
+	ata_link_for_each_dev(dev, &ap->link) {
+		u32 tmp = udma;
+
+		if (dev->devno == 0)
+			tmp >>= 8;
+
+		if (!ata_dev_enabled(dev) || (tmp & 0xC0) != 0xC0)
+			continue;
+
+		if (tmp & 0x4)
+			bios_cbl = ATA_CBL_PATA80;
+		else
+			bios_cbl = ATA_CBL_PATA40;
+	}
+
+	/* and ACPI configuration */
+	acpi_cbl = ATA_CBL_PATA_UNK;
+	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
+		acpi_cbl = ata_acpi_cbl(ap, &ap->acpi_init_gtm);
+
+	/* Three values collected.  Native value is usually
+	 * untrustworthy.  Consider it iff both BIOS and ACPI values
+	 * are unknown; otherwise, choose higher of the two.
+	 */
+	if (bios_cbl == ATA_CBL_PATA_UNK && acpi_cbl == ATA_CBL_PATA_UNK)
+		verdict = native_cbl;
+	else if (bios_cbl == ATA_CBL_PATA80 || acpi_cbl == ATA_CBL_PATA80)
+		verdict = ATA_CBL_PATA80;
+	else
+		verdict = ATA_CBL_PATA40;
+
+	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
+		snprintf(acpi_str, sizeof(acpi_str), " (%u:%u:0x%x)",
+			 ap->acpi_init_gtm.drive[0].dma,
+			 ap->acpi_init_gtm.drive[1].dma,
+			 ap->acpi_init_gtm.flags);
+
+	ata_port_printk(ap, KERN_DEBUG, "nv_cable_detect: native=%d (0x%x) "
+			"BIOS=%d (0x%x) ACPI=%d%s verdict=%d\n",
+			native_cbl, ata66, bios_cbl, saved_udma, acpi_cbl,
+			acpi_str, verdict);
+
+	return verdict;
 }
 
 /**
@@ -314,6 +357,14 @@ static void nv133_set_dmamode(struct ata
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
@@ -495,6 +546,7 @@ static struct ata_port_operations nv100_
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
+	.host_stop	= nv_host_stop,
 };
 
 static struct ata_port_operations nv133_port_ops = {
@@ -528,6 +580,7 @@ static struct ata_port_operations nv133_
 	.irq_on		= ata_irq_on,
 
 	.port_start	= ata_sff_port_start,
+	.host_stop	= nv_host_stop,
 };
 
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -614,7 +667,8 @@ static int amd_init_one(struct pci_dev *
 			.port_ops = &amd100_port_ops
 		}
 	};
-	const struct ata_port_info *ppi[] = { NULL, NULL };
+	struct ata_port_info pi;
+	const struct ata_port_info *ppi[] = { &pi, NULL };
 	static int printed_version;
 	int type = id->driver_data;
 	u8 fifo;
@@ -628,6 +682,19 @@ static int amd_init_one(struct pci_dev *
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
@@ -635,16 +702,17 @@ static int amd_init_one(struct pci_dev *
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
 
