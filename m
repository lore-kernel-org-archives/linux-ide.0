From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Wed, 28 Dec 2011 18:36:45 +0300
Message-ID: <201112281836.45834.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:56462 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753936Ab1L1Ohv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Dec 2011 09:37:51 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com, sonic.zhang@analog.com

The author of this driver clearly wasn't familiar with the BMIDE specification
(also known as SFF-8038i) when he implemented the bmdma_status() method: first,
the interrupt bit of the BMIDE status register corresponds to nothing else but
INTRQ signal (ATAPI_DEV_INT here); second, the error bit is only set if the
controller encounters issue doing the bus master transfers, not on the DMA burst
termination interrupts like here (moreover, setting the error bit doesn't cause
an interrupt).

(The only thing I couldn't figure out is how to flush the FIFO to memory once
the interrupt happens as required by the mentioned spec.)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree.
Sonic, if you still work in Analog Devices, please give this a try.

I looked over the driver, and it left pretty bad impression. In particular,
I highly doubt that the transfers with more than one S/G item can work. And
this is after the driver has been in the kernel for 4 years already...
Unfortunately, I have neither hardware nor much time to work on improving it...

 drivers/ata/pata_bf54x.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/ata/pata_bf54x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_bf54x.c
+++ linux-2.6/drivers/ata/pata_bf54x.c
@@ -1153,15 +1153,11 @@ static unsigned char bfin_bmdma_status(s
 {
 	unsigned char host_stat = 0;
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
-	unsigned short int_status = ATAPI_GET_INT_STATUS(base);
 
-	if (ATAPI_GET_STATUS(base) & (MULTI_XFER_ON|ULTRA_XFER_ON))
+	if (ATAPI_GET_STATUS(base) & (MULTI_XFER_ON | ULTRA_XFER_ON))
 		host_stat |= ATA_DMA_ACTIVE;
-	if (int_status & (MULTI_DONE_INT|UDMAIN_DONE_INT|UDMAOUT_DONE_INT|
-		ATAPI_DEV_INT))
+	if (ATAPI_GET_INT_STATUS(base) & ATAPI_DEV_INT)
 		host_stat |= ATA_DMA_INTR;
-	if (int_status & (MULTI_TERM_INT|UDMAIN_TERM_INT|UDMAOUT_TERM_INT))
-		host_stat |= ATA_DMA_ERR|ATA_DMA_INTR;
 
 	dev_dbg(ap->dev, "ATAPI: host_stat=0x%x\n", host_stat);
 
