From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/11] ppc/hdpu: remove dead IDE code
Date: Thu, 14 Feb 2008 01:36:35 +0100
Message-ID: <20080214003635.12879.88066.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:4136 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933893AbYBNAWK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 19:22:10 -0500
Received: by fk-out-0910.google.com with SMTP id z23so198081fkz.5
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 16:22:08 -0800 (PST)
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org

Also remove now not needed <linux/ide.h> include.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/ppc/platforms/hdpu.c |   36 ------------------------------------
 1 file changed, 36 deletions(-)

Index: b/arch/ppc/platforms/hdpu.c
===================================================================
--- a/arch/ppc/platforms/hdpu.c
+++ b/arch/ppc/platforms/hdpu.c
@@ -16,7 +16,6 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/platform_device.h>
 
@@ -604,41 +603,6 @@ static void parse_bootinfo(unsigned long
 	}
 }
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-static void
-hdpu_ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
-{
-	request_region(from, extent, name);
-	return;
-}
-
-static void hdpu_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-	return;
-}
-
-static void __init
-hdpu_ide_pci_init_hwif_ports(hw_regs_t * hw, ide_ioreg_t data_port,
-			     ide_ioreg_t ctrl_port, int *irq)
-{
-	struct pci_dev *dev;
-
-	pci_for_each_dev(dev) {
-		if (((dev->class >> 8) == PCI_CLASS_STORAGE_IDE) ||
-		    ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)) {
-			hw->irq = dev->irq;
-
-			if (irq != NULL) {
-				*irq = dev->irq;
-			}
-		}
-	}
-
-	return;
-}
-#endif
-
 void hdpu_heartbeat(void)
 {
 	if (mv64x60_read(&bh, MV64x60_GPP_VALUE) & (1 << 5))
