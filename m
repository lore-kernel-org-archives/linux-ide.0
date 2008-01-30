From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/9] libata: PCI device should be powered up before being accessed
Date: Wed, 30 Jan 2008 18:28:55 +0900
Message-ID: <12016853434040-git-send-email-htejun@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:40764 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbYA3J3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 04:29:13 -0500
Received: by py-out-1112.google.com with SMTP id u52so269935pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 01:29:12 -0800 (PST)
In-Reply-To: <12016853433196-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@to
Cc: Tejun Heo <htejun@gmail.com>

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

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 7e68edf..5ef6594 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -597,6 +597,11 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -632,8 +637,15 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 761a666..567fe6b 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -662,10 +662,15 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -709,6 +714,13 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -721,7 +733,9 @@ static int amd_reinit_one(struct pci_dev *pdev)
 		    pdev->device == PCI_DEVICE_ID_AMD_COBRA_7401)
 		    	ata_pci_clear_simplex(pdev);
 	}
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index d421831..2f81480 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -446,11 +446,16 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
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
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index 43d198f..0ef1d1d 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -254,20 +254,31 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -281,8 +292,8 @@ static struct pci_driver cmd640_pci_driver = {
 	.remove		= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
-#endif
 	.resume		= cmd640_reinit_one,
+#endif
 };
 
 static int __init cmd640_init(void)
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 7acbbd9..1c9a8d9 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -435,6 +435,11 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -470,7 +475,14 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -479,7 +491,8 @@ static int cmd64x_reinit_one(struct pci_dev *pdev)
 #ifdef CONFIG_PPC
 	pci_write_config_byte(pdev, UDIDETCR0, 0xF0);
 #endif
-	return ata_pci_device_resume(pdev);
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index d4590f5..972ed9f 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -203,6 +203,10 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 	struct ata_ioports *ioaddr;
 	int i, rc;
 
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
 	/* IDE port enable bits */
 	pci_read_config_byte(pdev, 0x60, &pcicfg);
 
@@ -310,11 +314,20 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 
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
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index e1818fd..f876aed 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -349,6 +349,11 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -364,10 +369,19 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 0713872..6f63b73 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -402,6 +402,11 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	u32 class_rev;
 	u32 reg1;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
@@ -435,8 +440,15 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
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
 
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 68eb349..7a69f36 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -966,6 +966,11 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	const struct hpt_chip *chip_table;
 	int clock_slot;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xFF;
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 9f1c084..3a517cb 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -505,6 +505,11 @@ static int hpt3x2n_init_one(struct pci_dev *dev, const struct pci_device_id *id)
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
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 109ddd4..3181e2c 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -759,6 +759,11 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	const struct ata_port_info *ppi[] = { NULL, NULL };
 	static char *mode[2] = { "pass through", "smart" };
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
 
 	/* Force the card into bypass mode if so requested */
 	if (it8212_noraid) {
@@ -780,10 +785,17 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 25c922a..0e4a08e 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -100,11 +100,16 @@ static int netcell_init_one (struct pci_dev *pdev, const struct pci_device_id *e
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
 
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index d0e2e50..93eb958 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -410,6 +410,7 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 		.port_ops	= &ns87415_pata_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	int rc;
 #if defined(CONFIG_SUPERIO)
 	static const struct ata_port_info info87560 = {
 		.sht		= &ns87415_sht,
@@ -425,6 +426,11 @@ static int ns87415_init_one (struct pci_dev *pdev, const struct pci_device_id *e
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
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index f9b485a..be8c421 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -497,10 +497,15 @@ static int optidma_init_one(struct pci_dev *dev, const struct pci_device_id *id)
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
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 9c523fb..0b1e882 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -498,6 +498,11 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
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
@@ -535,11 +540,17 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
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
@@ -554,7 +565,9 @@ static int serverworks_reinit_one(struct pci_dev *pdev)
 			serverworks_fixup_ht1000(pdev);
 			break;
 	}
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 503245a..ecdaebe 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -342,6 +342,10 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
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
 
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 87546d9..ff98050 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -862,6 +862,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct pci_dev *host = NULL;
 	struct sis_chipset *chipset = NULL;
 	struct sis_chipset *sets;
+	int rc;
 
 	static struct sis_chipset sis_chipsets[] = {
 
@@ -914,8 +915,11 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
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
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 1388cef..51831ac 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -315,6 +315,11 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 					       &ata_dummy_port_info };
 	u32 val;
 	int rev;
+	int rc;
+
+	rc = pcim_enable_device(dev);
+	if (rc)
+		return rc;
 
 	rev = sl82c105_bridge_revision(dev);
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 39627ab..47ec47b 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -520,10 +520,15 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -611,6 +616,11 @@ static int via_reinit_one(struct pci_dev *pdev)
 	u32 timing;
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	const struct via_isa_bridge *config = host->private_data;
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
 
 	via_config_fifo(pdev, config->flags);
 
@@ -626,7 +636,9 @@ static int via_reinit_one(struct pci_dev *pdev)
 		timing &= ~0x80008;
 		pci_write_config_dword(pdev, 0x50, timing);
 	}
-	return ata_pci_device_resume(pdev);
+
+	ata_host_resume(host);
+	return 0;
 }
 #endif
 
-- 
1.5.2.4

