From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/10] libata: stop overloading port_info->private_data
Date: Tue, 12 Feb 2008 17:43:19 +0900
Message-ID: <12028058033726-git-send-email-htejun@gmail.com>
References: <1202805801343-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:10453 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYBLInq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 03:43:46 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3595166rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 00:43:46 -0800 (PST)
In-Reply-To: <1202805801343-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

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
port_info->private_data, @host_priv argument is added to
ata_pci_init_one() instead.  LLDs which use ata_pci_init_one() can use
this argument to pass in pointer to host private data.  LLDs which
don't should use init-register model anyway and can initialize
host->private_data directly.

Adding @host_priv instead of using init-register model for LLDs which
use ata_pci_init_one() is suggested by Alan Cox.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/ata_generic.c       |    2 +-
 drivers/ata/libata-core.c       |    2 --
 drivers/ata/libata-sff.c        |    4 +++-
 drivers/ata/pata_acpi.c         |    2 +-
 drivers/ata/pata_ali.c          |    2 +-
 drivers/ata/pata_amd.c          |   10 +++++-----
 drivers/ata/pata_artop.c        |    2 +-
 drivers/ata/pata_atiixp.c       |    2 +-
 drivers/ata/pata_cmd640.c       |    2 +-
 drivers/ata/pata_cmd64x.c       |    2 +-
 drivers/ata/pata_cs5530.c       |    2 +-
 drivers/ata/pata_cs5535.c       |    2 +-
 drivers/ata/pata_cs5536.c       |    2 +-
 drivers/ata/pata_cypress.c      |    2 +-
 drivers/ata/pata_efar.c         |    2 +-
 drivers/ata/pata_hpt366.c       |   12 ++++++------
 drivers/ata/pata_hpt37x.c       |   33 ++++++++++++++-------------------
 drivers/ata/pata_hpt3x2n.c      |    9 ++++-----
 drivers/ata/pata_it8213.c       |    2 +-
 drivers/ata/pata_it821x.c       |    2 +-
 drivers/ata/pata_jmicron.c      |    2 +-
 drivers/ata/pata_marvell.c      |    2 +-
 drivers/ata/pata_netcell.c      |    2 +-
 drivers/ata/pata_ns87410.c      |    2 +-
 drivers/ata/pata_ns87415.c      |    2 +-
 drivers/ata/pata_oldpiix.c      |    2 +-
 drivers/ata/pata_opti.c         |    2 +-
 drivers/ata/pata_optidma.c      |    2 +-
 drivers/ata/pata_pdc202xx_old.c |    2 +-
 drivers/ata/pata_radisys.c      |    2 +-
 drivers/ata/pata_rz1000.c       |    2 +-
 drivers/ata/pata_sc1200.c       |    2 +-
 drivers/ata/pata_serverworks.c  |    2 +-
 drivers/ata/pata_sil680.c       |    2 +-
 drivers/ata/pata_sis.c          |    8 +++-----
 drivers/ata/pata_sl82c105.c     |    2 +-
 drivers/ata/pata_triflex.c      |    2 +-
 drivers/ata/pata_via.c          |   19 ++++++++-----------
 include/linux/libata.h          |    2 +-
 39 files changed, 74 insertions(+), 85 deletions(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index a912ee0..b23e2a1 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -152,7 +152,7 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
 	if (dev->vendor == PCI_VENDOR_ID_AL)
 	    	ata_pci_clear_simplex(dev);
 
-	return ata_pci_init_one(dev, ppi, &generic_sht);
+	return ata_pci_init_one(dev, ppi, &generic_sht, NULL);
 }
 
 static struct pci_device_id ata_generic[] = {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bb42dd5..685e3c7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6905,8 +6905,6 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 
 		if (!host->ops && (pi->port_ops != &ata_dummy_port_ops))
 			host->ops = pi->port_ops;
-		if (!host->private_data && pi->private_data)
-			host->private_data = pi->private_data;
 	}
 
 	return host;
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 24f6dc5..538b4af 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -819,6 +819,7 @@ int ata_pci_activate_sff_host(struct ata_host *host,
  *	@pdev: Controller to be initialized
  *	@ppi: array of port_info, must be enough for two ports
  *	@sht: scsi_host_template to use when registering the host
+ *	@host_priv: host private_data
  *
  *	This is a helper function which can be called from a driver's
  *	xxx_init_one() probe function if the hardware uses traditional
@@ -840,7 +841,7 @@ int ata_pci_activate_sff_host(struct ata_host *host,
  */
 int ata_pci_init_one(struct pci_dev *pdev,
 		     const struct ata_port_info * const * ppi,
-		     struct scsi_host_template *sht)
+		     struct scsi_host_template *sht, void *host_priv)
 {
 	struct device *dev = &pdev->dev;
 	const struct ata_port_info *pi = NULL;
@@ -874,6 +875,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 	rc = ata_pci_prepare_sff_host(pdev, ppi, &host);
 	if (rc)
 		goto out;
+	host->private_data = host_priv;
 
 	pci_set_master(pdev);
 	rc = ata_pci_activate_sff_host(host, ata_interrupt, sht);
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index d55778a..7dd28fd 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -273,7 +273,7 @@ static int pacpi_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &pacpi_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(pdev, ppi, &pacpi_sht);
+	return ata_pci_init_one(pdev, ppi, &pacpi_sht, NULL);
 }
 
 static const struct pci_device_id pacpi_pci_tbl[] = {
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index d29578b..534740d 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -512,7 +512,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	        	ppi[0] = &info_20_udma;
 		pci_dev_put(isa_bridge);
 	}
-	return ata_pci_init_one(pdev, ppi, &ali_sht);
+	return ata_pci_init_one(pdev, ppi, &ali_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 9ce6cd9..a7013c9 100644
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
+	void *hpriv = NULL;
 	u8 fifo;
 	int rc;
 
@@ -512,7 +512,7 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/*
 	 * Okay, type is determined now.  Apply type-specific workarounds.
 	 */
-	pi = info[type];
+	ppi[0] = &info[type];
 
 	if (type < 3)
 		ata_pci_clear_simplex(pdev);
@@ -531,11 +531,11 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		u32 udma;
 
 		pci_read_config_dword(pdev, 0x60, &udma);
-		pi.private_data = (void *)(unsigned long)udma;
+		hpriv = (void *)(unsigned long)udma;
 	}
 
 	/* And fire it up */
-	return ata_pci_init_one(pdev, ppi, &amd_sht);
+	return ata_pci_init_one(pdev, ppi, &amd_sht, hpriv);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 698a53c..ebd15ca 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -430,7 +430,7 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 
 	BUG_ON(ppi[0] == NULL);
 
-	return ata_pci_init_one(pdev, ppi, &artop_sht);
+	return ata_pci_init_one(pdev, ppi, &artop_sht, NULL);
 }
 
 static const struct pci_device_id artop_pci_tbl[] = {
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index a098f69..ac6c79d 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -246,7 +246,7 @@ static int atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(dev, ppi, &atiixp_sht);
+	return ata_pci_init_one(dev, ppi, &atiixp_sht, NULL);
 }
 
 static const struct pci_device_id atiixp[] = {
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index efd2bb5..27219b0 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -224,7 +224,7 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cmd640_hardware_init(pdev);
 
-	return ata_pci_init_one(pdev, ppi, &cmd640_sht);
+	return ata_pci_init_one(pdev, ppi, &cmd640_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index bfd72ef..f0e5666 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -373,7 +373,7 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
 #endif
 
-	return ata_pci_init_one(pdev, ppi, &cmd64x_sht);
+	return ata_pci_init_one(pdev, ppi, &cmd64x_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index c632ce4..ac3ad55 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -325,7 +325,7 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ppi[1] = &info_palmax_secondary;
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(pdev, ppi, &cs5530_sht);
+	return ata_pci_init_one(pdev, ppi, &cs5530_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index d78cf95..5c0762e 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -199,7 +199,7 @@ static int cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	rdmsr(ATAC_CH0D1_PIO, timings, dummy);
 	if (CS5535_BAD_PIO(timings))
 		wrmsr(ATAC_CH0D1_PIO, 0xF7F4F7F4UL, 0);
-	return ata_pci_init_one(dev, ppi, &cs5535_sht);
+	return ata_pci_init_one(dev, ppi, &cs5535_sht, NULL);
 }
 
 static const struct pci_device_id cs5535[] = {
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 12a1f68..50f798c 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -261,7 +261,7 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	return ata_pci_init_one(dev, ppi, &cs5536_sht);
+	return ata_pci_init_one(dev, ppi, &cs5536_sht, NULL);
 }
 
 static const struct pci_device_id cs5536[] = {
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index cbd6670..ae14969 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -136,7 +136,7 @@ static int cy82c693_init_one(struct pci_dev *pdev, const struct pci_device_id *i
 	if (PCI_FUNC(pdev->devfn) != 1)
 		return -ENODEV;
 
-	return ata_pci_init_one(pdev, ppi, &cy82c693_sht);
+	return ata_pci_init_one(pdev, ppi, &cy82c693_sht, NULL);
 }
 
 static const struct pci_device_id cy82c693[] = {
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 0260eda..2f5b484 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -275,7 +275,7 @@ static int efar_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &efar_sht);
+	return ata_pci_init_one(pdev, ppi, &efar_sht, NULL);
 }
 
 static const struct pci_device_id efar_pci_tbl[] = {
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 512cba5..7dc609a 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -356,9 +356,9 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA4,
 		.port_ops = &hpt366_port_ops
 	};
-	struct ata_port_info info = info_hpt366;
-	const struct ata_port_info *ppi[] = { &info, NULL };
+	const struct ata_port_info *ppi[] = { &info_hpt366, NULL };
 
+	void *hpriv = NULL;
 	u32 class_rev;
 	u32 reg1;
 	int rc;
@@ -383,17 +383,17 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	/* info_hpt366 is safe against re-entry so we can scribble on it */
 	switch((reg1 & 0x700) >> 8) {
 		case 5:
-			info.private_data = &hpt366_40;
+			hpriv = &hpt366_40;
 			break;
 		case 9:
-			info.private_data = &hpt366_25;
+			hpriv = &hpt366_25;
 			break;
 		default:
-			info.private_data = &hpt366_33;
+			hpriv = &hpt366_33;
 			break;
 	}
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt36x_sht);
+	return ata_pci_init_one(dev, ppi, &hpt36x_sht, hpriv);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 97fc5dc..591726a 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -831,10 +831,8 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 
 	static const int MHz[4] = { 33, 40, 50, 66 };
-	const struct ata_port_info *port;
 	void *private_data = NULL;
-	struct ata_port_info port_info;
-	const struct ata_port_info *ppi[] = { &port_info, NULL };
+	const struct ata_port_info *ppi[] = { NULL, NULL };
 
 	u8 irqmask;
 	u32 class_rev;
@@ -866,17 +864,17 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 		switch(class_rev) {
 			case 3:
-				port = &info_hpt370;
+				ppi[0] = &info_hpt370;
 				chip_table = &hpt370;
 				prefer_dpll = 0;
 				break;
 			case 4:
-				port = &info_hpt370a;
+				ppi[0] = &info_hpt370a;
 				chip_table = &hpt370a;
 				prefer_dpll = 0;
 				break;
 			case 5:
-				port = &info_hpt372;
+				ppi[0] = &info_hpt372;
 				chip_table = &hpt372;
 				break;
 			default:
@@ -889,21 +887,21 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				/* 372N if rev >= 2*/
 				if (class_rev >= 2)
 					return -ENODEV;
-				port = &info_hpt372;
+				ppi[0] = &info_hpt372;
 				chip_table = &hpt372a;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT302:
 				/* 302N if rev > 1 */
 				if (class_rev > 1)
 					return -ENODEV;
-				port = &info_hpt372;
+				ppi[0] = &info_hpt372;
 				/* Check this */
 				chip_table = &hpt302;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT371:
 				if (class_rev > 1)
 					return -ENODEV;
-				port = &info_hpt372;
+				ppi[0] = &info_hpt372;
 				chip_table = &hpt371;
 				/* Single channel device, master is not present
 				   but the BIOS (or us for non x86) must mark it
@@ -914,7 +912,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				break;
 			case PCI_DEVICE_ID_TTI_HPT374:
 				chip_table = &hpt374;
-				port = &info_hpt374;
+				ppi[0] = &info_hpt374;
 				break;
 			default:
 				printk(KERN_ERR "pata_hpt37x: PCI table is bogus please report (%d).\n", dev->device);
@@ -993,7 +991,7 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		int dpll, adjust;
 
 		/* Compute DPLL */
-		dpll = (port->udma_mask & 0xC0) ? 3 : 2;
+		dpll = (ppi[0]->udma_mask & 0xC0) ? 3 : 2;
 
 		f_low = (MHz[clock_slot] * 48) / MHz[dpll];
 		f_high = f_low + 2;
@@ -1033,19 +1031,16 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		 *	about lack of UDMA133 support on lower clocks
  		 */
 
-		if (clock_slot < 2 && port == &info_hpt370)
-			port = &info_hpt370_33;
-		if (clock_slot < 2 && port == &info_hpt370a)
-			port = &info_hpt370a_33;
+		if (clock_slot < 2 && ppi[0] == &info_hpt370)
+			ppi[0] = &info_hpt370_33;
+		if (clock_slot < 2 && ppi[0] == &info_hpt370a)
+			ppi[0] = &info_hpt370a_33;
 		printk(KERN_INFO "pata_hpt37x: %s using %dMHz bus clock.\n",
 		       chip_table->name, MHz[clock_slot]);
 	}
 
 	/* Now kick off ATA set up */
-	port_info = *port;
-	port_info.private_data = private_data;
-
-	return ata_pci_init_one(dev, ppi, &hpt37x_sht);
+	return ata_pci_init_one(dev, ppi, &hpt37x_sht, private_data);
 }
 
 static const struct pci_device_id hpt37x[] = {
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 2c178c3..c774be9 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -458,8 +458,7 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA6,
 		.port_ops = &hpt3x2n_port_ops
 	};
-	struct ata_port_info port = info;
-	const struct ata_port_info *ppi[] = { &port, NULL };
+	const struct ata_port_info *ppi[] = { &info, NULL };
 
 	u8 irqmask;
 	u32 class_rev;
@@ -468,6 +467,7 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	unsigned int f_low, f_high;
 	int adjust;
 	unsigned long iobase = pci_resource_start(dev, 4);
+	void *hpriv = NULL;
 	int rc;
 
 	rc = pcim_enable_device(dev);
@@ -554,9 +554,8 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	       pci_mhz);
 	/* Set our private data up. We only need a few flags so we use
 	   it directly */
-	port.private_data = NULL;
 	if (pci_mhz > 60) {
-		port.private_data = (void *)PCI66;
+		hpriv = (void *)PCI66;
 		/*
 		 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
 		 * the MISC. register to stretch the UltraDMA Tss timing.
@@ -567,7 +566,7 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	/* Now kick off ATA set up */
-	return ata_pci_init_one(dev, ppi, &hpt3x2n_sht);
+	return ata_pci_init_one(dev, ppi, &hpt3x2n_sht, hpriv);
 }
 
 static const struct pci_device_id hpt3x2n[] = {
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 291a0d6..d23a46b 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -287,7 +287,7 @@ static int it8213_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &it8213_sht);
+	return ata_pci_init_one(pdev, ppi, &it8213_sht, NULL);
 }
 
 static const struct pci_device_id it8213_pci_tbl[] = {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 1a8bec8..49dd51d 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -722,7 +722,7 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		ppi[0] = &info_smart;
 
-	return ata_pci_init_one(pdev, ppi, &it821x_sht);
+	return ata_pci_init_one(pdev, ppi, &it821x_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index d76620e..530eef9 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -157,7 +157,7 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
-	return ata_pci_init_one(pdev, ppi, &jmicron_sht);
+	return ata_pci_init_one(pdev, ppi, &jmicron_sht, NULL);
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 4f3b4dc..9a51a97 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -142,7 +142,7 @@ static int marvell_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 	if (pdev->device == 0x6101)
 		ppi[1] = &ata_dummy_port_info;
 
-	return ata_pci_init_one(pdev, ppi, &marvell_sht);
+	return ata_pci_init_one(pdev, ppi, &marvell_sht, NULL);
 }
 
 static const struct pci_device_id marvell_pci_tbl[] = {
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index ae50a5e..3491828 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -71,7 +71,7 @@ static int netcell_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	ata_pci_clear_simplex(pdev);
 
 	/* And let the library code do the work */
-	return ata_pci_init_one(pdev, port_info, &netcell_sht);
+	return ata_pci_init_one(pdev, port_info, &netcell_sht, NULL);
 }
 
 static const struct pci_device_id netcell_pci_tbl[] = {
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 1bdca8f..5a043e4 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -163,7 +163,7 @@ static int ns87410_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		.port_ops = &ns87410_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	return ata_pci_init_one(dev, ppi, &ns87410_sht);
+	return ata_pci_init_one(dev, ppi, &ns87410_sht, NULL);
 }
 
 static const struct pci_device_id ns87410[] = {
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 4250894..cdd79d6 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -375,7 +375,7 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	pci_write_config_byte(pdev, 0x55, 0xEE);
 	/* Select PIO0 8bit clocking */
 	pci_write_config_byte(pdev, 0x54, 0xB7);
-	return ata_pci_init_one(pdev, ppi, &ns87415_sht);
+	return ata_pci_init_one(pdev, ppi, &ns87415_sht, NULL);
 }
 
 static const struct pci_device_id ns87415_pci_tbl[] = {
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 9e3afad..7001b75 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -263,7 +263,7 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &oldpiix_sht);
+	return ata_pci_init_one(pdev, ppi, &oldpiix_sht, NULL);
 }
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 8601d9c..5a5f20e 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -188,7 +188,7 @@ static int opti_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(dev, ppi, &opti_sht);
+	return ata_pci_init_one(dev, ppi, &opti_sht, NULL);
 }
 
 static const struct pci_device_id opti[] = {
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index c376f9e..ba2819f 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -445,7 +445,7 @@ static int optidma_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (optiplus_with_udma(dev))
 		ppi[0] = &info_82c700_udma;
 
-	return ata_pci_init_one(dev, ppi, &optidma_sht);
+	return ata_pci_init_one(dev, ppi, &optidma_sht, NULL);
 }
 
 static const struct pci_device_id optidma[] = {
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 5545fba..8214100 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -324,7 +324,7 @@ static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id
 				return -ENODEV;
 		}
 	}
-	return ata_pci_init_one(dev, ppi, &pdc202xx_sht);
+	return ata_pci_init_one(dev, ppi, &pdc202xx_sht, NULL);
 }
 
 static const struct pci_device_id pdc202xx[] = {
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 145d5ba..9ab84fc 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -228,7 +228,7 @@ static int radisys_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(pdev, ppi, &radisys_sht);
+	return ata_pci_init_one(pdev, ppi, &radisys_sht, NULL);
 }
 
 static const struct pci_device_id radisys_pci_tbl[] = {
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 04be6ae..462b72a 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -99,7 +99,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
 	if (rz1000_fifo_disable(pdev) == 0)
-		return ata_pci_init_one(pdev, ppi, &rz1000_sht);
+		return ata_pci_init_one(pdev, ppi, &rz1000_sht, NULL);
 
 	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
 	/* Not safe to use so skip */
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 38c7fb0..42efacf 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -213,7 +213,7 @@ static int sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	/* Can't enable port 2 yet, see top comments */
 	const struct ata_port_info *ppi[] = { &info, &ata_dummy_port_info };
 
-	return ata_pci_init_one(dev, ppi, &sc1200_sht);
+	return ata_pci_init_one(dev, ppi, &sc1200_sht, NULL);
 }
 
 static const struct pci_device_id sc1200[] = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 78b1a46..cb5eab0 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -461,7 +461,7 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 	if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
 		ata_pci_clear_simplex(pdev);
 
-	return ata_pci_init_one(pdev, ppi, &serverworks_sht);
+	return ata_pci_init_one(pdev, ppi, &serverworks_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 1b39646..2fa612b 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -358,7 +358,7 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 				 &sil680_sht);
 
 use_ioports:
-	return ata_pci_init_one(pdev, ppi, &sil680_sht);
+	return ata_pci_init_one(pdev, ppi, &sil680_sht, NULL);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 32be13b..28abfc2 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -690,8 +690,7 @@ static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info port;
-	const struct ata_port_info *ppi[] = { &port, NULL };
+	const struct ata_port_info *ppi[] = { NULL, NULL };
 	struct pci_dev *host = NULL;
 	struct sis_chipset *chipset = NULL;
 	struct sis_chipset *sets;
@@ -831,12 +830,11 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (chipset == NULL)
 		return -ENODEV;
 
-	port = *chipset->info;
-	port.private_data = chipset;
+	ppi[0] = chipset->info;
 
 	sis_fixup(pdev, chipset);
 
-	return ata_pci_init_one(pdev, ppi, &sis_sht);
+	return ata_pci_init_one(pdev, ppi, &sis_sht, chipset);
 }
 
 static const struct pci_device_id sis_pci_tbl[] = {
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 2d14b25..1d97f92 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -323,7 +323,7 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
 	pci_write_config_dword(dev, 0x40, val);
 
-	return ata_pci_init_one(dev, ppi, &sl82c105_sht);
+	return ata_pci_init_one(dev, ppi, &sl82c105_sht, NULL);
 }
 
 static const struct pci_device_id sl82c105[] = {
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 86dc66c..f07b0e5 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -206,7 +206,7 @@ static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
-	return ata_pci_init_one(dev, ppi, &triflex_sht);
+	return ata_pci_init_one(dev, ppi, &triflex_sht, NULL);
 }
 
 static const struct pci_device_id triflex[] = {
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index affb665..29612c9 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -438,8 +438,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.udma_mask = ATA_UDMA6,	/* FIXME: should check north bridge */
 		.port_ops = &via_port_ops
 	};
-	struct ata_port_info type;
-	const struct ata_port_info *ppi[] = { &type, NULL };
+	const struct ata_port_info *ppi[] = { NULL, NULL };
 	struct pci_dev *isa = NULL;
 	const struct via_isa_bridge *config;
 	static int printed_version;
@@ -487,25 +486,25 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	switch(config->flags & VIA_UDMA) {
 		case VIA_UDMA_NONE:
 			if (config->flags & VIA_NO_UNMASK)
-				type = via_mwdma_info_borked;
+				ppi[0] = &via_mwdma_info_borked;
 			else
-				type = via_mwdma_info;
+				ppi[0] = &via_mwdma_info;
 			break;
 		case VIA_UDMA_33:
-			type = via_udma33_info;
+			ppi[0] = &via_udma33_info;
 			break;
 		case VIA_UDMA_66:
-			type = via_udma66_info;
+			ppi[0] = &via_udma66_info;
 			/* The 66 MHz devices require we enable the clock */
 			pci_read_config_dword(pdev, 0x50, &timing);
 			timing |= 0x80008;
 			pci_write_config_dword(pdev, 0x50, timing);
 			break;
 		case VIA_UDMA_100:
-			type = via_udma100_info;
+			ppi[0] = &via_udma100_info;
 			break;
 		case VIA_UDMA_133:
-			type = via_udma133_info;
+			ppi[0] = &via_udma133_info;
 			break;
 		default:
 			WARN_ON(1);
@@ -520,9 +519,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	/* We have established the device type, now fire it up */
-	type.private_data = (void *)config;
-
-	return ata_pci_init_one(pdev, ppi, &via_sht);
+	return ata_pci_init_one(pdev, ppi, &via_sht, (void *)config);
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d9be0cd..b503a41 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1026,7 +1026,7 @@ struct pci_dev;
 
 extern int ata_pci_init_one(struct pci_dev *pdev,
 			    const struct ata_port_info * const * ppi,
-			    struct scsi_host_template *sht);
+			    struct scsi_host_template *sht, void *host_priv);
 extern void ata_pci_remove_one(struct pci_dev *pdev);
 #ifdef CONFIG_PM
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-- 
1.5.2.4

