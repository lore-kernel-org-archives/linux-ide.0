From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/8] ide: make legacy IDE VLB modules check for the "probe" kernel params (v2)
Date: Wed, 14 Feb 2007 20:52:08 +0100
Message-ID: <200702142052.08683.bzolnier@gmail.com>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain> <200702141207.27483.bzolnier@gmail.com> <20070214111744.76553c43@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:51219 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbXBNTq2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 14:46:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so318371uga
        for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2007 11:46:24 -0800 (PST)
In-Reply-To: <20070214111744.76553c43@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


new replacement patch

[PATCH] ide: make legacy IDE VLB modules check for the "probe" kernel params

Legacy IDE VLB host drivers didn't check for "probe" options when compiled
as modules, which was obviously wrong as we don't want module to poke at
random I/O ports by simply loading it.  Fix it by adding "probe" module param
to legacy IDE VLB host drivers.

v2:
* don't obsolete old "ide0=dtc2278/ht6560b/qd65xx/ali14xx/umc8672"
  IDE driver options yet (per Alan Cox's request) and enhance documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 Documentation/ide.txt        |   14 +++++++++-----
 drivers/ide/Kconfig          |   10 +++++-----
 drivers/ide/ide.c            |   10 +++++-----
 drivers/ide/legacy/ali14xx.c |    9 +++++++++
 drivers/ide/legacy/dtc2278.c |   12 ++++++++++--
 drivers/ide/legacy/ht6560b.c |    8 ++++++++
 drivers/ide/legacy/qd65xx.c  |    8 ++++++++
 drivers/ide/legacy/umc8672.c |   15 ++++++++++++---
 8 files changed, 66 insertions(+), 20 deletions(-)

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
 
@@ -308,6 +303,15 @@ There may be more options than shown -- 
 
 Everything else is rejected with a "BAD OPTION" message.
 
+For legacy IDE VLB host drivers (ali14xx/dtc2278/ht6560b/qd65xx/umc8672)
+you need to explicitly enable probing by using "probe" kernel parameter,
+i.e. to enable probing for ALI M14xx chipsets (ali14xx host driver) use:
+
+* "ali14xx.probe" boot option when ali14xx driver is built-in the kernel
+
+* "probe" module parameter when ali14xx driver is compiled as module
+  ("modprobe ali14xx probe")
+
 ================================================================================
 
 IDE ATAPI streaming tape driver
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
