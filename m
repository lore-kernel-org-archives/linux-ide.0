From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: ide-dma: fix ide_build_dmatable() for TRM290
Date: Sun, 28 Sep 2008 22:41:26 +0400
Message-ID: <200809282241.26289.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:52662 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752096AbYI1Ska (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 14:40:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Apparently, 'xcount' being 0 does not mean 0 bytes for TRM290; it means 4 bytes,
judging from the code immediately preceding this check.  So, we must never try
to "split" the PRD for TRM290.

This is probably never hit anyway -- with the DMA buffers aligned to at least
512 bytes and ATAPI DMA not being used for non block I/O commands...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.
                                          
 drivers/ide/ide-dma.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -211,7 +211,7 @@ int ide_build_dmatable (ide_drive_t *dri
 				xcount = bcount & 0xffff;
 				if (is_trm290)
 					xcount = ((xcount >> 2) - 1) << 16;
-				if (xcount == 0x0000) {
+				else if (xcount == 0x0000) {
 	/* 
 	 * Most chipsets correctly interpret a length of 0x0000 as 64KB,
 	 * but at least one (e.g. CS5530) misinterprets it as zero (!).

