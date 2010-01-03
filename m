From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Sun, 3 Jan 2010 23:46:56 +0000
Message-ID: <20100103234655.GB24920@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54269 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab0ACXrG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jan 2010 18:47:06 -0500
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1NRa9z-0007GV-0P
	for linux-ide@vger.kernel.org; Sun, 03 Jan 2010 23:46:59 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1NRa9w-0002RH-Ox
	for linux-ide@vger.kernel.org; Sun, 03 Jan 2010 23:46:56 +0000
Content-Disposition: inline
In-Reply-To: <20100103002314.GA16528@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Sun, Jan 03, 2010 at 12:23:14AM +0000, Russell King wrote:
> Okay, things have moved on, but not very much.
> 
> I've pulled the card out of the ARM machine, and its now in an x86
> desktop, where, with 2.6.33-rc2 it behaves in exactly the same way.
> That is:
> 
> - with libata
>   - UDMA reads work fine, every time.
>   - UDMA writes always fail with a CRC error.
> 
>   Note: there appears to be an additional libata bug here: when the
>   speed gets knocked down to PIO mode, the block IO request is failed
>   with *no* PIO retries.  Subsequent IO requests succeed.  This means
>   that if you're using MD raid, your drive unnecessarily gets marked
>   as failed - not nice when things are actually still operational,
>   which can be seen by the other MD raid partitions on the drive
>   behaving just fine in PIO mode.
> 
>   An additional note: it seems that libata reads the ATA taskfile
>   back from the drive on every command completion, successful or not -
>   there are at least 30 IO accesses between any two ATA commands.
>   Is there any reason for that?

Now that the old IDE driver is working, comparing 2.6.33-rc2 setup.
Timing registers are at 0x60, each of 32-bits for primary master, slave,
secondary master, slave.  As can be seen, the setup is identical, so it's
not a card configuration issue.

ATA:
00: 5a 10 33 4d 07 00 00 02 01 00 04 01 00 20 00 00
10: 01 bc 00 00 05 b8 00 00 01 b4 00 00 05 b0 00 00
20: 01 ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 0f ff 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: ee 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: f1 24 41 00 c9 f3 4f 00 f1 24 41 00 c9 f3 4f 00

IDE:
00: 5a 10 33 4d 07 00 00 02 01 00 04 01 00 20 00 00
10: 01 bc 00 00 05 b8 00 00 01 b4 00 00 05 b0 00 00
20: 01 ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 0f ff 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: ee 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: f1 24 41 00 c4 f3 4f 00 f1 24 41 00 c4 f3 4f 00

The system control register is almost same - ATA 01d2110c vs 01da110c.
Programming it to the value it has under ATA doesn't cause any ill
effects with IDE.

This leaves one thing - the way the ATA taskfile is accessed.  Those
who don't know the Promise Ultra33 hardware, it consists of two devices -
the PDC20246, which is a PIO/SWDMA/MWDMA host, and a PDC20247 add-on,
which partly sits between the host and the drives providing the UDMA
protocol.  The 247 intercepts INTRQ, DIOR, DIOW, IORDY, DMARQ, DMACK
and DD0:15 signals, but monitors the DA0:2 and two CS signals to the
drive.

The documentation doesn't specify how the 247 works, except specifying
that it has a UDMA mode and a pass-through mode.  However, we can make
some assumptions from the wiring:

1. There is no way for the 247 to see any configuration settings;
   the only thing it can see are the taskfile reads and writes, and
   the timing of the DMA signals from the 246.

2. The 246 timings for MWDMA2 and UDMA0 are identical; there is no
   programming difference between these two modes.  The only way the
   246 can know that UDMA is selected is by looking for the SET
   FEATURES command to the drive.

So, taking all this together, I'm now down to the way libata drives the
ATA task file, which seems to be *extremely* noisy.  What is the best
way to cut down that noise, down to the bare minimum that's actually
required, while still keeping compatibility for my ICH5 SATA controller
(which I need for my x86 machine's boot drive.)

I've tried changing the set xfermode code to use a version of
ata_exec_internal() which doesn't return the taskfile, but this makes no
difference to the promise exploding with CRC errors with UDMA writes.
Is it possible to do a similar thing with IDENTIFY?

Also, is it possible to get rid of the additional identify and read native
max address commands which seem to be repeated (command register writes
listed):

iowrite8(ec, 0001b407)	identify
iowrite8(f8, 0001b407)	read native max
iowrite8(ef, 0001b407)	set features
iowrite8(ec, 0001b407)	identify
iowrite8(f8, 0001b407)	read native max
iowrite8(c8, 0001b407)	read dma, succeeds
iowrite8(c8, 0001b407)
...
iowrite8(c8, 0001b407)
repeat {
iowrite8(ca, 0001b407)	write dma, fails
iowrite8(ec, 0001b407)	identify
iowrite8(f8, 0001b407)	read native max
iowrite8(ef, 0001b407)	set features
iowrite8(ec, 0001b407)	identify
iowrite8(f8, 0001b407)	read native max
} until PIO

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
