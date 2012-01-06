From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH v2] pata_bf54x: fix BMIDE status register emulation
Date: Fri, 6 Jan 2012 20:45:45 +0300
Message-ID: <201201062045.45250.sshtylyov@ru.mvista.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:54473 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751022Ab2AFQqw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2012 11:46:52 -0500
In-Reply-To: <201112281836.45834.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: sonic.zhang@analog.com

The author of this driver clearly wasn't familiar with the BMIDE specification
(also known as SFF-8038i) when he implemented the bmdma_status() method: first,
the interrupt bit of the BMIDE status register corresponds to nothing else but
INTRQ signal (ATAPI_DEV_INT here); second, the error bit is only set if the
controller encounters issue doing the bus master transfers, not on the IDE DMA
burst termination interrupts like here (moreover, setting the error bit doesn't
cause an interrupt).  We now need to disable all those unused interrupts...

(The only thing I couldn't figure out is how to flush the FIFO to memory once
the interrupt happens as required by the mentioned spec.)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

 drivers/ata/pata_bf54x.c |   20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ata/pata_bf54x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_bf54x.c
+++ linux-2.6/drivers/ata/pata_bf54x.c
@@ -418,14 +418,6 @@ static void bfin_set_dmamode(struct ata_
 					(tcyc_tdvs<<8 | tdvs));
 				ATAPI_SET_ULTRA_TIM_2(base, (tmli<<8 | tss));
 				ATAPI_SET_ULTRA_TIM_3(base, (trp<<8 | tzah));
-
-				/* Enable host ATAPI Untra DMA interrupts */
-				ATAPI_SET_INT_MASK(base,
-					ATAPI_GET_INT_MASK(base)
-					| UDMAIN_DONE_MASK
-					| UDMAOUT_DONE_MASK
-					| UDMAIN_TERM_MASK
-					| UDMAOUT_TERM_MASK);
 			}
 		}
 	}
@@ -470,10 +462,6 @@ static void bfin_set_dmamode(struct ata_
 			ATAPI_SET_MULTI_TIM_0(base, (tm<<8 | td));
 			ATAPI_SET_MULTI_TIM_1(base, (tkr<<8 | tkw));
 			ATAPI_SET_MULTI_TIM_2(base, (teoc<<8 | th));
-
-			/* Enable host ATAPI Multi DMA interrupts */
-			ATAPI_SET_INT_MASK(base, ATAPI_GET_INT_MASK(base)
-				| MULTI_DONE_MASK | MULTI_TERM_MASK);
 			SSYNC();
 		}
 	}
@@ -1153,15 +1141,11 @@ static unsigned char bfin_bmdma_status(s
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
 
