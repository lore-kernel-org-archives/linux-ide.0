From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/21] ide: remove ideprobe_init()
Date: Sun, 18 Nov 2007 23:25:09 +0100
Message-ID: <200711182325.09262.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:49042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbXKRWgp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:45 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873055ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Rename ide_device_add() to ide_device_add_all() and make it accept
  'u8 idx[MAX_HWIFS]' instead of 'u8 idx[4]' as an argument.

* Add ide_device_add() wrapper for ide_device_add_all().

* Convert ide_generic_init() to use ide_device_add_all().

* Remove no longer needed ideprobe_init().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |    8 +++++-
 drivers/ide/ide-probe.c   |   54 +++++++++++++---------------------------------
 include/linux/ide.h       |    3 --
 3 files changed, 24 insertions(+), 41 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -14,10 +14,16 @@
 
 static int __init ide_generic_init(void)
 {
+	u8 idx[MAX_HWIFS];
+	int i;
+
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_get_lock(NULL, NULL); /* for atari only */
 
-	(void)ideprobe_init();
+	for (i = 0; i < MAX_HWIFS; i++)
+		idx[i] = ide_hwifs[i].present ? 0xff : i;
+
+	ide_device_add_all(idx);
 
 	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
 		ide_release_lock();	/* for atari only */
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1347,52 +1347,19 @@ static void hwif_register_devices(ide_hw
 	}
 }
 
-int ideprobe_init (void)
-{
-	unsigned int index;
-	int probe[MAX_HWIFS];
-
-	memset(probe, 0, MAX_HWIFS * sizeof(int));
-	for (index = 0; index < MAX_HWIFS; ++index)
-		probe[index] = !ide_hwifs[index].present;
-
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			probe_hwif(&ide_hwifs[index]);
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			hwif_init(&ide_hwifs[index]);
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		if (probe[index]) {
-			ide_hwif_t *hwif = &ide_hwifs[index];
-			if (!hwif->present)
-				continue;
-			if (hwif->chipset == ide_unknown || hwif->chipset == ide_forced)
-				hwif->chipset = ide_generic;
-			hwif_register_devices(hwif);
-		}
-	}
-	for (index = 0; index < MAX_HWIFS; ++index)
-		if (probe[index])
-			ide_proc_register_port(&ide_hwifs[index]);
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ideprobe_init);
-
-int ide_device_add(u8 idx[4])
+int ide_device_add_all(u8 idx[MAX_HWIFS])
 {
 	ide_hwif_t *hwif;
 	int i, rc = 0;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < MAX_HWIFS; i++) {
 		if (idx[i] == 0xff)
 			continue;
 
 		probe_hwif(&ide_hwifs[idx[i]]);
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < MAX_HWIFS; i++) {
 		if (idx[i] == 0xff)
 			continue;
 
@@ -1406,7 +1373,7 @@ int ide_device_add(u8 idx[4])
 		}
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < MAX_HWIFS; i++) {
 		if (idx[i] == 0xff)
 			continue;
 
@@ -1420,12 +1387,23 @@ int ide_device_add(u8 idx[4])
 		}
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < MAX_HWIFS; i++) {
 		if (idx[i] != 0xff)
 			ide_proc_register_port(&ide_hwifs[idx[i]]);
 	}
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ide_device_add_all);
 
+int ide_device_add(u8 idx[4])
+{
+	u8 idx_all[MAX_HWIFS];
+	int i;
+
+	for (i = 0; i < MAX_HWIFS; i++)
+		idx_all[i] = (i < 4) ? idx[i] : 0xff;
+
+	return ide_device_add_all(idx_all);
+}
 EXPORT_SYMBOL_GPL(ide_device_add);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1011,8 +1011,6 @@ extern void do_ide_request(struct reques
 
 void ide_init_disk(struct gendisk *, ide_drive_t *);
 
-extern int ideprobe_init(void);
-
 #ifdef CONFIG_IDEPCI_PCIBUS_ORDER
 extern void ide_scan_pcibus(int scan_direction) __init;
 extern int __ide_pci_register_driver(struct pci_driver *driver, struct module *owner, const char *mod_name);
@@ -1202,6 +1200,7 @@ void ide_unregister_region(struct gendis
 
 void ide_undecoded_slave(ide_drive_t *);
 
+int ide_device_add_all(u8 idx[MAX_HWIFS]);
 int ide_device_add(u8 idx[4]);
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
