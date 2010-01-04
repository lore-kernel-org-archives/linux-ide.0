From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 17:28:16 +0000
Message-ID: <20100104172816.GD18335@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <201001041731.35619.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40658 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab0ADR2a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:28:30 -0500
Content-Disposition: inline
In-Reply-To: <201001041731.35619.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 05:31:35PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Great debugging work!
> 
> It is very likely that your fix is also valid for UDMA problems reported
> for later PDC2026x UDMA66 chips and libata..

Possibly...

But, unrelated to this thread, I have a question for you.  While digging
through the changes to find out why drivers/ide broke on PDC20246, I
noticed dff8817.

This change is bogus.

        writeb(0, base + ICS_ARCIN_V6_INTROFFSET_1);
        readb(base + ICS_ARCIN_V6_INTROFFSET_2);

        writeb(0, base + ICS_ARCIN_V6_INTROFFSET_2);
        readb(base + ICS_ARCIN_V6_INTROFFSET_1);

This sequence of code does:

1. enable interrupt 1
2. disable interrupt 2
3. enable interrupt 2
4. disable interrupt 1

which results in the interrupt for the second channel being enabled -
leaving channel 1 blocked.

Firstly, icside shares its two IDE channels with one DMA engine - so it's
a simplex interface.  IDE supports those (or did when the code was written)
serializing requests between the two interfaces.  libata does not.

Secondly, the interrupt lines on icside float when there's no drive connected
or when the drive has its NIEN bit set, which means that you get spurious
screaming interrupts which can kill off all expansion card interrupts on
the machine unless you disable the channel interrupt on the card.

Since libata can not serialize the operation of the two channels like IDE
can, the libata version of the icside driver does not contain the interrupt
stearing logic.  Instead, it looks at the status after reset, and if
nothing was found on that channel, it masks the interrupt from that
channel.

In this respect, the IDE driver is more fully featured than the libata
driver - the IDE driver supports DMA on both channels, whereas the libata
version only supports DMA on one channel.

So, your change which was "inspired by pata_icside" is plain wrong.
Please revert it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
