From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 22/22] ide: move create_proc_ide_drives() call to ide_device_add_all()
Date: Thu, 17 Jan 2008 00:28:39 +0100
Message-ID: <20080116232839.9166.48289.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022AbYAPXP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:58 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Un-static create_proc_ide_drives() and call it from ide_device_add_all().

While at it:
* Rename create_proc_ide_drives() to ide_proc_port_register_devices().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 +++-
 drivers/ide/ide-proc.c  |    4 +---
 include/linux/ide.h     |    2 ++
 3 files changed, 6 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1453,8 +1453,10 @@ int ide_device_add_all(u8 idx[MAX_HWIFS]
 
 		hwif = &ide_hwifs[idx[i]];
 
-		if (hwif->present)
+		if (hwif->present) {
 			ide_proc_register_port(hwif);
+			ide_proc_port_register_devices(hwif);
+		}
 	}
 
 	return rc;
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -739,7 +739,7 @@ void ide_proc_unregister_driver(ide_driv
 
 EXPORT_SYMBOL(ide_proc_unregister_driver);
 
-static void create_proc_ide_drives(ide_hwif_t *hwif)
+void ide_proc_port_register_devices(ide_hwif_t *hwif)
 {
 	int	d;
 	struct proc_dir_entry *ent;
@@ -801,8 +801,6 @@ void ide_proc_register_port(ide_hwif_t *
 
 		ide_add_proc_entries(hwif->proc, hwif_entries, hwif);
 	}
-
-	create_proc_ide_drives(hwif);
 }
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -715,6 +715,7 @@ typedef struct {
 void proc_ide_create(void);
 void proc_ide_destroy(void);
 void ide_proc_register_port(ide_hwif_t *);
+void ide_proc_port_register_devices(ide_hwif_t *);
 void ide_proc_unregister_port(ide_hwif_t *);
 void ide_proc_register_driver(ide_drive_t *, ide_driver_t *);
 void ide_proc_unregister_driver(ide_drive_t *, ide_driver_t *);
@@ -747,6 +748,7 @@ void ide_pci_create_host_proc(const char
 static inline void proc_ide_create(void) { ; }
 static inline void proc_ide_destroy(void) { ; }
 static inline void ide_proc_register_port(ide_hwif_t *hwif) { ; }
+static inline void ide_proc_port_register_devices(ide_hwif_t *hwif) { ; }
 static inline void ide_proc_unregister_port(ide_hwif_t *hwif) { ; }
 static inline void ide_proc_register_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
 static inline void ide_proc_unregister_driver(ide_drive_t *drive, ide_driver_t *driver) { ; }
