From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch]workaround suspend bug for ACPI IDE
Date: Thu, 10 Jan 2008 09:26:32 +0800
Message-ID: <1199928392.21141.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47254 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbYAJB0n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 20:26:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: bzolnier@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>

http://bugzilla.kernel.org/show_bug.cgi?id=9673
ACPI _PS3 cause S4 breaks in the second attempt. The system has a _PS3
method for IDE, which will call into SMM mode. Currently we haven't clue
why just the second attempt fails, as it's totally in BIOS code, so
blacklist the system so far for 2.6.24.

A possible suspect is ACPI NVS isn't save/restore, we will revisit the
bug after linux does ACPI NVS save/restore.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/ide/ide-acpi.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: linux/drivers/ide/ide-acpi.c
===================================================================
--- linux.orig/drivers/ide/ide-acpi.c	2008-01-07 10:13:28.000000000 +0800
+++ linux/drivers/ide/ide-acpi.c	2008-01-08 09:10:48.000000000 +0800
@@ -16,6 +16,7 @@
 #include <acpi/acpi.h>
 #include <linux/ide.h>
 #include <linux/pci.h>
+#include <linux/dmi.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acnames.h>
@@ -65,6 +66,31 @@ extern int ide_noacpi;
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
+static struct dmi_system_id ide_acpi_dmi_table[] = {
+	/* Bug 9673. We should check if this is because ACPI NVS isn't save/restored */
+	{no_acpi_psx, "HP nx9005",{
+	 DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies Ltd."),
+	 DMI_MATCH(DMI_BIOS_VERSION, "KAM1.60")},NULL},
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
@@ -623,7 +649,7 @@ void ide_acpi_set_state(ide_hwif_t *hwif
 {
 	int unit;
 
-	if (ide_noacpi)
+	if (ide_noacpi || ide_noacpi_psx)
 		return;
 
 	DEBPRINT("ENTER:\n");
@@ -668,6 +694,8 @@ void ide_acpi_init(ide_hwif_t *hwif)
 	struct ide_acpi_drive_link	*master;
 	struct ide_acpi_drive_link	*slave;
 
+	ide_acpi_blacklist();
+
 	hwif->acpidata = kzalloc(sizeof(struct ide_acpi_hwif_link), GFP_KERNEL);
 	if (!hwif->acpidata)
 		return;


