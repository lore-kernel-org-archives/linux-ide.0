From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/8] ide: make legacy IDE VLB modules check for the "probe" kernel params
Date: Wed, 14 Feb 2007 02:57:12 +0100
Message-ID: <20070214015712.4619.78705.sendpatchset@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:47958 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXBNBvc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Feb 2007 20:51:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so28283uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2007 17:51:31 -0800 (PST)
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[PATCH] ide: make legacy IDE VLB modules check for the "probe" kernel params

Legacy IDE VLB host drivers didn't check for "probe" options when compiled
as modules, which was obviously wrong as we don't want module to poke at
random I/O ports by simply loading it.  Fix it by adding "probe" module param
to legacy IDE VLB host drivers and obsolete old "ide0=dtc2278", "ide0=ht6560b",
"ide0=qd65xx", "ide0=ali14xx", "ide0=umc8672" IDE driver options.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 Documentation/ide.txt        |    5 -----
 drivers/ide/Kconfig          |   10 +++++-----
 drivers/ide/ide.c            |   20 ++++++++++----------
 drivers/ide/legacy/ali14xx.c |    9 +++++++++
 drivers/ide/legacy/dtc2278.c |   12 ++++++++++--
 drivers/ide/legacy/ht6560b.c |    8 ++++++++
 drivers/ide/legacy/qd65xx.c  |    8 ++++++++
 drivers/ide/legacy/umc8672.c |   15 ++++++++++++---
 8 files changed, 62 insertions(+), 25 deletions(-)

Index: b/Documentation/ide.txt
===================================================================
--- a/Documentation/ide.txt
+++ b/Documentation/ide.txt
@@ -294,13 +294,8 @@ The following are valid ONLY on ide0, wh
 to the first ATA interface found on the particular host, and the defaults for
 the base,ctl ports must not be altered.
 
- "ide0=dtc2278"		: probe/support DTC2278 interface
- "ide0=ht6560b"		: probe/support HT6560B interface
  "ide0=cmd640_vlb"	: *REQUIRED* for VLB cards with the CMD640 chip
 			  (not for PCI -- automatically detected)
- "ide0=qd65xx"		: probe/support qd65xx interface
- "ide0=ali14xx"		: probe/support ali14xx chipsets (ALI M1439/M1443/M1445)
- "ide0=umc8672"		: probe/support umc8672 chipsets
 
  "ide=doubler"		: probe/support IDE doublers on Amiga
 
Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1023,7 +1023,7 @@ config BLK_DEV_4DRIVES
 config BLK_DEV_ALI14XX
 	tristate "ALI M14xx support"
 	help
-	  This driver is enabled at runtime using the "ide0=ali14xx" kernel
+	  This driver is enabled at runtime using the "ali14xx.probe" kernel
 	  boot parameter.  It enables support for the secondary IDE interface
 	  of the ALI M1439/1443/1445/1487/1489 chipsets, and permits faster
 	  I/O speeds to be set as well.  See the files
@@ -1033,7 +1033,7 @@ config BLK_DEV_ALI14XX
 config BLK_DEV_DTC2278
 	tristate "DTC-2278 support"
 	help
-	  This driver is enabled at runtime using the "ide0=dtc2278" kernel
+	  This driver is enabled at runtime using the "dtc2278.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the DTC-2278 card, and permits faster I/O speeds to be set as
 	  well. See the <file:Documentation/ide.txt> and
@@ -1042,7 +1042,7 @@ config BLK_DEV_DTC2278
 config BLK_DEV_HT6560B
 	tristate "Holtek HT6560B support"
 	help
-	  This driver is enabled at runtime using the "ide0=ht6560b" kernel
+	  This driver is enabled at runtime using the "ht6560b.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the Holtek card, and permits faster I/O speeds to be set as well.
 	  See the <file:Documentation/ide.txt> and
@@ -1051,7 +1051,7 @@ config BLK_DEV_HT6560B
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
 	help
-	  This driver is enabled at runtime using the "ide0=qd65xx" kernel
+	  This driver is enabled at runtime using the "qd65xx.probe" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
 	  <file:Documentation/ide.txt> and <file:drivers/ide/legacy/qd65xx.c> for
 	  more info.
@@ -1059,7 +1059,7 @@ config BLK_DEV_QD65XX
 config BLK_DEV_UMC8672
 	tristate "UMC-8672 support"
 	help
-	  This driver is enabled at runtime using the "ide0=umc8672" kernel
+	  This driver is enabled at runtime using the "umc8672.probe" kernel
 	  boot parameter. It enables support for the secondary IDE interface
 	  of the UMC-8672, and permits faster I/O speeds to be set as well.
 	  See the files <file:Documentation/ide.txt> and
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1248,23 +1248,23 @@ static int __init match_parm (char *s, c
 }
 
 #ifdef CONFIG_BLK_DEV_ALI14XX
-static int __initdata probe_ali14xx;
+extern int probe_ali14xx;
 extern int ali14xx_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
-static int __initdata probe_umc8672;
+extern int probe_umc8672;
 extern int umc8672_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
-static int __initdata probe_dtc2278;
+extern int probe_dtc2278;
 extern int dtc2278_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_HT6560B
-static int __initdata probe_ht6560b;
+extern int probe_ht6560b;
 extern int ht6560b_init(void);
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
-static int __initdata probe_qd65xx;
+extern int probe_qd65xx;
 extern int qd65xx_init(void);
 #endif
 
@@ -1462,17 +1462,17 @@ static int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_ALI14XX
 			case -17: /* "ali14xx" */
 				probe_ali14xx = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_UMC8672
 			case -16: /* "umc8672" */
 				probe_umc8672 = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_DTC2278
 			case -15: /* "dtc2278" */
 				probe_dtc2278 = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
@@ -1485,12 +1485,12 @@ static int __init ide_setup(char *s)
 #ifdef CONFIG_BLK_DEV_HT6560B
 			case -13: /* "ht6560b" */
 				probe_ht6560b = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_QD65XX
 			case -12: /* "qd65xx" */
 				probe_qd65xx = 1;
-				goto done;
+				goto obsolete_option;
 #endif
 #ifdef CONFIG_BLK_DEV_4DRIVES
 			case -11: /* "four" drives on one set of ports */
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -231,9 +231,17 @@ static int __init ali14xx_probe(void)
 	return 0;
 }
 
+int probe_ali14xx = 0;
+
+module_param_named(probe, probe_ali14xx, bool, 0);
+MODULE_PARM_DESC(probe, "probe for ALI M14xx chipsets");
+
 /* Can be called directly from ide.c. */
 int __init ali14xx_init(void)
 {
+	if (probe_ali14xx == 0)
+		goto out;
+
 	/* auto-detect IDE controller port */
 	if (findPort()) {
 		if (ali14xx_probe())
@@ -241,6 +249,7 @@ int __init ali14xx_init(void)
 		return 0;
 	}
 	printk(KERN_ERR "ali14xx: not found.\n");
+out:
 	return -ENODEV;
 }
 
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -94,7 +94,7 @@ static void tune_dtc2278 (ide_drive_t *d
 	HWIF(drive)->drives[!drive->select.b.unit].io_32bit = 1;
 }
 
-static int __init probe_dtc2278(void)
+static int __init dtc2278_probe(void)
 {
 	unsigned long flags;
 	ide_hwif_t *hwif, *mate;
@@ -146,10 +146,18 @@ static int __init probe_dtc2278(void)
 	return 0;
 }
 
+int probe_dtc2278 = 0;
+
+module_param_named(probe, probe_dtc2278, bool, 0);
+MODULE_PARM_DESC(probe, "probe for DTC2278xx chipsets");
+
 /* Can be called directly from ide.c. */
 int __init dtc2278_init(void)
 {
-	if (probe_dtc2278()) {
+	if (probe_dtc2278 == 0)
+		return -ENODEV;
+
+	if (dtc2278_probe()) {
 		printk(KERN_ERR "dtc2278: ide interfaces already in use!\n");
 		return -EBUSY;
 	}
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -303,12 +303,20 @@ static void tune_ht6560b (ide_drive_t *d
 #endif
 }
 
+int probe_ht6560b = 0;
+
+module_param_named(probe, probe_ht6560b, bool, 0);
+MODULE_PARM_DESC(probe, "probe for HT6560B chipset");
+
 /* Can be called directly from ide.c. */
 int __init ht6560b_init(void)
 {
 	ide_hwif_t *hwif, *mate;
 	int t;
 
+	if (probe_ht6560b == 0)
+		return -ENODEV;
+
 	hwif = &ide_hwifs[0];
 	mate = &ide_hwifs[1];
 
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -491,9 +491,17 @@ static int __init qd_probe(int base)
 	return 1;
 }
 
+int probe_qd65xx = 0;
+
+module_param_named(probe, probe_qd65xx, bool, 0);
+MODULE_PARM_DESC(probe, "probe for QD65xx chipsets");
+
 /* Can be called directly from ide.c. */
 int __init qd65xx_init(void)
 {
+	if (probe_qd65xx == 0)
+		return -ENODEV;
+
 	if (qd_probe(0x30))
 		qd_probe(0xb0);
 	if (ide_hwifs[0].chipset != ide_qd65xx &&
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -166,12 +166,21 @@ static int __init umc8672_probe(void)
 	return 0;
 }
 
+int probe_umc8672 = 0;
+
+module_param_named(probe, probe_umc8672, bool, 0);
+MODULE_PARM_DESC(probe, "probe for UMC8672 chipset");
+
 /* Can be called directly from ide.c. */
 int __init umc8672_init(void)
 {
-	if (umc8672_probe())
-		return -ENODEV;
-	return 0;
+	if (probe_umc8672 == 0)
+		goto out;
+
+	if (umc8672_probe() == 0)
+		return 0;;
+out:
+	return -ENODEV;;
 }
 
 #ifdef MODULE
