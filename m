From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/8] ide: sanitize ACPI initialization
Date: Sun, 11 Jan 2009 20:11:46 +0100
Message-ID: <20090111191146.17361.22612.sendpatchset@localhost.localdomain>
References: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63185 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbZAKTKy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 14:10:54 -0500
In-Reply-To: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: sanitize ACPI initialization

* ide_acpi_init() -> ide_acpi_init_port()

* ide_acpi_blacklist() -> ide_acpi_init()

* Call ide_acpi_init() only once (do it during IDE core
  initialization) and cleanup the function accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c  |   12 +++---------
 drivers/ide/ide-probe.c |    2 +-
 drivers/ide/ide.c       |    2 ++
 include/linux/ide.h     |    6 ++++--
 4 files changed, 10 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -95,12 +95,8 @@ static const struct dmi_system_id ide_ac
 	{ }	/* terminate list */
 };
 
-static int ide_acpi_blacklist(void)
+int ide_acpi_init(void)
 {
-	static int done;
-	if (done)
-		return 0;
-	done = 1;
 	dmi_check_system(ide_acpi_dmi_table);
 	return 0;
 }
@@ -630,7 +626,7 @@ void ide_acpi_set_state(ide_hwif_t *hwif
 }
 
 /**
- * ide_acpi_init - initialize the ACPI link for an IDE interface
+ * ide_acpi_init_port - initialize the ACPI link for an IDE interface
  * @hwif: target IDE interface (channel)
  *
  * The ACPI spec is not quite clear when the drive identify buffer
@@ -640,10 +636,8 @@ void ide_acpi_set_state(ide_hwif_t *hwif
  * So we get the information during startup; but this means that
  * any changes during run-time will be lost after resume.
  */
-void ide_acpi_init(ide_hwif_t *hwif)
+void ide_acpi_init_port(ide_hwif_t *hwif)
 {
-	ide_acpi_blacklist();
-
 	hwif->acpidata = kzalloc(sizeof(struct ide_acpi_hwif_link), GFP_KERNEL);
 	if (!hwif->acpidata)
 		return;
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1507,7 +1507,7 @@ int ide_host_register(struct ide_host *h
 
 		j++;
 
-		ide_acpi_init(hwif);
+		ide_acpi_init_port(hwif);
 
 		if (hwif->present)
 			ide_acpi_port_init_devices(hwif);
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -522,6 +522,8 @@ static int __init ide_init(void)
 		goto out_port_class;
 	}
 
+	ide_acpi_init();
+
 	proc_ide_create();
 
 	return 0;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1482,17 +1482,19 @@ static inline void ide_release_dma_engin
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 #ifdef CONFIG_BLK_DEV_IDEACPI
+int ide_acpi_init(void);
 extern int ide_acpi_exec_tfs(ide_drive_t *drive);
 extern void ide_acpi_get_timing(ide_hwif_t *hwif);
 extern void ide_acpi_push_timing(ide_hwif_t *hwif);
-extern void ide_acpi_init(ide_hwif_t *hwif);
+void ide_acpi_init_port(ide_hwif_t *);
 void ide_acpi_port_init_devices(ide_hwif_t *);
 extern void ide_acpi_set_state(ide_hwif_t *hwif, int on);
 #else
+static inline int ide_acpi_init(void) { return 0; }
 static inline int ide_acpi_exec_tfs(ide_drive_t *drive) { return 0; }
 static inline void ide_acpi_get_timing(ide_hwif_t *hwif) { ; }
 static inline void ide_acpi_push_timing(ide_hwif_t *hwif) { ; }
-static inline void ide_acpi_init(ide_hwif_t *hwif) { ; }
+static inline void ide_acpi_init_port(ide_hwif_t *hwif) { ; }
 static inline void ide_acpi_port_init_devices(ide_hwif_t *hwif) { ; }
 static inline void ide_acpi_set_state(ide_hwif_t *hwif, int on) {}
 #endif
