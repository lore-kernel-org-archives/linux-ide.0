From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/15] ide: cleanup ide_system_bus_speed()
Date: Fri, 04 Jan 2008 22:25:15 +0100
Message-ID: <20080104212515.6978.60571.sendpatchset@localhost.localdomain>
References: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:37216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbYADVNk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 16:13:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2833655ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 13:13:39 -0800 (PST)
In-Reply-To: <20080104212424.6978.93646.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Use the facts that:

* When ide_init() is called 'system_bus_speed' always equals zero.

* system_bus_clock() is never called before ide_init().

and:

* Move printk() from ide_system_bus_speed() to ide_init().

* Don't assign 'system_bus_speed' in ide_system_bus_speed().

* Don't call ide_system_bus_speed() in system_bus_clock().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-39 bytes
 drivers/ide/ide.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -240,22 +240,12 @@ static int ide_system_bus_speed(void)
 #define pci_default 0
 #endif /* CONFIG_PCI */
 
-	if (!system_bus_speed) {
-		if (idebus_parameter) {
-			/* user supplied value */
-			system_bus_speed = idebus_parameter;
-		} else if (pci_dev_present(pci_default)) {
-			/* safe default value for PCI */
-			system_bus_speed = 33;
-		} else {
-			/* safe default value for VESA and PCI */
-			system_bus_speed = 50;
-		}
-		printk(KERN_INFO "ide: Assuming %dMHz system bus speed "
-			"for PIO modes%s\n", system_bus_speed,
-			idebus_parameter ? "" : "; override with idebus=xx");
-	}
-	return system_bus_speed;
+	/* user supplied value */
+	if (idebus_parameter)
+		return idebus_parameter;
+
+	/* safe default value for PCI or VESA and PCI*/
+	return pci_dev_present(pci_default) ? 33 : 50;
 }
 
 ide_hwif_t * ide_find_port(unsigned long base)
@@ -912,7 +902,7 @@ static int set_unmaskirq(ide_drive_t *dr
 
 int system_bus_clock (void)
 {
-	return((int) ((!system_bus_speed) ? ide_system_bus_speed() : system_bus_speed ));
+	return system_bus_speed;
 }
 
 EXPORT_SYMBOL(system_bus_clock);
@@ -1667,6 +1657,10 @@ static int __init ide_init(void)
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 	system_bus_speed = ide_system_bus_speed();
 
+	printk(KERN_INFO "ide: Assuming %dMHz system bus speed "
+			 "for PIO modes%s\n", system_bus_speed,
+			idebus_parameter ? "" : "; override with idebus=xx");
+
 	ret = bus_register(&ide_bus_type);
 	if (ret < 0) {
 		printk(KERN_WARNING "IDE: bus_register error: %d\n", ret);
