From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add "ignore_cable" parameter (take 2)
Date: Sat, 22 Mar 2008 23:03:20 +0100
Message-ID: <200803222303.20303.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:2564 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbYCVVtl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Mar 2008 17:49:41 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1853179ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 14:49:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add "ignore_cable" parameter:

* "ide_core.ignore_cable=[interface_number]" boot option if IDE is built-in
  (i.e. "ide_core.ignore_cable=1" to force ignoring cable for "ide1")

* "ignore_cable=[interface_number]" module parameter (for ide_core module)
  if IDE is compiled as module

v2:
* Add ide_port_apply_params() helper
  - use it in ide_device_add_all() and ide_scan_port().

* Make it possible to later disable ignoring cable detection by passing
  "[interface_number]:0" to /sys/module/ide_core/parameters/ignore_cable
  (however sysfs interface is not enabled yet since it needs some other
   IDE changes to make it work reliable).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch

 Documentation/ide/ide.txt |   15 ++++++++++-----
 drivers/ide/ide-probe.c   |   10 +++++++++-
 drivers/ide/ide.c         |   32 ++++++++++++++++++++++++++++++++
 include/linux/ide.h       |    2 ++
 4 files changed, 53 insertions(+), 6 deletions(-)

Index: b/Documentation/ide/ide.txt
===================================================================
--- a/Documentation/ide/ide.txt
+++ b/Documentation/ide/ide.txt
@@ -224,11 +224,6 @@ Summary of ide driver parameters for ker
 
  "idex=reset"		: reset interface after probe
 
- "idex=ata66"		: informs the interface that it has an 80c cable
-			  for chipsets that are ATA-66 capable, but the
-			  ability to bit test for detection is currently
-			  unknown.
-
  "ide=doubler"		: probe/support IDE doublers on Amiga
 
 There may be more options than shown -- use the source, Luke!
@@ -251,6 +246,16 @@ are detected automatically).
 You also need to use "probe" kernel parameter for ide-4drives driver
 (support for IDE generic chipset with four drives on one port).
 
+To force ignoring cable detection (this should be needed only if you're using
+short 40-wires cable which cannot be automatically detected - if this is not
+a case please report it as a bug instead) use "ignore_cable" kernel parameter:
+
+* "ide_core.ignore_cable=[interface_number]" boot option if IDE is built-in
+  (i.e. "ide_core.ignore_cable=1" to force ignoring cable for "ide1")
+
+* "ignore_cable=[interface_number]" module parameter (for ide_core module)
+  if IDE is compiled as module
+
 ================================================================================
 
 Some Terminology
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1517,13 +1517,20 @@ int ide_device_add_all(u8 *idx, const st
 	int i, rc = 0;
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		if (d == NULL || idx[i] == 0xff) {
+		if (idx[i] == 0xff) {
 			mate = NULL;
 			continue;
 		}
 
 		hwif = &ide_hwifs[idx[i]];
 
+		ide_port_apply_params(hwif);
+
+		if (d == NULL) {
+			mate = NULL;
+			continue;
+		}
+
 		if (d->chipset != ide_etrax100 && (i & 1) && mate) {
 			hwif->mate = mate;
 			mate->mate = hwif;
@@ -1620,6 +1627,7 @@ EXPORT_SYMBOL_GPL(ide_device_add);
 
 void ide_port_scan(ide_hwif_t *hwif)
 {
+	ide_port_apply_params(hwif);
 	ide_port_cable_detect(hwif);
 	ide_port_init_devices(hwif);
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1239,6 +1239,38 @@ static void ide_port_class_release(struc
 	put_device(&hwif->gendev);
 }
 
+static unsigned int ide_ignore_cable;
+
+static int ide_set_ignore_cable(const char *s, struct kernel_param *kp)
+{
+	int i, j = 1;
+
+	if (sscanf(s, "%d:%d", &i, &j) != 2 && sscanf(s, "%d", &i) != 1)
+		return -EINVAL;
+
+	if (i >= MAX_HWIFS || j < 0 || j > 1)
+		return -EINVAL;
+
+	if (j)
+		ide_ignore_cable |= (1 << i);
+	else
+		ide_ignore_cable &= (1 << i);
+
+	return 0;
+}
+
+module_param_call(ignore_cable, ide_set_ignore_cable, NULL, NULL, 0);
+MODULE_PARM_DESC(ignore_cable, "ignore cable detection");
+
+void ide_port_apply_params(ide_hwif_t *hwif)
+{
+	if (ide_ignore_cable & (1 << hwif->index)) {
+		printk(KERN_INFO "ide: ignoring cable detection for %s\n",
+				 hwif->name);
+		hwif->cbl = ATA_CBL_PATA40_SHORT;
+	}
+}
+
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1223,6 +1223,8 @@ void ide_unregister_region(struct gendis
 
 void ide_undecoded_slave(ide_drive_t *);
 
+void ide_port_apply_params(ide_hwif_t *);
+
 int ide_device_add_all(u8 *idx, const struct ide_port_info *);
 int ide_device_add(u8 idx[4], const struct ide_port_info *);
 int ide_legacy_device_add(const struct ide_port_info *, unsigned long);
