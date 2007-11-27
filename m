From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] ide: always use ide_std_init_ports() in setup-pci.c
Date: Tue, 27 Nov 2007 23:57:13 +0100
Message-ID: <200711272357.13594.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:45550 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbXK0WxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 17:53:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1367708ugc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 14:53:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* ide_init_hwif_ports() call in setup-pci.c::ide_hwif_configure()
  doesn't depend on the default cotrol register offset, default IRQ
  or ppc_ide_md.ide_init_hwif implementations so ide_std_init_ports()
  can always be used.

* Since 'base' is always non-zero and thus hwif->io_ports[IDE_DATA_OFFSET]
  is also non-zero always clear hwif->noprobe.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -390,13 +390,9 @@ static ide_hwif_t *ide_hwif_configure(st
 		hw_regs_t hw;
 
 		memset(&hw, 0, sizeof(hw));
-#ifndef CONFIG_IDE_ARCH_OBSOLETE_INIT
 		ide_std_init_ports(&hw, base, ctl | 2);
-#else
-		ide_init_hwif_ports(&hw, base, ctl | 2, NULL);
-#endif
 		memcpy(hwif->io_ports, hw.io_ports, sizeof(hwif->io_ports));
-		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
+		hwif->noprobe = 0;
 	}
 	hwif->chipset = d->chipset ? d->chipset : ide_pci;
 	hwif->pci_dev = dev;
