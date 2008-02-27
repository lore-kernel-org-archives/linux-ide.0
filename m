From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] ide: add ide_legacy_device_add() helper
Date: Wed, 27 Feb 2008 23:20:34 +0100
Message-ID: <200802272320.34982.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:48922 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760783AbYB0WIa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 17:08:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so568706ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 14:08:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add ide_legacy_device_add() helper for use by legacy VLB host drivers
(+ convert them to use it).

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c      |   32 ++++++++++++++++++++++++++++++++
 drivers/ide/legacy/ali14xx.c |   28 +---------------------------
 drivers/ide/legacy/dtc2278.c |   27 +--------------------------
 drivers/ide/legacy/ht6560b.c |   28 +---------------------------
 drivers/ide/legacy/umc8672.c |   27 +--------------------------
 include/linux/ide.h          |    1 +
 6 files changed, 37 insertions(+), 106 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1629,3 +1629,35 @@ void ide_port_scan(ide_hwif_t *hwif)
 	ide_proc_port_register_devices(hwif);
 }
 EXPORT_SYMBOL_GPL(ide_port_scan);
+
+int ide_legacy_device_add(const struct ide_port_info *d)
+{
+	ide_hwif_t *hwif, *mate;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	hw_regs_t hw[2];
+
+	memset(&hw, 0, sizeof(hw));
+
+	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
+	hw[0].irq = 14;
+
+	ide_std_init_ports(&hw[1], 0x170, 0x376);
+	hw[1].irq = 15;
+
+	hwif = ide_find_port();
+	if (hwif) {
+		ide_init_port_hw(hwif, &hw[0]);
+		idx[0] = hwif->index;
+	}
+
+	mate = ide_find_port();
+	if (mate) {
+		ide_init_port_hw(mate, &hw[1]);
+		idx[1] = mate->index;
+	}
+
+	ide_device_add(idx, d);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ide_legacy_device_add);
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -205,10 +205,6 @@ static const struct ide_port_info ali14x
 
 static int __init ali14xx_probe(void)
 {
-	ide_hwif_t *hwif, *mate;
-	static u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-	hw_regs_t hw[2];
-
 	printk(KERN_DEBUG "ali14xx: base=0x%03x, regOn=0x%02x.\n",
 			  basePort, regOn);
 
@@ -218,29 +214,7 @@ static int __init ali14xx_probe(void)
 		return 1;
 	}
 
-	memset(&hw, 0, sizeof(hw));
-
-	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
-	hw[0].irq = 14;
-
-	ide_std_init_ports(&hw[1], 0x170, 0x376);
-	hw[1].irq = 15;
-
-	hwif = ide_find_port();
-	if (hwif) {
-		ide_init_port_hw(hwif, &hw[0]);
-		idx[0] = hwif->index;
-	}
-
-	mate = ide_find_port();
-	if (mate) {
-		ide_init_port_hw(mate, &hw[1]);
-		idx[1] = mate->index;
-	}
-
-	ide_device_add(idx, &ali14xx_port_info);
-
-	return 0;
+	return ide_legacy_device_add(&ali14xx_port_info);
 }
 
 int probe_ali14xx;
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -106,9 +106,6 @@ static const struct ide_port_info dtc227
 static int __init dtc2278_probe(void)
 {
 	unsigned long flags;
-	ide_hwif_t *hwif, *mate;
-	static u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-	hw_regs_t hw[2];
 
 	local_irq_save(flags);
 	/*
@@ -128,29 +125,7 @@ static int __init dtc2278_probe(void)
 #endif
 	local_irq_restore(flags);
 
-	memset(&hw, 0, sizeof(hw));
-
-	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
-	hw[0].irq = 14;
-
-	ide_std_init_ports(&hw[1], 0x170, 0x376);
-	hw[1].irq = 15;
-
-	hwif = ide_find_port();
-	if (hwif) {
-		ide_init_port_hw(hwif, &hw[0]);
-		idx[0] = hwif->index;
-	}
-
-	mate = ide_find_port();
-	if (mate) {
-		ide_init_port_hw(mate, &hw[1]);
-		idx[1] = mate->index;
-	}
-
-	ide_device_add(idx, &dtc2278_port_info);
-
-	return 0;
+	return ide_legacy_device_add(&dtc2278_port_info);
 }
 
 int probe_dtc2278 = 0;
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -346,10 +346,6 @@ static const struct ide_port_info ht6560
 
 static int __init ht6560b_init(void)
 {
-	ide_hwif_t *hwif, *mate;
-	static u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-	hw_regs_t hw[2];
-
 	if (probe_ht6560b == 0)
 		return -ENODEV;
 
@@ -364,29 +360,7 @@ static int __init ht6560b_init(void)
 		goto release_region;
 	}
 
-	memset(&hw, 0, sizeof(hw));
-
-	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
-	hw[0].irq = 14;
-
-	ide_std_init_ports(&hw[1], 0x170, 0x376);
-	hw[1].irq = 15;
-
-	hwif = ide_find_port();
-	if (hwif) {
-		ide_init_port_hw(hwif, &hw[0]);
-		idx[0] = hwif->index;
-	}
-
-	mate = ide_find_port();
-	if (mate) {
-		ide_init_port_hw(mate, &hw[1]);
-		idx[1] = mate->index;
-	}
-
-	ide_device_add(idx, &ht6560b_port_info);
-
-	return 0;
+	return ide_legacy_device_add(&ht6560b_port_info);
 
 release_region:
 	release_region(HT_CONFIG_PORT, 1);
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -133,10 +133,7 @@ static const struct ide_port_info umc867
 
 static int __init umc8672_probe(void)
 {
-	ide_hwif_t *hwif, *mate;
 	unsigned long flags;
-	static u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
-	hw_regs_t hw[2];
 
 	if (!request_region(0x108, 2, "umc8672")) {
 		printk(KERN_ERR "umc8672: ports 0x108-0x109 already in use.\n");
@@ -155,29 +152,7 @@ static int __init umc8672_probe(void)
 	umc_set_speeds(current_speeds);
 	local_irq_restore(flags);
 
-	memset(&hw, 0, sizeof(hw));
-
-	ide_std_init_ports(&hw[0], 0x1f0, 0x3f6);
-	hw[0].irq = 14;
-
-	ide_std_init_ports(&hw[1], 0x170, 0x376);
-	hw[1].irq = 15;
-
-	hwif = ide_find_port();
-	if (hwif) {
-		ide_init_port_hw(hwif, &hw[0]);
-		idx[0] = hwif->index;
-	}
-
-	mate = ide_find_port();
-	if (mate) {
-		ide_init_port_hw(mate, &hw[1]);
-		idx[1] = mate->index;
-	}
-
-	ide_device_add(idx, &umc8672_port_info);
-
-	return 0;
+	return ide_legacy_device_add(&umc8672_port_info);
 }
 
 int probe_umc8672;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1215,6 +1215,7 @@ void ide_undecoded_slave(ide_drive_t *);
 
 int ide_device_add_all(u8 *idx, const struct ide_port_info *);
 int ide_device_add(u8 idx[4], const struct ide_port_info *);
+int ide_legacy_device_add(const struct ide_port_info *);
 void ide_port_unregister_devices(ide_hwif_t *);
 void ide_port_scan(ide_hwif_t *);
 
