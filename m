From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 17:46:52 +0000
Message-ID: <20100104174652.GF18335@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <201001041731.35619.bzolnier@gmail.com> <20100104172816.GD18335@flint.arm.linux.org.uk> <20100104173958.28439d63@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37973 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab0ADRrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:47:08 -0500
Content-Disposition: inline
In-Reply-To: <20100104173958.28439d63@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 05:39:58PM +0000, Alan Cox wrote:
> > Firstly, icside shares its two IDE channels with one DMA engine - so it's
> > a simplex interface.  IDE supports those (or did when the code was written)
> > serializing requests between the two interfaces.  libata does not.
> 
> Libata does the driver may not.

libata certainly didn't when I wrote the driver in 2007.

int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev)
{
        /* Record simplex status. If we selected DMA then the other
         * host channels are not permitted to do so.
         */
        if (used_dma && (ap->host->flags & ATA_HOST_SIMPLEX))
                ap->host->simplex_claimed = ap;
...
static void ata_dev_xfermask(struct ata_device *dev)
{
...
        if ((host->flags & ATA_HOST_SIMPLEX) &&
            host->simplex_claimed && host->simplex_claimed != ap) {
                xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
                ata_dev_printk(dev, KERN_WARNING, "simplex DMA is claimed by "
                               "other device, disabling DMA\n");
        }

and apparantly still doesn't.  Only one channel of a simplex device is
permitted to be configured for DMA at any one time.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
