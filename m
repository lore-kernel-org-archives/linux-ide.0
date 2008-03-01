From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/9] ide-generic: manage I/O resources in driver
Date: Sat, 1 Mar 2008 19:47:34 +0100
Message-ID: <200803011947.34906.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:28111 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665AbYCAUng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 15:43:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1035338ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 12:43:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Tell IDE layer to not manage resources by setting hwif->mmio flag.

* Use {request,release}_region() for resources management.

* Use driver name for resources management.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-generic.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -94,7 +94,24 @@ static int __init ide_generic_init(void)
 		unsigned long io_addr = ide_default_io_base(i);
 		hw_regs_t hw;
 
+		idx[i] = 0xff;
+
 		if (io_addr) {
+			if (!request_region(io_addr, 8, DRV_NAME)) {
+				printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX "
+						"not free.\n",
+						DRV_NAME, io_addr, io_addr + 7);
+				continue;
+			}
+
+			if (!request_region(io_addr + 0x206, 1, DRV_NAME)) {
+				printk(KERN_ERR "%s: I/O resource 0x%lX "
+						"not free.\n",
+						DRV_NAME, io_addr + 0x206);
+				release_region(io_addr, 8);
+				continue;
+			}
+
 			/*
 			 * Skip probing if the corresponding
 			 * slot is already occupied.
@@ -109,10 +126,10 @@ static int __init ide_generic_init(void)
 			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
 			hw.irq = ide_default_irq(io_addr);
 			ide_init_port_hw(hwif, &hw);
+			hwif->mmio = 1;
 
 			idx[i] = i;
-		} else
-			idx[i] = 0xff;
+		}
 	}
 
 	ide_device_add_all(idx, NULL);
