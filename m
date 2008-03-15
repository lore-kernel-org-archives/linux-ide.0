From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove IDE devices from /proc/ide/ before unregistering them
Date: Sat, 15 Mar 2008 22:27:13 +0100
Message-ID: <200803152227.13231.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755189AbYCOVbQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

IDE devices need to be removed from /proc/ide/ _before_ being unregistered:

* Drop 'ide_hwif_t *hwif' argument from destroy_proc_ide_device()
  and use drive->hwif instead.

* Rename destroy_proc_ide_device() to ide_proc_unregister_device().

* Call ide_proc_unregister_device() in drive_release_dev().

* Remove no longer needed destroy_proc_ide_drives().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes before "ide: factor out code unregistering devices from ide_unregister()"
patch in IDE tree

 drivers/ide/ide-probe.c |    2 ++
 drivers/ide/ide-proc.c  |   16 ++--------------
 include/linux/ide.h     |    2 ++
 3 files changed, 6 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1198,6 +1198,8 @@ static void drive_release_dev (struct de
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
+	ide_proc_unregister_device(drive);
+
 	spin_lock_irq(&ide_lock);
 	ide_remove_drive_from_hwgroup(drive);
 	kfree(drive->id);
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -764,27 +764,16 @@ void ide_proc_port_register_devices(ide_
 	}
 }
 
-static void destroy_proc_ide_device(ide_hwif_t *hwif, ide_drive_t *drive)
+void ide_proc_unregister_device(ide_drive_t *drive)
 {
 	if (drive->proc) {
 		ide_remove_proc_entries(drive->proc, generic_drive_entries);
 		remove_proc_entry(drive->name, proc_ide_root);
-		remove_proc_entry(drive->name, hwif->proc);
+		remove_proc_entry(drive->name, drive->hwif->proc);
 		drive->proc = NULL;
 	}
 }
 
-static void destroy_proc_ide_drives(ide_hwif_t *hwif)
-{
-	int	d;
-
-	for (d = 0; d < MAX_DRIVES; d++) {
-		ide_drive_t *drive = &hwif->drives[d];
-		if (drive->proc)
-			destroy_proc_ide_device(hwif, drive);
-	}
-}
-
 static ide_proc_entry_t hwif_entries[] = {
 	{ "channel",	S_IFREG|S_IRUGO,	proc_ide_read_channel,	NULL },
 	{ "mate",	S_IFREG|S_IRUGO,	proc_ide_read_mate,	NULL },
@@ -816,7 +805,6 @@ EXPORT_SYMBOL_GPL(ide_pci_create_host_pr
 void ide_proc_unregister_port(ide_hwif_t *hwif)
 {
 	if (hwif->proc) {
-		destroy_proc_ide_drives(hwif);
 		ide_remove_proc_entries(hwif->proc, hwif_entries);
 		remove_proc_entry(hwif->name, proc_ide_root);
 		hwif->proc = NULL;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -690,6 +690,7 @@ void proc_ide_create(void);
 void proc_ide_destroy(void);
 void ide_proc_register_port(ide_hwif_t *);
 void ide_proc_port_register_devices(ide_hwif_t *);
+void ide_proc_unregister_device(ide_drive_t *);
 void ide_proc_unregister_port(ide_hwif_t *);
 void ide_proc_register_driver(ide_drive_t *, ide_driver_t *);
 void ide_proc_unregister_driver(ide_drive_t *, ide_driver_t *);
@@ -723,6 +724,7 @@ static inline void proc_ide_create(void)
 static inline void proc_ide_destroy(void) { ; }
 static inline void ide_proc_register_port(ide_hwif_t *hwif) { ; }
 static inline void ide_proc_port_register_devices(ide_hwif_t *hwif) { ; }
+static inline void ide_proc_unregister_device(ide_drive_t *drive) { ; }
 static inline void ide_proc_unregister_port(ide_hwif_t *hwif) { ; }
 static inline void ide_proc_register_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
 static inline void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
