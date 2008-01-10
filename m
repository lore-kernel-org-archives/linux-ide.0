From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Thu, 10 Jan 2008 23:27:21 +0100
Message-ID: <200801102327.22570.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:24585 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYAJWR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 17:17:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so377681ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 14:17:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hopefully the final IDE update for 2.6.24.

Please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide-acpi.c   |   36 +++++++++++++++++++++++++++++++++++-
 drivers/ide/ide-iops.c   |    6 +++---
 drivers/ide/pci/trm290.c |   29 ++++++++++++++++++++---------
 3 files changed, 58 insertions(+), 13 deletions(-)


George Kibardin (1):
      ide: fix cable detection for SATA bridges

Sergei Shtylyov (1):
      trm290: do hook dma_host_{on,off} methods (take 2)

Shaohua Li (1):
      ide: workaround suspend bug for ACPI IDE


diff --git a/drivers/ide/ide-acpi.c b/drivers/ide/ide-acpi.c
index 89df48f..fe6768a 100644
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -16,6 +16,7 @@
 #include <acpi/acpi.h>
 #include <linux/ide.h>
 #include <linux/pci.h>
+#include <linux/dmi.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acnames.h>
@@ -65,6 +66,37 @@ extern int ide_noacpi;
 extern int ide_noacpitfs;
 extern int ide_noacpionboot;
 
+static bool ide_noacpi_psx;
+static int no_acpi_psx(const struct dmi_system_id *id)
+{
+	ide_noacpi_psx = true;
+	printk(KERN_NOTICE"%s detected - disable ACPI _PSx.\n", id->ident);
+	return 0;
+}
+
+static const struct dmi_system_id ide_acpi_dmi_table[] = {
+	/* Bug 9673. */
+	/* We should check if this is because ACPI NVS isn't save/restored. */
+	{
+		.callback = no_acpi_psx,
+		.ident    = "HP nx9005",
+		.matches  = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies Ltd."),
+			DMI_MATCH(DMI_BIOS_VERSION, "KAM1.60")
+		},
+	},
+};
+
+static int ide_acpi_blacklist(void)
+{
+	static int done;
+	if (done)
+		return 0;
+	done = 1;
+	dmi_check_system(ide_acpi_dmi_table);
+	return 0;
+}
+
 /**
  * ide_get_dev_handle - finds acpi_handle and PCI device.function
  * @dev: device to locate
@@ -623,7 +655,7 @@ void ide_acpi_set_state(ide_hwif_t *hwif, int on)
 {
 	int unit;
 
-	if (ide_noacpi)
+	if (ide_noacpi || ide_noacpi_psx)
 		return;
 
 	DEBPRINT("ENTER:\n");
@@ -668,6 +700,8 @@ void ide_acpi_init(ide_hwif_t *hwif)
 	struct ide_acpi_drive_link	*master;
 	struct ide_acpi_drive_link	*slave;
 
+	ide_acpi_blacklist();
+
 	hwif->acpidata = kzalloc(sizeof(struct ide_acpi_hwif_link), GFP_KERNEL);
 	if (!hwif->acpidata)
 		return;
diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
index cef405d..bb9693d 100644
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -612,12 +612,12 @@ u8 eighty_ninty_three (ide_drive_t *drive)
 		printk(KERN_DEBUG "%s: skipping word 93 validity check\n",
 				  drive->name);
 
+	if (ide_dev_is_sata(id) && !ivb)
+		return 1;
+
 	if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
 		goto no_80w;
 
-	if (ide_dev_is_sata(id))
-		return 1;
-
 	/*
 	 * FIXME:
 	 * - force bit13 (80c cable present) check also for !ivb devices
diff --git a/drivers/ide/pci/trm290.c b/drivers/ide/pci/trm290.c
index 0895e75..0151d7f 100644
--- a/drivers/ide/pci/trm290.c
+++ b/drivers/ide/pci/trm290.c
@@ -1,7 +1,8 @@
 /*
- *  linux/drivers/ide/pci/trm290.c		Version 1.02	Mar. 18, 2000
+ *  linux/drivers/ide/pci/trm290.c		Version 1.05	Dec. 26, 2007
  *
  *  Copyright (c) 1997-1998  Mark Lord
+ *  Copyright (c) 2007       MontaVista Software, Inc. <source@mvista.com>
  *  May be copied or modified under the terms of the GNU General Public License
  *
  *  June 22, 2004 - get rid of check_region
@@ -177,7 +178,7 @@ static void trm290_selectproc (ide_drive_t *drive)
 	trm290_prepare_drive(drive, drive->using_dma);
 }
 
-static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
+static void trm290_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	BUG_ON(HWGROUP(drive)->handler != NULL);	/* paranoia check */
 	ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
@@ -185,7 +186,7 @@ static void trm290_ide_dma_exec_cmd(ide_drive_t *drive, u8 command)
 	outb(command, IDE_COMMAND_REG);
 }
 
-static int trm290_ide_dma_setup(ide_drive_t *drive)
+static int trm290_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq = hwif->hwgroup->rq;
@@ -215,7 +216,7 @@ static int trm290_ide_dma_setup(ide_drive_t *drive)
 	return 0;
 }
 
-static void trm290_ide_dma_start(ide_drive_t *drive)
+static void trm290_dma_start(ide_drive_t *drive)
 {
 }
 
@@ -240,6 +241,14 @@ static int trm290_ide_dma_test_irq (ide_drive_t *drive)
 	return (status == 0x00ff);
 }
 
+static void trm290_dma_host_on(ide_drive_t *drive)
+{
+}
+
+static void trm290_dma_host_off(ide_drive_t *drive)
+{
+}
+
 static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
 	unsigned int cfgbase = 0;
@@ -280,11 +289,13 @@ static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
 
-	hwif->dma_setup = &trm290_ide_dma_setup;
-	hwif->dma_exec_cmd = &trm290_ide_dma_exec_cmd;
-	hwif->dma_start = &trm290_ide_dma_start;
-	hwif->ide_dma_end = &trm290_ide_dma_end;
-	hwif->ide_dma_test_irq = &trm290_ide_dma_test_irq;
+	hwif->dma_host_off	= &trm290_dma_host_off;
+	hwif->dma_host_on	= &trm290_dma_host_on;
+	hwif->dma_setup 	= &trm290_dma_setup;
+	hwif->dma_exec_cmd	= &trm290_dma_exec_cmd;
+	hwif->dma_start 	= &trm290_dma_start;
+	hwif->ide_dma_end	= &trm290_ide_dma_end;
+	hwif->ide_dma_test_irq	= &trm290_ide_dma_test_irq;
 
 	hwif->selectproc = &trm290_selectproc;
 #if 1
