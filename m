From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-sff: Fix documentation
Date: Thu, 20 Sep 2007 15:03:07 +0100
Message-ID: <20070920150307.6b89238b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56575 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751056AbXITN40 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 09:56:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Code moved to ioread/iowrite but the comment didn't
Also note a posting issue

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/libata-sff.c linux-2.6.23rc6-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/libata-sff.c	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/libata-sff.c	2007-09-18 16:18:05.000000000 +0100
@@ -257,7 +261,7 @@
 	dmactl = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 	iowrite8(dmactl | ATA_DMA_START, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
-	/* Strictly, one may wish to issue a readb() here, to
+	/* Strictly, one may wish to issue an ioread8() here, to
 	 * flush the mmio write.  However, control also passes
 	 * to the hardware at this point, and it will interrupt
 	 * us when we are to resume control.  So, in effect,
@@ -267,6 +271,9 @@
 	 * is expected, so I think it is best to not add a readb()
 	 * without first all the MMIO ATA cards/mobos.
 	 * Or maybe I'm just being paranoid.
+	 *
+	 * FIXME: The posting of this write means I/O starts are
+	 * unneccessarily delayed for MMIO
 	 */
 }
 
