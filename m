From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] asm-parisc/ide.h cleanup (there are no standard ports)
Date: Wed, 24 Mar 2004 14:43:43 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403241443.43206.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9127 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261624AbUC0Ilw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 03:41:52 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: parisc-linux@parisc-linux.org
Cc: linux-ide@vger.kernel.org


Hi,

Is this patch correct?

Regards,
Bartlomiej

 linux-2.6.5-rc2-bk3-root/include/asm-parisc/ide.h |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff -puN include/asm-parisc/ide.h~parisc_no_default_ide_ports include/asm-parisc/ide.h
--- linux-2.6.5-rc2-bk3/include/asm-parisc/ide.h~parisc_no_default_ide_ports	2004-03-24 14:39:06.293991064 +0100
+++ linux-2.6.5-rc2-bk3-root/include/asm-parisc/ide.h	2004-03-24 14:39:33.400870192 +0100
@@ -41,19 +41,8 @@ static __inline__ void ide_init_hwif_por
 	hw->io_ports[IDE_IRQ_OFFSET] = 0;
 }
 
-static __inline__ void ide_init_default_hwifs(void)
-{
-#ifndef CONFIG_PCI
-	hw_regs_t hw;
-	int index;
-
-	for(index = 0; index < MAX_HWIFS; index++) {
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
-		hw.irq = ide_default_irq(ide_default_io_base(index));
-		ide_register_hw(&hw);
-	}
-#endif
-}
+/* There are no standard ports. */
+static inline void ide_init_default_hwifs(void)	{ ; }
 
 #define ide_request_irq(irq,hand,flg,dev,id)	request_irq((irq),(hand),(flg),(dev),(id))
 #define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))

_

