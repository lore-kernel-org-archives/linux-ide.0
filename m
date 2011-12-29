From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Thu, 29 Dec 2011 06:31:04 -0500
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16D768609F8@NWD2CMBX1.ad.analog.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:8304
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753422Ab1L2La7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Dec 2011 06:30:59 -0500
In-Reply-To: <201112281836.45834.sshtylyov@ru.mvista.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>


SG list was not implemented in pata_bf54x driver from the beginning, because ATAPI controller on BF54x support maximum 131070 bytes in one BMDMA transfer. The size in sg list buffers may exceeds this limitation easily. Do you know a way to set the maximum total buffer size in a sg list?


Static struct scsi_host_template bfin_sht = {
        ATA_BASE_SHT(DRV_NAME),
        .sg_tablesize                   = SG_NONE,
        .dma_boundary           = ATA_DMA_BOUNDARY,
};


Sonic

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
Sent: Wednesday, December 28, 2011 11:37 PM
To: linux-ide@vger.kernel.org; jgarzik@pobox.com; Zhang, Sonic
Subject: [PATCH] pata_bf54x: fix BMIDE status register emulation

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
-       unsigned short int_status = ATAPI_GET_INT_STATUS(base);

-       if (ATAPI_GET_STATUS(base) & (MULTI_XFER_ON|ULTRA_XFER_ON))
+       if (ATAPI_GET_STATUS(base) & (MULTI_XFER_ON | ULTRA_XFER_ON))
                host_stat |= ATA_DMA_ACTIVE;
-       if (int_status & (MULTI_DONE_INT|UDMAIN_DONE_INT|UDMAOUT_DONE_INT|
-               ATAPI_DEV_INT))
+       if (ATAPI_GET_INT_STATUS(base) & ATAPI_DEV_INT)
                host_stat |= ATA_DMA_INTR;
-       if (int_status & (MULTI_TERM_INT|UDMAIN_TERM_INT|UDMAOUT_TERM_INT))
-               host_stat |= ATA_DMA_ERR|ATA_DMA_INTR;

        dev_dbg(ap->dev, "ATAPI: host_stat=0x%x\n", host_stat);



