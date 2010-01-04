From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 18:20:36 +0000
Message-ID: <20100104182036.6622ba32@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<201001041731.35619.bzolnier@gmail.com>
	<20100104172816.GD18335@flint.arm.linux.org.uk>
	<20100104173958.28439d63@lxorguk.ukuu.org.uk>
	<20100104174652.GF18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37000 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752414Ab0ADSRL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 13:17:11 -0500
In-Reply-To: <20100104174652.GF18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


> libata certainly didn't when I wrote the driver in 2007.
> 
> int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
> {
>         /* Record simplex status. If we selected DMA then the other
>          * host channels are not permitted to do so.
>          */
>         if (used_dma && (ap->host->flags & ATA_HOST_SIMPLEX))
>                 ap->host->simplex_claimed = ap;
> ...
> static void ata_dev_xfermask(struct ata_device *dev)
> {
> ...
>         if ((host->flags & ATA_HOST_SIMPLEX) &&
>             host->simplex_claimed && host->simplex_claimed != ap) {
>                 xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>                 ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
>                                "other device, disabling DMA\n");
>         }
> 
> and apparantly still doesn't.  Only one channel of a simplex device is
> permitted to be configured for DMA at any one time.

Simplex has a specific meaning and we implement it to the meaning of the
standard PCI config bits, which is that you have a single channel that can
be configured for DMA. There is nothing in the standard that says you can
play fast and loose flipping them back and forth.

If your controller simply can't handle two DMA transactions (or two
transactions in general) at the same time you can provide a private
qc_defer function and ask the midlayer to defer commands that don't fit
your needs.

Ie the simplex handling is like the Simplex bit handling in drivers/ide,
and the qc_defer method is akin to the ->serialize flag in drivers/ide,
but a bit more flexible.

Alan
