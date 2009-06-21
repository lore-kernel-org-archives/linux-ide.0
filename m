From: David Miller <davem@davemloft.net>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sat, 20 Jun 2009 17:19:45 -0700 (PDT)
Message-ID: <20090620.171945.140676687.davem@davemloft.net>
References: <200906202352.33894.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <200906202352.33894.elendil@planet.nl>
Sender: sparclinux-owner@vger.kernel.org
To: elendil@planet.nl
Cc: sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Sat, 20 Jun 2009 23:52:33 +0200

> ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14 (serialized)
> irq 14: nobody cared (try booting with the "irqpoll" option)
> Call Trace:

Try reverting this patch:

commit 6b5cde3629701258004b94cde75dd1089b556b02
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Mon Dec 29 20:27:32 2008 +0100

    cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
    
    * Set IDE_HFLAG_SERIALIZE explictly for CMD646.
    
    * Remove no longer needed ide_cmd646 chipset type (which has
      a nice side-effect of fixing handling of unexpected IRQs).
    
    Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Unlike the commit log message states, I suspect this change
"introduces" incorrect handling of unexpected IRQs rather than
"fixing".  I suspect the problem arises when the controller
has a pending interrupt before the kernel boots, and after the
reset the IDE layer now won't clear the thing properly due to
the IDE_HFLAG_SERIALIZE now being set.

I suspect the following logic in ide_intr() is being triggered:

	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
		if (hwif != host->cur_port)
			goto out_early;
	}

so the interrupt isn't cleared and it just keeps trying to run the
interrupt handler over and over until the generic IRQ layer gives up
and shuts off the interrupt.

This would make sense if the CMD64X chip reset code triggers the
interrupt, because I see absolutely nothing the makes sure
host->cur_port would be setup correctly to ensure that the interrupt
got services in that case.

I wonder how much testing this commit received...

Actually... the patch doesn't revert cleanly.  Let me setup a
patch to test by hand.  It just removes the IDE_HFLAG_SERIALIZE
flag from the chipset array entry.

Alternatively you can try using the pata_cmd64x.c driver instead :-)

diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index 80b777e..f98ba24 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -425,8 +425,7 @@ static const struct ide_port_info cmd64x_chipsets[] __devinitdata = {
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.port_ops	= &cmd64x_port_ops,
 		.dma_ops	= &cmd648_dma_ops,
-		.host_flags	= IDE_HFLAG_SERIALIZE |
-				  IDE_HFLAG_ABUSE_PREFETCH,
+		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
