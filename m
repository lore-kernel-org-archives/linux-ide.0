From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/9] libata: stop overloading port_info->private_data
Date: Wed, 30 Jan 2008 18:29:01 +0900
Message-ID: <1201685344817-git-send-email-htejun@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:35445 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036AbYA3J3S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so277515wah.23
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:18 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to
Cc: Tejun Heo <htejun@gmail.com>

port_info->private_data is currently used for two purposes - to record
private data about the port_info or to specify host->private_data to
use when allocating ata_host.

This overloading is confusing and counter-intuitive in that
port_info->private_data becomes host->private_data instead of
port->private_data.  In addition, port_info and host don't correspond
to each other 1-to-1.  Currently, the first non-NULL
port_info->private_data is used.

This patch makes port_info->private_data just be what it is -
private_data for the port_info where LLD can jot down extra info.
libata no longer sets host->private_data to the first non-NULL
port_info->private_data.  host->private_data now should be set
directly after allocating/prepping ata_host just as ap->private_data
is set.

This means that ata_pci_init_one() can't be used for drivers which
require host->private_data.  The conversion is cheap.  This patch
converts all six low level drivers which need such conversion and the
number of added lines is only around 20.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c  |    2 --
 drivers/ata/pata_amd.c     |   17 +++++++++++------
 drivers/ata/pata_hpt366.c  |   18 +++++++++++-------
 drivers/ata/pata_hpt37x.c  |   40 +++++++++++++++++++++-------------------
 drivers/ata/pata_hpt3x2n.c |   14 +++++++++-----
 drivers/ata/pata_sis.c     |   24 ++++++++++++++----------
 drivers/ata/pata_via.c     |   24 ++++++++++++++----------
 7 files changed, 80 insertions(+), 59 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 65d082c..a791525 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6907,8 +6907,6 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 
 		if (!host->ops && (pi->port_ops != &ata_dummy_port_ops))
 			host->ops = pi->port_ops;
-		if (!host->private_data && pi->private_data)
-			host->private_data = pi->private_data;
 	}
 
 	return host;
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 9ce6cd9..461c8f6 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -484,10 +484,10 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			.port_ops = &amd100_port_ops
 		}
 	};
-	struct ata_port_info pi;
-	const struct ata_port_info *ppi[] = { &pi, NULL };
+	const struct ata_port_info *ppi[] = { NULL, NULL };
 	static int printed_version;
 	int type = id->driver_data;
+	struct ata_host *host;
 	u8 fifo;
 	int rc;
 
@@ -510,9 +510,13 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		type = 6;	/* UDMA 100 only */
 
 	/*
-	 * Okay, type is determined now.  Apply type-specific workarounds.
+	 * Okay, type is determined now.  Prepare host and apply
+	 * type-specific workarounds.
 	 */
-	pi = info[type];
+	*ppi = &info[type];
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
 
 	if (type < 3)
 		ata_pci_clear_simplex(pdev);
@@ -531,11 +535,12 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		u32 udma;
 
 		pci_read_config_dword(pdev, 0x60, &udma);
-		pi.private_data = (void *)(unsigned long)udma;
+		host->private_data = (void *)(unsigned long)udma;
 	}
 
 	/* And fire it up */
-	return ata_pci_init_one(pdev, ppi, &amd_sht);
+	pci_set_master(pdev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &amd_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 512cba5..5534060 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -356,9 +356,8 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA4,
 		.port_ops = &hpt366_port_ops
 	};
-	struct ata_port_info info = info_hpt366;
-	const struct ata_port_info *ppi[] = { &info, NULL };
-
+	const struct ata_port_info *ppi[] = { &info_hpt366, NULL };
+	struct ata_host *host;
 	u32 class_rev;
 	u32 reg1;
 	int rc;
@@ -367,6 +366,10 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = ata_pci_prepare_sff_host(dev, ppi, &host);
+	if (rc)
+		return rc;
+
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
 
@@ -383,17 +386,18 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	/* info_hpt366 is safe against re-entry so we can scribble on it */
 	switch((reg1 & 0x700) >> 8) {
 		case 5:
-			info.private_data = &hpt366_40;
+			host->private_data = &hpt366_40;
 			break;
 		case 9:
-			info.private_data = &hpt366_25;
+			host->private_data = &hpt366_25;
 			break;
 		default:
-			info.private_data = &hpt366_33;
+			host->private_data = &hpt366_33;
 			break;
 	}
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt36x_sht);
+	pci_set_master(dev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &hpt36x_sht);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 97fc5dc..16ec8f4 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -831,10 +831,9 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 
 	static const int MHz[4] = { 33, 40, 50, 66 };
-	const struct ata_port_info *port;
+	const struct ata_port_info *ppi[] = { NULL, NULL };
 	void *private_data = NULL;
-	struct ata_port_info port_info;
-	const struct ata_port_info *ppi[] = { &port_info, NULL };
+	struct ata_host *host;
 
 	u8 irqmask;
 	u32 class_rev;
@@ -866,17 +865,17 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 		switch(class_rev) {
 			case 3:
-				port = &info_hpt370;
+				*ppi = &info_hpt370;
 				chip_table = &hpt370;
 				prefer_dpll = 0;
 				break;
 			case 4:
-				port = &info_hpt370a;
+				*ppi = &info_hpt370a;
 				chip_table = &hpt370a;
 				prefer_dpll = 0;
 				break;
 			case 5:
-				port = &info_hpt372;
+				*ppi = &info_hpt372;
 				chip_table = &hpt372;
 				break;
 			default:
@@ -889,21 +888,21 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				/* 372N if rev >= 2*/
 				if (class_rev >= 2)
 					return -ENODEV;
-				port = &info_hpt372;
+				*ppi = &info_hpt372;
 				chip_table = &hpt372a;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT302:
 				/* 302N if rev > 1 */
 				if (class_rev > 1)
 					return -ENODEV;
-				port = &info_hpt372;
+				*ppi = &info_hpt372;
 				/* Check this */
 				chip_table = &hpt302;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT371:
 				if (class_rev > 1)
 					return -ENODEV;
-				port = &info_hpt372;
+				*ppi = &info_hpt372;
 				chip_table = &hpt371;
 				/* Single channel device, master is not present
 				   but the BIOS (or us for non x86) must mark it
@@ -914,7 +913,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				break;
 			case PCI_DEVICE_ID_TTI_HPT374:
 				chip_table = &hpt374;
-				port = &info_hpt374;
+				*ppi = &info_hpt374;
 				break;
 			default:
 				printk(KERN_ERR "pata_hpt37x: PCI table is bogus please report (%d).\n", dev->device);
@@ -993,7 +992,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		int dpll, adjust;
 
 		/* Compute DPLL */
-		dpll = (port->udma_mask & 0xC0) ? 3 : 2;
+		dpll = ((*ppi)->udma_mask & 0xC0) ? 3 : 2;
 
 		f_low = (MHz[clock_slot] * 48) / MHz[dpll];
 		f_high = f_low + 2;
@@ -1033,19 +1032,22 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		 *	about lack of UDMA133 support on lower clocks
  		 */
 
-		if (clock_slot < 2 && port == &info_hpt370)
-			port = &info_hpt370_33;
-		if (clock_slot < 2 && port == &info_hpt370a)
-			port = &info_hpt370a_33;
+		if (clock_slot < 2 && *ppi == &info_hpt370)
+			*ppi = &info_hpt370_33;
+		if (clock_slot < 2 && *ppi == &info_hpt370a)
+			*ppi = &info_hpt370a_33;
 		printk(KERN_INFO "pata_hpt37x: %s using %dMHz bus clock.\n",
 		       chip_table->name, MHz[clock_slot]);
 	}
 
-	/* Now kick off ATA set up */
-	port_info = *port;
-	port_info.private_data = private_data;
+	/* prepare host and kick off */
+	rc = ata_pci_prepare_sff_host(dev, ppi, &host);
+	if (rc)
+		return rc;
+	host->private_data = private_data;
 
-	return ata_pci_init_one(dev, ppi, &hpt37x_sht);
+	pci_set_master(dev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &hpt37x_sht);
 }
 
 static const struct pci_device_id hpt37x[] = {
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 2c178c3..616f7a5 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -458,8 +458,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA6,
 		.port_ops = &hpt3x2n_port_ops
 	};
-	struct ata_port_info port = info;
-	const struct ata_port_info *ppi[] = { &port, NULL };
+	const struct ata_port_info *ppi[] = { &info, NULL };
+	struct ata_host *host;
 
 	u8 irqmask;
 	u32 class_rev;
@@ -474,6 +474,10 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = ata_pci_prepare_sff_host(dev, ppi, &host);
+	if (rc)
+		return rc;
+
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
 
@@ -554,9 +558,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	       pci_mhz);
 	/* Set our private data up. We only need a few flags so we use
 	   it directly */
-	port.private_data = NULL;
 	if (pci_mhz > 60) {
-		port.private_data = (void *)PCI66;
+		host->private_data = (void *)PCI66;
 		/*
 		 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
 		 * the MISC. register to stretch the UltraDMA Tss timing.
@@ -567,7 +570,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt3x2n_sht);
+	pci_set_master(dev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &hpt3x2n_sht);
 }
 
 static const struct pci_device_id hpt3x2n[] = {
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 1d8cf11..45c689c 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -690,11 +690,11 @@ static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info port;
-	const struct ata_port_info *ppi[] = { &port, NULL };
-	struct pci_dev *host = NULL;
+	const struct ata_port_info *ppi[] = { NULL, NULL };
+	struct pci_dev *bridge = NULL;
 	struct sis_chipset *chipset = NULL;
 	struct sis_chipset *sets;
+	struct ata_host *host;
 	int rc;
 
 	static struct sis_chipset sis_chipsets[] = {
@@ -754,11 +754,11 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* We have to find the bridge first */
 	for (sets = &sis_chipsets[0]; sets->device; sets++) {
-		host = pci_get_device(PCI_VENDOR_ID_SI, sets->device, NULL);
-		if (host != NULL) {
+		bridge = pci_get_device(PCI_VENDOR_ID_SI, sets->device, NULL);
+		if (bridge != NULL) {
 			chipset = sets;			/* Match found */
 			if (sets->device == 0x630) {	/* SIS630 */
-				if (host->revision >= 0x30)	/* 630 ET */
+				if (bridge->revision >= 0x30)	/* 630 ET */
 					chipset = &sis100_early;
 			}
 			break;
@@ -825,18 +825,22 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			break;
 		}
 	}
-	pci_dev_put(host);
+	pci_dev_put(bridge);
 
 	/* No chipset info, no support */
 	if (chipset == NULL)
 		return -ENODEV;
 
-	port = *chipset->info;
-	port.private_data = chipset;
+	*ppi = chipset->info;
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
+	host->private_data = chipset;
 
 	sis_fixup(pdev, chipset);
 
-	return ata_pci_init_one(pdev, ppi, &sis_sht);
+	pci_set_master(pdev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &sis_sht);
 }
 
 static const struct pci_device_id sis_pci_tbl[] = {
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index affb665..3ccee4f 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -438,10 +438,10 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA6,	/* FIXME: should check north bridge */
 		.port_ops = &via_port_ops
 	};
-	struct ata_port_info type;
-	const struct ata_port_info *ppi[] = { &type, NULL };
+	const struct ata_port_info *ppi[] = { NULL, NULL };
 	struct pci_dev *isa = NULL;
 	const struct via_isa_bridge *config;
+	struct ata_host *host;
 	static int printed_version;
 	u8 enable;
 	u32 timing;
@@ -487,25 +487,25 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	switch(config->flags & VIA_UDMA) {
 		case VIA_UDMA_NONE:
 			if (config->flags & VIA_NO_UNMASK)
-				type = via_mwdma_info_borked;
+				*ppi = &via_mwdma_info_borked;
 			else
-				type = via_mwdma_info;
+				*ppi = &via_mwdma_info;
 			break;
 		case VIA_UDMA_33:
-			type = via_udma33_info;
+			*ppi = &via_udma33_info;
 			break;
 		case VIA_UDMA_66:
-			type = via_udma66_info;
+			*ppi = &via_udma66_info;
 			/* The 66 MHz devices require we enable the clock */
 			pci_read_config_dword(pdev, 0x50, &timing);
 			timing |= 0x80008;
 			pci_write_config_dword(pdev, 0x50, timing);
 			break;
 		case VIA_UDMA_100:
-			type = via_udma100_info;
+			*ppi = &via_udma100_info;
 			break;
 		case VIA_UDMA_133:
-			type = via_udma133_info;
+			*ppi = &via_udma133_info;
 			break;
 		default:
 			WARN_ON(1);
@@ -520,9 +520,13 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	/* We have established the device type, now fire it up */
-	type.private_data = (void *)config;
+	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
+	if (rc)
+		return rc;
+	host->private_data = (void *)config;
 
-	return ata_pci_init_one(pdev, ppi, &via_sht);
+	pci_set_master(pdev);
+	return ata_pci_activate_sff_host(host, ata_interrupt, &via_sht);
 }
 
 #ifdef CONFIG_PM
-- 
1.5.2.4

