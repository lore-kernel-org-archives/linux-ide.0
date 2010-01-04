From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 13:30:24 +0000
Message-ID: <20100104133024.GA10521@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33931 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0ADNai (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 08:30:38 -0500
Content-Disposition: inline
In-Reply-To: <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 10:37:56AM +0000, Alan Cox wrote:
> > 1. There is no way for the 247 to see any configuration settings;
> >    the only thing it can see are the taskfile reads and writes, and
> >    the timing of the DMA signals from the 246.
> > 
> > 2. The 246 timings for MWDMA2 and UDMA0 are identical; there is no
> >    programming difference between these two modes.  The only way the
> >    246 can know that UDMA is selected is by looking for the SET
> >    FEATURES command to the drive.
> 
> The 2026x certainly snoops SET FEATURES so that would be a reasonable
> assumption.
> 
> > I've tried changing the set xfermode code to use a version of
> > ata_exec_internal() which doesn't return the taskfile, but this makes no
> > difference to the promise exploding with CRC errors with UDMA writes.
> > Is it possible to do a similar thing with IDENTIFY?
> 
> No because you need to know if it worked.
> 
> > Also, is it possible to get rid of the additional identify and read native
> > max address commands which seem to be repeated (command register writes
> > listed):
> 
> You can turn off Host Protected Area support for this. You could also btw
> turn *on* host protected area for the IDE stack and see what occurs but I
> imagine its a red herring anyway. If the snoop is failing then it is more
> likely to be that the chip has some limitations on the taskfile snooping
> and perhaps requires that the device register is always written or that
> the registers are written in a specific order when writing the set
> features command.
> 
> Another thing to try if that fails is using a polled set features in case
> the chip has problems in that area. We've seen a similar bug on some older
> VIA devices.

Found the problem - getting rid of the read of the alt status register
after the command has been written fixes the UDMA CRC errors on write:

@@ -676,7 +676,8 @@ void ata_sff_exec_command(struct ata_port *ap, const struct
ata_taskfile *tf)
        DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);

        iowrite8(tf->command, ap->ioaddr.command_addr);
-       ata_sff_pause(ap);
+       ndelay(400);
+//     ata_sff_pause(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_exec_command);


This rather makes sense.  The PDC20247 handles the UDMA part of the
protocol.  It has no way to tell the PDC20246 to wait while it suspends
UDMA, so that a normal register access can take place - the 246 ploughs
on with the register access without any regard to the state of the 247.

If the drive immediately starts the UDMA protocol after a write to the
command register (as it probably will for the DMA WRITE command), then
we'll be accessing the taskfile in the middle of the UDMA setup, which
can't be good.  It's certainly a violation of the ATA specs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
