From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata: PCI device should be powered
 up before being accessed
Date: Tue, 11 Mar 2008 20:07:06 +0900
Message-ID: <47D667DA.8050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:19822 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYCKLHN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 07:07:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2790801wah.23
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 04:07:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

PCI device should be powered up or powered up before its PCI regsiters
are accessed.  Although PCI configuration register access is allowed
in D3hot, PCI device is free to reset its status when transiting from
D3hot to D0 causing configuration data to change.

Many libata SFF drivers which use ata_pci_init_one() read and update
configuration registers before calling ata_pci_init_one() which
enables the PCI device.  Also, in resume paths, some drivers access
registers without resuming the PCI device.

This patch adds a call to pcim_enable_device() in init path if
register is accessed before calling ata_pci_init_one() and make resume
paths first resume PCI devices, access PCI configuration regiters then
resume ATA host.

While at it...

* cmd640 was strange in that it set ->resume even when CONFIG_PM is
  not.  This is by-product of minimal build fix.  Updated.

* In cs5530, Don't BUG() on reinit failure.  Just whine and fail
  resume.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_ali.c         |   14 +++++++++++++-
 drivers/ata/pata_amd.c         |   16 +++++++++++++++-
 drivers/ata/pata_artop.c       |    5 +++++
 drivers/ata/pata_cmd640.c      |   21 ++++++++++++++++-----
 drivers/ata/pata_cmd64x.c      |   15 ++++++++++++++-
 drivers/ata/pata_cs5520.c      |   15 ++++++++++++++-
 drivers/ata/pata_cs5530.c      |   18 ++++++++++++++++--
 drivers/ata/pata_hpt366.c      |   14 +++++++++++++-
 drivers/ata/pata_hpt37x.c      |    5 +++++
 drivers/ata/pata_hpt3x2n.c     |    5 +++++
 drivers/ata/pata_it821x.c      |   14 +++++++++++++-
 drivers/ata/pata_netcell.c     |    5 +++++
 drivers/ata/pata_ns87415.c     |    6 ++++++
 drivers/ata/pata_optidma.c     |    5 +++++
 drivers/ata/pata_serverworks.c |   19 ++++++++++++++++---
 drivers/ata/pata_sil680.c      |   13 +++++++++++--
 drivers/ata/pata_sis.c         |    6 +++++-
 drivers/ata/pata_sl82c105.c    |    5 +++++
 drivers/ata/pata_via.c         |   14 +++++++++++++-
 19 files changed, 195 insertions(+), 20 deletions(-)

Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -597,6 +597,11 @@ static int ali_init_one(struct pci_dev *
 	const struct ata_port_info *ppi[] = { NULL, NULL };
 	u8 tmp;
 	struct pci_dev *isa_bridge;
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	/*
 	 * The chipset revision selects the driver operations and
@@ -632,8 +637,15 @@ static int ali_init_one(struct pci_dev *
 #ifdef CONFIG_PM
 static int ali_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 	ali_init_chipset(pdev);
-	return ata_pci_device_resume(pdev);
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -659,10 +659,15 @@ static int amd_init_one(struct pci_dev *
 	static int printed_version;
 	int type = id->driver_data;
 	u8 fifo;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	pci_read_config_byte(pdev, 0x41, &fifo);
 
 	/* Check for AMD7409 without swdma errata and if found adjust type */
@@ -706,6 +711,13 @@ static int amd_init_one(struct pci_dev *
 #ifdef CONFIG_PM
 static int amd_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
 		u8 fifo;
 		pci_read_config_byte(pdev, 0x41, &fifo);
@@ -718,7 +730,9 @@ static int amd_reinit_one(struct pci_dev
 		    pdev->device == PCI_DEVICE_ID_AMD_COBRA_7401)
 		    	ata_pci_clear_simplex(pdev);
 	}
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
Index: work/drivers/ata/pata_artop.c
===================================================================
--- work.orig/drivers/ata/pata_artop.c
+++ work/drivers/ata/pata_artop.c
@@ -446,11 +446,16 @@ static int artop_init_one (struct pci_de
 		.port_ops	= &artop6260_ops,
 	};
 	const struct ata_port_info *ppi[] = { NULL, NULL };
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	if (id->driver_data == 0) {	/* 6210 variant */
 		ppi[0] = &info_6210;
 		ppi[1] = &ata_dummy_port_info;
Index: work/drivers/ata/pata_cmd640.c
===================================================================
--- work.orig/drivers/ata/pata_cmd640.c
+++ work/drivers/ata/pata_cmd640.c
@@ -254,20 +254,31 @@ static int cmd640_init_one(struct pci_de
 		.port_ops = &cmd640_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	cmd640_hardware_init(pdev);
+
 	return ata_pci_init_one(pdev, ppi);
 }
 
+#ifdef CONFIG_PM
 static int cmd640_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 	cmd640_hardware_init(pdev);
-#ifdef CONFIG_PM
-	return ata_pci_device_resume(pdev);
-#else
+	ata_host_resume(host);
 	return 0;
-#endif
 }
+#endif
 
 static const struct pci_device_id cmd640[] = {
 	{ PCI_VDEVICE(CMD, 0x640), 0 },
@@ -281,8 +292,8 @@ static struct pci_driver cmd640_pci_driv
 	.remove		= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
-#endif
 	.resume		= cmd640_reinit_one,
+#endif
 };
 
 static int __init cmd640_init(void)
Index: work/drivers/ata/pata_cmd64x.c
===================================================================
--- work.orig/drivers/ata/pata_cmd64x.c
+++ work/drivers/ata/pata_cmd64x.c
@@ -435,6 +435,11 @@ static int cmd64x_init_one(struct pci_de
 	};
 	const struct ata_port_info *ppi[] = { &cmd_info[id->driver_data], NULL };
 	u8 mrdmode;
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
@@ -470,7 +475,14 @@ static int cmd64x_init_one(struct pci_de
 #ifdef CONFIG_PM
 static int cmd64x_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	u8 mrdmode;
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 64);
 	pci_read_config_byte(pdev, MRDMODE, &mrdmode);
 	mrdmode &= ~ 0x30;	/* IRQ set up */
@@ -479,7 +491,8 @@ static int cmd64x_reinit_one(struct pci_
 #ifdef CONFIG_PPC
 	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
 #endif
-	return ata_pci_device_resume(pdev);
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
Index: work/drivers/ata/pata_cs5520.c
===================================================================
--- work.orig/drivers/ata/pata_cs5520.c
+++ work/drivers/ata/pata_cs5520.c
@@ -203,6 +203,10 @@ static int __devinit cs5520_init_one(str
 	struct ata_ioports *ioaddr;
 	int i, rc;
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	/* IDE port enable bits */
 	pci_read_config_byte(pdev, 0x60, &pcicfg);
 
@@ -310,11 +314,20 @@ static int __devinit cs5520_init_one(str
 
 static int cs5520_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	u8 pcicfg;
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
 	pci_read_config_byte(pdev, 0x60, &pcicfg);
 	if ((pcicfg & 0x40) == 0)
 		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 
 /**
Index: work/drivers/ata/pata_cs5530.c
===================================================================
--- work.orig/drivers/ata/pata_cs5530.c
+++ work/drivers/ata/pata_cs5530.c
@@ -349,6 +349,11 @@ static int cs5530_init_one(struct pci_de
 		.port_ops = &cs5530_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	/* Chip initialisation */
 	if (cs5530_init_chip())
@@ -364,10 +369,19 @@ static int cs5530_init_one(struct pci_de
 #ifdef CONFIG_PM
 static int cs5530_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
 	/* If we fail on resume we are doomed */
 	if (cs5530_init_chip())
-		BUG();
-	return ata_pci_device_resume(pdev);
+		return -EIO;
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif /* CONFIG_PM */
 
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -402,6 +402,11 @@ static int hpt36x_init_one(struct pci_de
 
 	u32 class_rev;
 	u32 reg1;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
@@ -435,8 +440,15 @@ static int hpt36x_init_one(struct pci_de
 #ifdef CONFIG_PM
 static int hpt36x_reinit_one(struct pci_dev *dev)
 {
+	struct ata_host *host = dev_get_drvdata(&dev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(dev);
+	if (rc)
+		return rc;
 	hpt36x_init_chipset(dev);
-	return ata_pci_device_resume(dev);
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
Index: work/drivers/ata/pata_hpt37x.c
===================================================================
--- work.orig/drivers/ata/pata_hpt37x.c
+++ work/drivers/ata/pata_hpt37x.c
@@ -966,6 +966,11 @@ static int hpt37x_init_one(struct pci_de
 
 	const struct hpt_chip *chip_table;
 	int clock_slot;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
Index: work/drivers/ata/pata_hpt3x2n.c
===================================================================
--- work.orig/drivers/ata/pata_hpt3x2n.c
+++ work/drivers/ata/pata_hpt3x2n.c
@@ -505,6 +505,11 @@ static int hpt3x2n_init_one(struct pci_d
 	unsigned int f_low, f_high;
 	int adjust;
 	unsigned long iobase = pci_resource_start(dev, 4);
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -759,6 +759,11 @@ static int it821x_init_one(struct pci_de
 
 	const struct ata_port_info *ppi[] = { NULL, NULL };
 	static char *mode[2] = { "pass through", "smart" };
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	/* Force the card into bypass mode if so requested */
 	if (it8212_noraid) {
@@ -780,10 +785,17 @@ static int it821x_init_one(struct pci_de
 #ifdef CONFIG_PM
 static int it821x_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 	/* Resume - turn raid back off if need be */
 	if (it8212_noraid)
 		it821x_disable_raid(pdev);
-	return ata_pci_device_resume(pdev);
+	ata_host_resume(host);
+	return rc;
 }
 #endif
 
Index: work/drivers/ata/pata_netcell.c
===================================================================
--- work.orig/drivers/ata/pata_netcell.c
+++ work/drivers/ata/pata_netcell.c
@@ -100,11 +100,16 @@ static int netcell_init_one (struct pci_
 		.port_ops	= &netcell_ops,
 	};
 	const struct ata_port_info *port_info[] = { &info, NULL };
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	/* Any chip specific setup/optimisation/messages here */
 	ata_pci_clear_simplex(pdev);
 
Index: work/drivers/ata/pata_ns87415.c
===================================================================
--- work.orig/drivers/ata/pata_ns87415.c
+++ work/drivers/ata/pata_ns87415.c
@@ -410,6 +410,7 @@ static int ns87415_init_one (struct pci_
 		.port_ops	= &ns87415_pata_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	int rc;
 #if defined(CONFIG_SUPERIO)
 	static const struct ata_port_info info87560 = {
 		.sht		= &ns87415_sht,
@@ -425,6 +426,11 @@ static int ns87415_init_one (struct pci_
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	/* Select 512 byte sectors */
 	pci_write_config_byte(pdev, 0x55, 0xEE);
 	/* Select PIO0 8bit clocking */
Index: work/drivers/ata/pata_optidma.c
===================================================================
--- work.orig/drivers/ata/pata_optidma.c
+++ work/drivers/ata/pata_optidma.c
@@ -497,10 +497,15 @@ static int optidma_init_one(struct pci_d
 	};
 	const struct ata_port_info *ppi[] = { &info_82c700, NULL };
 	static int printed_version;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &dev->dev, "version " DRV_VERSION "\n");
 
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
+
 	/* Fixed location chipset magic */
 	inw(0x1F1);
 	inw(0x1F1);
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -498,6 +498,11 @@ static int serverworks_init_one(struct p
 		}
 	};
 	const struct ata_port_info *ppi[] = { &info[id->driver_data], NULL };
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	/* Force master latency timer to 64 PCI clocks */
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
@@ -535,11 +540,17 @@ static int serverworks_init_one(struct p
 #ifdef CONFIG_PM
 static int serverworks_reinit_one(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
 	/* Force master latency timer to 64 PCI clocks */
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
 
-	switch (pdev->device)
-	{
+	switch (pdev->device) {
 		case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
 			serverworks_fixup_osb4(pdev);
 			break;
@@ -554,7 +565,9 @@ static int serverworks_reinit_one(struct
 			serverworks_fixup_ht1000(pdev);
 			break;
 	}
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
Index: work/drivers/ata/pata_sil680.c
===================================================================
--- work.orig/drivers/ata/pata_sil680.c
+++ work/drivers/ata/pata_sil680.c
@@ -342,6 +342,10 @@ static int __devinit sil680_init_one(str
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	switch (sil680_init_chip(pdev, &try_mmio)) {
 		case 0:
 			ppi[0] = &info_slow;
@@ -402,10 +406,15 @@ use_ioports:
 #ifdef CONFIG_PM
 static int sil680_reinit_one(struct pci_dev *pdev)
 {
-	int try_mmio;
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int try_mmio, rc;
 
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 	sil680_init_chip(pdev, &try_mmio);
-	return ata_pci_device_resume(pdev);
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
Index: work/drivers/ata/pata_sis.c
===================================================================
--- work.orig/drivers/ata/pata_sis.c
+++ work/drivers/ata/pata_sis.c
@@ -862,6 +862,7 @@ static int sis_init_one (struct pci_dev 
 	struct pci_dev *host = NULL;
 	struct sis_chipset *chipset = NULL;
 	struct sis_chipset *sets;
+	int rc;
 
 	static struct sis_chipset sis_chipsets[] = {
 
@@ -914,8 +915,11 @@ static int sis_init_one (struct pci_dev 
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	/* We have to find the bridge first */
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
+	/* We have to find the bridge first */
 	for (sets = &sis_chipsets[0]; sets->device; sets++) {
 		host = pci_get_device(PCI_VENDOR_ID_SI, sets->device, NULL);
 		if (host != NULL) {
Index: work/drivers/ata/pata_sl82c105.c
===================================================================
--- work.orig/drivers/ata/pata_sl82c105.c
+++ work/drivers/ata/pata_sl82c105.c
@@ -344,6 +344,11 @@ static int sl82c105_init_one(struct pci_
 					       NULL };
 	u32 val;
 	int rev;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	rev = sl82c105_bridge_revision(dev);
 
Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -524,10 +524,15 @@ static int via_init_one(struct pci_dev *
 	static int printed_version;
 	u8 enable;
 	u32 timing;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	/* To find out how the IDE will behave and what features we
 	   actually have to look at the bridge not the IDE controller */
 	for (config = via_isa_bridges; config->id; config++)
@@ -615,6 +620,11 @@ static int via_reinit_one(struct pci_dev
 	u32 timing;
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	const struct via_isa_bridge *config = host->private_data;
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	via_config_fifo(pdev, config->flags);
 
@@ -630,7 +640,9 @@ static int via_reinit_one(struct pci_dev
 		timing &= ~0x80008;
 		pci_write_config_dword(pdev, 0x50, timing);
 	}
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
