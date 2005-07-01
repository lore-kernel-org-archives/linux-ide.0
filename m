From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/ide/Makefile: kill dead CONFIG_BLK_DEV_IDE_TCQ entry
Date: Sat, 2 Jul 2005 00:54:42 +0200
Message-ID: <20050701225442.GB3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15889 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261415AbVGAWyn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Jul 2005 18:54:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This patch kills the dead CONFIG_BLK_DEV_IDE_TCQ entry.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/drivers/ide/Makefile.old	2005-07-01 00:46:38.000000000 +0200
+++ linux-2.6.12-mm2-full/drivers/ide/Makefile	2005-07-01 00:46:45.000000000 +0200
@@ -20,7 +20,6 @@
 # Core IDE code - must come before legacy
 ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
 ide-core-$(CONFIG_BLK_DEV_IDEDMA)	+= ide-dma.o
-ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
 ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
 ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
 

