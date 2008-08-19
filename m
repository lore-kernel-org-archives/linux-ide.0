From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/5] ide-generic: no need to probe all ports at once
Date: Tue, 19 Aug 2008 20:32:33 +0200
Message-ID: <200808192032.33287.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:24747 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbYHSShS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 14:37:18 -0400
Received: by gv-out-0910.google.com with SMTP id e6so45202gvc.37
        for <linux-ide@vger.kernel.org>; Tue, 19 Aug 2008 11:37:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |   47 +++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -137,10 +137,9 @@ static void ide_generic_check_pci_legacy
 
 static int __init ide_generic_init(void)
 {
-	hw_regs_t hw[MAX_HWIFS], *hws[MAX_HWIFS];
-	struct ide_host *host;
+	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
 	unsigned long io_addr;
-	int i, rc, primary = 0, secondary = 0;
+	int i, rc = 0, primary = 0, secondary = 0;
 
 #ifdef CONFIG_MIPS
 	if (!ide_probe_legacy())
@@ -161,13 +160,9 @@ static int __init ide_generic_init(void)
 		printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
 			"upon user request\n");
 
-	memset(hws, 0, sizeof(hw_regs_t *) * MAX_HWIFS);
-
 	for (i = 0; i < ARRAY_SIZE(legacy_bases); i++) {
 		io_addr = legacy_bases[i];
 
-		hws[i] = NULL;
-
 		if ((probe_mask & (1 << i)) && io_addr) {
 			if (!request_region(io_addr, 8, DRV_NAME)) {
 				printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX "
@@ -184,45 +179,27 @@ static int __init ide_generic_init(void)
 				continue;
 			}
 
-			memset(&hw[i], 0, sizeof(hw[i]));
-			ide_std_init_ports(&hw[i], io_addr, io_addr + 0x206);
+			memset(&hw, 0, sizeof(hw));
+			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
 #ifdef CONFIG_IA64
-			hw[i].irq = isa_irq_to_vector(legacy_irqs[i]);
+			hw.irq = isa_irq_to_vector(legacy_irqs[i]);
 #else
-			hw[i].irq = legacy_irqs[i];
+			hw.irq = legacy_irqs[i];
 #endif
-			hw[i].chipset = ide_generic;
+			hw.chipset = ide_generic;
 
-			hws[i] = &hw[i];
+			rc = ide_host_add(NULL, hws, NULL);
+			if (rc) {
+				release_region(io_addr + 0x206, 1);
+				release_region(io_addr, 8);
+			}
 		}
 	}
 
-	host = ide_host_alloc_all(NULL, hws);
-	if (host == NULL) {
-		rc = -ENOMEM;
-		goto err;
-	}
-
-	rc = ide_host_register(host, NULL, hws);
-	if (rc)
-		goto err_free;
-
 	if (ide_generic_sysfs_init())
 		printk(KERN_ERR DRV_NAME ": failed to create ide_generic "
 					 "class\n");
 
-	return 0;
-err_free:
-	ide_host_free(host);
-err:
-	for (i = 0; i < MAX_HWIFS; i++) {
-		if (hws[i] == NULL)
-			continue;
-
-		io_addr = hws[i]->io_ports.data_addr;
-		release_region(io_addr + 0x206, 1);
-		release_region(io_addr, 8);
-	}
 	return rc;
 }
 
