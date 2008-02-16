From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 07/12] ide: init hwif->{io_ports,irq} explicitly in legacy VLB host drivers
Date: Sat, 16 Feb 2008 17:39:39 +0100
Message-ID: <20080216163939.10174.99395.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14693 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758529AbYBPQZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:25:06 -0500
Received: by fg-out-1718.google.com with SMTP id e21so842257fga.17
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:25:06 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Do explicit port setup in legacy VLB host drivers instead of depending
on init_ide_data().  This way hwif->io_ports[] and hwif->irq are always
correctly set regardless of CONFIG_PCI / CONFIG_BLK_DEV_IDEPCI.

[ No need to care about "idex=noprobe" parameter for these drivers
  as they need to be explicitly enabled with "probe" parameter. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ali14xx.c     |   12 ++++++++++++
 drivers/ide/legacy/dtc2278.c     |   12 ++++++++++++
 drivers/ide/legacy/ht6560b.c     |   12 ++++++++++++
 drivers/ide/legacy/ide-4drives.c |   10 +++++++---
 drivers/ide/legacy/qd65xx.c      |   19 +++++++++++++++++--
 drivers/ide/legacy/umc8672.c     |   12 ++++++++++++
 6 files changed, 72 insertions(+), 5 deletions(-)

Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -200,6 +200,7 @@ static const struct ide_port_info ali14x
 static int __init ali14xx_probe(void)
 {
 	static u8 idx[4] = { 0, 1, 0xff, 0xff };
+	hw_regs_t hw[2];
 
 	printk(KERN_DEBUG "ali14xx: base=0x%03x, regOn=0x%02x.\n",
 			  basePort, regOn);
@@ -210,6 +211,17 @@ static int __init ali14xx_probe(void)
 		return 1;
 	}
 
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
+	ide_init_port_hw(&ide_hwifs[0], &hw[0]);
+	ide_init_port_hw(&ide_hwifs[1], &hw[1]);
+
 	ide_hwifs[0].set_pio_mode = &ali14xx_set_pio_mode;
 	ide_hwifs[1].set_pio_mode = &ali14xx_set_pio_mode;
 
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -103,6 +103,7 @@ static int __init dtc2278_probe(void)
 	unsigned long flags;
 	ide_hwif_t *hwif, *mate;
 	static u8 idx[4] = { 0, 1, 0xff, 0xff };
+	hw_regs_t hw[2];
 
 	hwif = &ide_hwifs[0];
 	mate = &ide_hwifs[1];
@@ -128,6 +129,17 @@ static int __init dtc2278_probe(void)
 #endif
 	local_irq_restore(flags);
 
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
+	ide_init_port_hw(hwif, &hw[0]);
+	ide_init_port_hw(mate, &hw[1]);
+
 	hwif->set_pio_mode = &dtc2278_set_pio_mode;
 
 	ide_device_add(idx, &dtc2278_port_info);
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -331,6 +331,7 @@ static int __init ht6560b_init(void)
 {
 	ide_hwif_t *hwif, *mate;
 	static u8 idx[4] = { 0, 1, 0xff, 0xff };
+	hw_regs_t hw[2];
 
 	if (probe_ht6560b == 0)
 		return -ENODEV;
@@ -349,6 +350,17 @@ static int __init ht6560b_init(void)
 		goto release_region;
 	}
 
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
+	ide_init_port_hw(hwif, &hw[0]);
+	ide_init_port_hw(mate, &hw[1]);
+
 	hwif->selectproc = &ht6560b_selectproc;
 	hwif->set_pio_mode = &ht6560b_set_pio_mode;
 
Index: b/drivers/ide/legacy/ide-4drives.c
===================================================================
--- a/drivers/ide/legacy/ide-4drives.c
+++ b/drivers/ide/legacy/ide-4drives.c
@@ -13,6 +13,7 @@ static int __init ide_4drives_init(void)
 {
 	ide_hwif_t *hwif, *mate;
 	u8 idx[4] = { 0, 1, 0xff, 0xff };
+	hw_regs_t hw;
 
 	if (probe_4drives == 0)
 		return -ENODEV;
@@ -20,11 +21,14 @@ static int __init ide_4drives_init(void)
 	hwif = &ide_hwifs[0];
 	mate = &ide_hwifs[1];
 
-	memcpy(mate->io_ports, hwif->io_ports, sizeof(hwif->io_ports));
+	memset(&hw, 0, sizeof(hw));
 
-	mate->irq = hwif->irq;
+	ide_std_init_ports(&hw, 0x1f0, 0x3f6);
+	hw.irq = 14;
+	hw.chipset = ide_4drives;
 
-	mate->chipset = hwif->chipset = ide_4drives;
+	ide_init_port_hw(hwif, &hw);
+	ide_init_port_hw(mate, &hw);
 
 	mate->drives[0].select.all ^= 0x20;
 	mate->drives[1].select.all ^= 0x20;
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -389,9 +389,9 @@ static const struct ide_port_info qd65xx
 static int __init qd_probe(int base)
 {
 	ide_hwif_t *hwif;
+	u8 config, unit;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-	u8 config;
-	u8 unit;
+	hw_regs_t hw[2];
 
 	config = inb(QD_CONFIG_PORT);
 
@@ -400,6 +400,14 @@ static int __init qd_probe(int base)
 
 	unit = ! (config & QD_CONFIG_IDE_BASEPORT);
 
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
 	if ((config & 0xf0) == QD_CONFIG_QD6500) {
 
 		if (qd_testreg(base)) return 1;		/* bad register */
@@ -416,6 +424,8 @@ static int __init qd_probe(int base)
 			return 1;
 		}
 
+		ide_init_port_hw(hwif, &hw[unit]);
+
 		qd_setup(hwif, base, config);
 
 		hwif->port_init_devs = qd6500_port_init_devs;
@@ -451,6 +461,8 @@ static int __init qd_probe(int base)
 			printk(KERN_INFO "%s: qd6580: single IDE board\n",
 					 hwif->name);
 
+			ide_init_port_hw(hwif, &hw[unit]);
+
 			qd_setup(hwif, base, config | (control << 8));
 
 			hwif->port_init_devs = qd6580_port_init_devs;
@@ -472,6 +484,9 @@ static int __init qd_probe(int base)
 			printk(KERN_INFO "%s&%s: qd6580: dual IDE board\n",
 					hwif->name, mate->name);
 
+			ide_init_port_hw(hwif, &hw[0]);
+			ide_init_port_hw(mate, &hw[1]);
+
 			qd_setup(hwif, base, config | (control << 8));
 
 			hwif->port_init_devs = qd6580_port_init_devs;
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -130,6 +130,7 @@ static int __init umc8672_probe(void)
 {
 	unsigned long flags;
 	static u8 idx[4] = { 0, 1, 0xff, 0xff };
+	hw_regs_t hw[2];
 
 	if (!request_region(0x108, 2, "umc8672")) {
 		printk(KERN_ERR "umc8672: ports 0x108-0x109 already in use.\n");
@@ -148,6 +149,17 @@ static int __init umc8672_probe(void)
 	umc_set_speeds (current_speeds);
 	local_irq_restore(flags);
 
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
+	ide_init_port_hw(&ide_hwifs[0], &hw[0]);
+	ide_init_port_hw(&ide_hwifs[1], &hw[1]);
+
 	ide_hwifs[0].set_pio_mode = &umc_set_pio_mode;
 	ide_hwifs[1].set_pio_mode = &umc_set_pio_mode;
 
