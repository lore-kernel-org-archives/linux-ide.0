From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] k2_setup.c: remove k2_ide_init_hwif_ports()
Date: Wed, 21 Apr 2004 22:18:15 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404212218.15972.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48306 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263355AbUDVAgN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Apr 2004 20:36:13 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: paulus@samba.org
Cc: linux-ide@vger.kernel.org


Hi,

Just next patch in the "kill arch specific ide_init_hwif_ports()" series...

Cheers,
Bartlomiej


[PATCH] k2_setup.c: remove k2_ide_init_hwif_ports()

It is not needed as it only duplicates ide_init_hwif_ports() functionality.

Cross-compile tested (well, it fails but not on k2_setup.o ;-)).

 linux-2.6.6-rc1-bk5-bzolnier/arch/ppc/platforms/k2_setup.c |   31 -------------
 1 files changed, 31 deletions(-)

diff -puN arch/ppc/platforms/k2_setup.c~ppc_k2_ide arch/ppc/platforms/k2_setup.c
--- linux-2.6.6-rc1-bk5/arch/ppc/platforms/k2_setup.c~ppc_k2_ide	2004-04-21 21:37:17.412110408 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/arch/ppc/platforms/k2_setup.c	2004-04-21 21:38:08.000000000 +0200
@@ -24,7 +24,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/ide.h>
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
@@ -52,31 +51,6 @@ static unsigned int cpu_6xx[16] = {
 	0, 0, 14, 0, 0, 13, 5, 9, 6, 11, 8, 10, 0, 12, 7, 0
 };
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-/* IDE functions */
-
-static void __init
-k2_ide_init_hwif_ports (hw_regs_t *hw, unsigned long data_port,
-		unsigned long ctrl_port, int *irq)
-{
-	unsigned long reg = data_port;
-	int i = 8;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port)
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	else
-		hw->io_ports[IDE_CONTROL_OFFSET] =
-			hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-
-	if (irq != NULL)
-		*irq = 0;
-}
-#endif
-
 static int
 k2_get_bus_speed(void)
 {
@@ -346,9 +320,4 @@ void __init platform_init(unsigned long 
 
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
-
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-	ppc_ide_md.ide_init_hwif = k2_ide_init_hwif_ports;
-#endif
 }
-

_

