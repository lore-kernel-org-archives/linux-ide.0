From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Date: Sun, 21 Jun 2009 15:15:56 +0200
Message-ID: <200906211515.56804.bzolnier@gmail.com>
References: <200906202352.33894.elendil@planet.nl> <20090620.171945.140676687.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:64350 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbZFUNKr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Jun 2009 09:10:47 -0400
In-Reply-To: <20090620.171945.140676687.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: elendil@planet.nl, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 21 June 2009 02:19:45 David Miller wrote:
> From: Frans Pop <elendil@planet.nl>
> Date: Sat, 20 Jun 2009 23:52:33 +0200
> 
> > ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 14 (serialized)
> > irq 14: nobody cared (try booting with the "irqpoll" option)
> > Call Trace:
> 
> Try reverting this patch:
> 
> commit 6b5cde3629701258004b94cde75dd1089b556b02
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date:   Mon Dec 29 20:27:32 2008 +0100
> 
>     cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
>     
>     * Set IDE_HFLAG_SERIALIZE explictly for CMD646.
>     
>     * Remove no longer needed ide_cmd646 chipset type (which has
>       a nice side-effect of fixing handling of unexpected IRQs).
>     
>     Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>     Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Great work Sherlock, Frans has found this already by himself.. ;)

> Unlike the commit log message states, I suspect this change
> "introduces" incorrect handling of unexpected IRQs rather than
> "fixing".  I suspect the problem arises when the controller

Please take a look at ide_intr() at the time of the commit:

1348         if ((handler = hwgroup->handler) == NULL || hwgroup->polling) {
1349                 /*
1350                  * Not expecting an interrupt from this drive.
1351                  * That means this could be:
1352                  *      (1) an interrupt from another PCI device
1353                  *      sharing the same PCI INT# as us.
1354                  * or   (2) a drive just entered sleep or standby mode,
1355                  *      and is interrupting to let us know.
1356                  * or   (3) a spurious interrupt of unknown origin.
1357                  *
1358                  * For PCI, we cannot tell the difference,
1359                  * so in that case we just ignore it and hope it goes away.
1360                  *
1361                  * FIXME: unexpected_intr should be hwif-> then we can
1362                  * remove all the ifdef PCI crap
1363                  */
1364 #ifdef CONFIG_BLK_DEV_IDEPCI
1365                 if (hwif->chipset != ide_pci)
1366 #endif  /* CONFIG_BLK_DEV_IDEPCI */

Before the patch hwif->chipset was set to ide_cmd646
and CONFIG_BLK_DEV_IDEPCI was always 'y'.

1367                 {
1368                         /*
1369                          * Probably not a shared PCI interrupt,
1370                          * so we can safely try to do something about it:
1371                          */
1372                         unexpected_intr(irq, hwgroup);
1373 #ifdef CONFIG_BLK_DEV_IDEPCI
1374                 } else {
1375                         /*
1376                          * Whack the status register, just in case
1377                          * we have a leftover pending IRQ.
1378                          */
1379                         (void)hwif->tp_ops->read_status(hwif);
1380 #endif /* CONFIG_BLK_DEV_IDEPCI */
1381                 }
1382                 goto out;
1383         }

> has a pending interrupt before the kernel boots, and after the
> reset the IDE layer now won't clear the thing properly due to
> the IDE_HFLAG_SERIALIZE now being set.

Because of hwif->chipset == ide_cmd646 IDE core has treated this
chipset as serialized one anyway:

init_irq():

1061                 if (h && h->hwgroup) {  /* scan only initialized ports */
1062                         if (hwif->irq == h->irq) {
1063                                 hwif->sharing_irq = h->sharing_irq = 1;
1064                                 if (hwif->chipset != ide_pci ||
1065                                     h->chipset != ide_pci) {
1066                                         save_match(hwif, h, &match);
1067                                 }
1068                         }

> I suspect the following logic in ide_intr() is being triggered:
> 
> 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
> 		if (hwif != host->cur_port)
> 			goto out_early;
> 	}
> 
> so the interrupt isn't cleared and it just keeps trying to run the
> interrupt handler over and over until the generic IRQ layer gives up
> and shuts off the interrupt.
> 
> This would make sense if the CMD64X chip reset code triggers the
> interrupt, because I see absolutely nothing the makes sure
> host->cur_port would be setup correctly to ensure that the interrupt
> got services in that case.

At the moment that we call request_irq() the first time both ports have
already been probed.  Since this includes reading device status there should
be no pending IRQs at this point.  IOW I think that this commit is just
a trigger for some other issue (which in turn was uncovered by rework of
handling of serialized interfaces).  Welcome in the wonderful land of broken
devices (we have a separate issue in this system -- ATAPI device returns
buggy ID block and since we added stricter checks we will need to workaround
it now to get DMA working), buggy controllers and no errata documentation.

> I wonder how much testing this commit received...

Too less, any help with improving testing coverage is welcomed
(this was just a tiny part of very large rework which has been tested
and has been sitting in linux-next for weeks before push to Linus).

> Actually... the patch doesn't revert cleanly.  Let me setup a
> patch to test by hand.  It just removes the IDE_HFLAG_SERIALIZE
> flag from the chipset array entry.

It would be worth to try it since IDE_HFLAG_SERIALIZE might be not needed
by CMD646 chipset.  It was suggested by mikpe & Sergei (IIRC) in the past
and pata_cmd64x.c has never used serialization (though this a worthless data
since initially libata didn't support serialization and some host drivers
still lack it when needed) but we couldn't get a definitive answer without
anybody testing the change.

[ The problem is that it can potentially cause a data corruption if we are
  wrong.  OTOH the worst thing that could happened with keeping it around was
  slower operation and (as discovered now) wrong handling of unexpected IRQs
  (so even slower operation). ]

> Alternatively you can try using the pata_cmd64x.c driver instead :-)

I fail to see how this is going to help with cmd64x.c testing coverage.. :(

The good news now -- the current Linus tree contains the patches from Sergei
adding support host-side testing/clearing of IRQs for hosts that support it
(this includes CMD64x ones) that should in the long-term give us a saner and
more reliable handling of shared and/or unexpected IRQs.

Frans, could you try also the current Linus tree + David's patch?

Thanks.
Bart
