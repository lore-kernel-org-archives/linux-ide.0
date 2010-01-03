From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Sun, 3 Jan 2010 00:23:14 +0000
Message-ID: <20100103002314.GA16528@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36556 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab0ACAX0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jan 2010 19:23:26 -0500
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1NREFZ-0006IJ-TG
	for linux-ide@vger.kernel.org; Sun, 03 Jan 2010 00:23:18 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1NREFX-0005V1-K1
	for linux-ide@vger.kernel.org; Sun, 03 Jan 2010 00:23:15 +0000
Content-Disposition: inline
In-Reply-To: <20091224215451.GA2476@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Okay, things have moved on, but not very much.

I've pulled the card out of the ARM machine, and its now in an x86
desktop, where, with 2.6.33-rc2 it behaves in exactly the same way.
That is:

- with libata
  - UDMA reads work fine, every time.
  - UDMA writes always fail with a CRC error.

  Note: there appears to be an additional libata bug here: when the
  speed gets knocked down to PIO mode, the block IO request is failed
  with *no* PIO retries.  Subsequent IO requests succeed.  This means
  that if you're using MD raid, your drive unnecessarily gets marked
  as failed - not nice when things are actually still operational,
  which can be seen by the other MD raid partitions on the drive
  behaving just fine in PIO mode.

  An additional note: it seems that libata reads the ATA taskfile
  back from the drive on every command completion, successful or not -
  there are at least 30 IO accesses between any two ATA commands.
  Is there any reason for that?

- with IDE
  - locks the interrupt line, and makes the machine extremely painful -
    about an hour to get to the point of being able to unload the
    pdc202xx_old module.

Having spent a lot of time today looking at the ATA drive, SFF DMA,
promise IO configuration and PCI configuration registers, I can't see
anything obviously wrong.

Nevertheless, the fact is that this card does work with previous kernels
just fine, and continues to work if I boot back to old kernels.  So,
there is something going on which the old kernels do, which makes this
card behave.

I'm going to drop investigation of libata for the time being, and
possibly switch to the old IDE driver to find out why its getting a
stuck PCI interrupt.  Once the old IDE stuff works again, I'll be able
to compare the differences between libata and IDE.

On Thu, Dec 24, 2009 at 09:54:51PM +0000, Russell King wrote:
> Some additions due to further testing:
> 
> On Thu, Dec 24, 2009 at 06:13:00PM +0000, Russell King wrote:
> > I tried upgrading my main machine from an old 2.6.23 kernel to 2.6.32.
> > In doing so, I switched from IDE to ATA support.
> 
> IDE on 2.6.32 results in "irq 24: nobody cared" for the IDE interrupt.
> Booting back to 2.6.23 results in everything working normally again.
> 
> > Could this be another case where the kernel should always need to write
> > out the full task file to the drive?  I don't see any form of hardware
> > control on the PDC20247 (which is the UDMA add-on to the PDC20246 chip)
> > to control its mode, other than it snooping the taskfile writes.
> 
> I tried commenting out the caching of the drive control register:
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index bbbb1fa..ddd275a 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -574,12 +574,12 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
>  
> -	if (tf->ctl != ap->last_ctl) {
> +//	if (tf->ctl != ap->last_ctl) {
>  		if (ioaddr->ctl_addr)
>  			iowrite8(tf->ctl, ioaddr->ctl_addr);
>  		ap->last_ctl = tf->ctl;
>  		ata_wait_idle(ap);
> -	}
> +//	}
>  
>  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
>  		WARN_ON_ONCE(!ioaddr->ctl_addr);
> 
> This resulted in the same failure, but without the 'timeout' for the
> second drive.  So there seems to be a separate problem in that when
> the Promise host gets reset, the host state isn't properly updated on
> all channels, resulting in the drive control register not being
> written for the 'other' channel.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
