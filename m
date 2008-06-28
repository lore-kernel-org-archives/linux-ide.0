From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] ide: fix ide_host_register() return value
Date: Sat, 28 Jun 2008 23:44:03 +0200
Message-ID: <20080628214403.21345.90750.sendpatchset@localhost.localdomain>
References: <20080628214355.21345.94835.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:31469 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbYF1VmD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jun 2008 17:42:03 -0400
Received: by nf-out-0910.google.com with SMTP id d3so273047nfc.21
        for <linux-ide@vger.kernel.org>; Sat, 28 Jun 2008 14:42:01 -0700 (PDT)
In-Reply-To: <20080628214355.21345.94835.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Fix ide_host_register() to fail only if all ports cannot be registered.

While at it:

* Use host->ports[] instead of ide_hwifs[] and remove idx[].

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1580,19 +1580,16 @@ int ide_host_register(struct ide_host *h
 		      hw_regs_t **hws)
 {
 	ide_hwif_t *hwif, *mate = NULL;
-	u8 idx[MAX_HWIFS];
-	int i, rc = 0;
+	int i, j = 0;
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		idx[i] = host->ports[i] ? host->ports[i]->index : 0xff;
+		hwif = host->ports[i];
 
-		if (idx[i] == 0xff) {
+		if (hwif == NULL) {
 			mate = NULL;
 			continue;
 		}
 
-		hwif = &ide_hwifs[idx[i]];
-
 		ide_init_port_hw(hwif, hws[i]);
 		ide_port_apply_params(hwif);
 
@@ -1614,10 +1611,10 @@ int ide_host_register(struct ide_host *h
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		if (idx[i] == 0xff)
-			continue;
+		hwif = host->ports[i];
 
-		hwif = &ide_hwifs[idx[i]];
+		if (hwif == NULL)
+			continue;
 
 		if (ide_probe_port(hwif) == 0)
 			hwif->present = 1;
@@ -1631,19 +1628,20 @@ int ide_host_register(struct ide_host *h
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		if (idx[i] == 0xff)
-			continue;
+		hwif = host->ports[i];
 
-		hwif = &ide_hwifs[idx[i]];
+		if (hwif == NULL)
+			continue;
 
 		if (hwif_init(hwif) == 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
 					 "interface\n", hwif->name);
 			hwif->present = 0;
-			rc = -1;
 			continue;
 		}
 
+		j++;
+
 		if (hwif->present)
 			ide_port_setup_devices(hwif);
 
@@ -1654,10 +1652,10 @@ int ide_host_register(struct ide_host *h
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		if (idx[i] == 0xff)
-			continue;
+		hwif = host->ports[i];
 
-		hwif = &ide_hwifs[idx[i]];
+		if (hwif == NULL)
+			continue;
 
 		if (hwif->chipset == ide_unknown)
 			hwif->chipset = ide_generic;
@@ -1667,10 +1665,10 @@ int ide_host_register(struct ide_host *h
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
-		if (idx[i] == 0xff)
-			continue;
+		hwif = host->ports[i];
 
-		hwif = &ide_hwifs[idx[i]];
+		if (hwif == NULL)
+			continue;
 
 		ide_sysfs_register_port(hwif);
 		ide_proc_register_port(hwif);
@@ -1679,7 +1677,7 @@ int ide_host_register(struct ide_host *h
 			ide_proc_port_register_devices(hwif);
 	}
 
-	return rc;
+	return j ? 0 : -1;
 }
 EXPORT_SYMBOL_GPL(ide_host_register);
 
