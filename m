From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/3] sgiioc4: remove maskproc() method
Date: Wed, 15 Oct 2008 00:24:13 +0400
Message-ID: <200810150024.13958.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:62403 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754748AbYJNUY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 16:24:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

Since the maskproc() method calls either mirror the interrupt en/disable via
the nIEN bit of the device control register done by the IDE core before issuing
a command or unmask the interrupt after a command executed in polled mode (when
interrupt is already not expected), it is pointless to implement this method
by manipulating the nIEN bit...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent pata-2.6 series...
Phew, these 3 patches have been around since July -- sending out at last...

 drivers/ide/pci/sgiioc4.c |    9 ---------
 1 files changed, 9 deletions(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -107,13 +107,6 @@ sgiioc4_init_hwif_ports(hw_regs_t * hw, 
 		hw->io_ports.irq_addr = irq_port;
 }
 
-static void
-sgiioc4_maskproc(ide_drive_t * drive, int mask)
-{
-	writeb(ATA_DEVCTL_OBS | (mask ? 2 : 0),
-	       (void __iomem *)drive->hwif->io_ports.ctl_addr);
-}
-
 static int
 sgiioc4_checkirq(ide_hwif_t * hwif)
 {
@@ -567,8 +560,6 @@ static const struct ide_port_ops sgiioc4
 	.set_dma_mode		= sgiioc4_set_dma_mode,
 	/* reset DMA engine, clear IRQs */
 	.resetproc		= sgiioc4_resetproc,
-	/* mask on/off NIEN register */
-	.maskproc		= sgiioc4_maskproc,
 };
 
 static const struct ide_dma_ops sgiioc4_dma_ops = {

