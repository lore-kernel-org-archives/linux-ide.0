From: Prarit Bhargava <prarit@sgi.com>
Subject: [PATCH]: Fix error handling in hwif_init and sgiioc4 driver
Date: Fri, 14 Jan 2005 09:25:11 -0500
Message-ID: <41E7D647.7090206@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090509010708030505040907"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42192 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261959AbVANOZX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jan 2005 09:25:23 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j0EEPNv9021112
	for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 09:25:23 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j0EEPMr26168
	for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 09:25:23 -0500
Received: from [172.16.80.158] (prarit.boston.redhat.com [172.16.80.158])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j0EEPKiS000562
	for <linux-ide@vger.kernel.org>; Fri, 14 Jan 2005 09:25:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090509010708030505040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I discovered an issue where a hwif_init failure lead to /proc/ide files 
being created for devices that failed probes.  This resulted in 
oops/WARN_ON/BUG_ON executions through the kernel depending on what 
actions were on going.

The first part of the fix (submitted to linux-ia64 and acpi-devel for 
review -- I'm including it for completeness) was to fix incorrect error 
handling in the ACPI layer:

===== drivers/acpi/pci_irq.c 1.35 vs edited =====
--- 1.35/drivers/acpi/pci_irq.c 2005-01-04 21:48:17 -05:00
+++ edited/drivers/acpi/pci_irq.c       2005-01-14 08:14:34 -05:00
@@ -487,10 +487,10 @@
         * If no PRT entry was found, we'll try to derive an IRQ from the
         * device's parent bridge.
         */
-       if (!gsi)
+       if (gsi == -1)
                gsi = acpi_pci_irq_derive(dev, pin,
                                          &edge_level, &active_high_low);
-       if (!gsi)
+       if (gsi == -1)
                return_VOID;

        /*

The second part of the fix is to the core IDE layer and to the SGI IOC4 
IDE driver which need to handle errors properly from failed hwif 
initializations.  This patch is attached for review.



--------------090509010708030505040907
Content-Type: text/plain;
 name="acpi-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-ide.patch"

===== drivers/ide/ide-probe.c 1.90 vs edited =====
--- 1.90/drivers/ide/ide-probe.c	2004-12-10 14:12:14 -05:00
+++ edited/drivers/ide/ide-probe.c	2005-01-14 08:18:43 -05:00
@@ -841,7 +841,10 @@
 	if (fixup)
 		fixup(hwif);
 
-	hwif_init(hwif);
+	if (!hwif_init(hwif)) {
+		printk("%s: Failed to initialize IDE interface\n", hwif->name);
+		return -1;
+	}
 
 	if (hwif->present) {
 		u16 unit = 0;
===== drivers/ide/pci/sgiioc4.c 1.22 vs edited =====
--- 1.22/drivers/ide/pci/sgiioc4.c	2005-01-06 20:35:35 -05:00
+++ edited/drivers/ide/pci/sgiioc4.c	2005-01-14 08:18:56 -05:00
@@ -669,7 +669,10 @@
 		printk(KERN_INFO "%s: %s Bus-Master DMA disabled\n",
 		       hwif->name, d->name);
 
-	probe_hwif_init(hwif);
+	if (probe_hwif_init(hwif)) {
+		printk(KERN_INFO "%s: initialization failed\n", hwif->name);
+		return -EIO;
+	}
 
 	/* Create /proc/ide entries */
 	create_proc_ide_interfaces(); 

--------------090509010708030505040907--
