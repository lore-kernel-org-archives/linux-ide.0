From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] obsolete asm/hdreg.h [4/5]
Date: Thu, 8 Apr 2004 00:23:35 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404080023.35285.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49638 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261262AbUDGXyG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Apr 2004 19:54:06 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org


[IDE] asm-ia64/ide.h: use unsigned long instead of ide_ioreg_t

 linux-2.6.5-root/include/asm-ia64/ide.h |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff -puN include/asm-ia64/ide.h~ia64_ide_ioreg_t include/asm-ia64/ide.h
--- linux-2.6.5/include/asm-ia64/ide.h~ia64_ide_ioreg_t	2004-04-06 14:21:09.569520960 +0200
+++ linux-2.6.5-root/include/asm-ia64/ide.h	2004-04-06 14:23:48.618341864 +0200
@@ -25,8 +25,7 @@
 # endif
 #endif
 
-static __inline__ int
-ide_default_irq (ide_ioreg_t base)
+static inline int ide_default_irq(unsigned long base)
 {
 	switch (base) {
 	      case 0x1f0: return isa_irq_to_vector(14);
@@ -40,8 +39,7 @@ ide_default_irq (ide_ioreg_t base)
 	}
 }
 
-static __inline__ ide_ioreg_t
-ide_default_io_base (int index)
+static inline unsigned long ide_default_io_base(int index)
 {
 	switch (index) {
 	      case 0: return 0x1f0;
@@ -55,10 +53,10 @@ ide_default_io_base (int index)
 	}
 }
 
-static __inline__ void
-ide_init_hwif_ports (hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq)
+static inline void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
+				       unsigned long ctrl_port, int *irq)
 {
-	ide_ioreg_t reg = data_port;
+	unsigned long reg = data_port;
 	int i;
 
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {

_

