From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Sun, 3 Jan 2010 10:05:45 +0000
Message-ID: <20100103100545.GA26225@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <4B400A10.3000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53674 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0ACKGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jan 2010 05:06:06 -0500
Content-Disposition: inline
In-Reply-To: <4B400A10.3000103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Jan 02, 2010 at 09:08:00PM -0600, Robert Hancock wrote:
> libata doesn't attempt any retries internally, that's up to the upper  
> layers. If they're marking the array as failed after one failed request  
> without any retries, that's presumably either intentional or a bug in  
> the MD layer..

Why should MD care?  All that MD knows is that the IO request failed,
it isn't told why.  If a request fails, then it has to assume disk
failure.

Maybe it's not a libata problem, but it _is_ bad system behaviour that
needs to be resolved in some way.

However, it's only libata which knows that a UDMA CRC error can't happen
with PIO.  If its getting UDMA CRC errors, backing the speed down
eventually to PIO is guaranteed to fix it.  The SCSI layer can't know
this, and shouldn't know this.  The MD layer certainly doesn't get to
know why requests are failing, nor can it know about these kinds of
interface behaviour, so it can't be fixed there.  That only leaves libata
which knows this, knows what's happening and knows how to fix it.

>>    An additional note: it seems that libata reads the ATA taskfile
>>    back from the drive on every command completion, successful or not -
>>    there are at least 30 IO accesses between any two ATA commands.
>>    Is there any reason for that?
>
> It shouldn't be reading the entire taskfile back after completion unless  
> it failed or it's marked as requiring result taskfile (ATA passthru  
> commands or internal commands, i.e. during probing). You're seeing this  
> on normal read/write commands?

Hmm, yes, you're right.  For normal DMA read/write commands which are
successful, no readback occurs.  However, it appears for non-data and
PIO commands during probe/error recovery - eg, this is what the accesses
for a set features, xfer mode command looks like:

ioread8(0001b407) = 50		read status
iowrite8(a0, 0001b406)		write drive
ioread8(0001b006) = 50		read alt status
ioread8(0001b407) = 50		read status
iowrite8(0a, 0001b006)		write ctrl
ioread8(0001b407) = 50		read status
iowrite8(03, 0001b401)		write taskfile
iowrite8(42, 0001b402)
iowrite8(00, 0001b403)
iowrite8(00, 0001b404)
iowrite8(00, 0001b405)
iowrite8(a0, 0001b406)
ioread8(0001b407) = 50		read status
iowrite8(ef, 0001b407)		write command
ioread8(0001b006) = d0		read altstatus
ioread8(0001b407) = d0		poll status
ioread8(0001b407) = d0
ioread8(0001b407) = d0
ioread8(0001b407) = d0
ioread8(0001b407) = d0
ioread8(0001b407) = 50
iowrite8(08, 0001b006)		write ctrl
ioread8(0001b407) = 50		read status
ioread8(0001ac0a) = 60		read sff dma status
iowrite8(60, 0001ac0a)		write sff dma status
ioread8(0001ac0a) = 60		read sff dma status
ioread8(0001b407) = 50		read status
ioread8(0001b401) = 00		read taskfile
ioread8(0001b402) = 42
ioread8(0001b403) = 00
ioread8(0001b404) = 00
ioread8(0001b405) = 00
ioread8(0001b406) = a0
ioread8(0001ac08) = 00		read sff dma control
iowrite8(00, 0001ac08)		write sff dma control
ioread8(0001ac08) = 00		read sff dma control

Identify (ec) gets the same treatment.  I don't have a trace for a PIO
read/write to hand at the moment to check what their behaviour is, but
I suspect the same on the grounds that I didn't notice a "please read
back the taskfile" flag being set for the set features command.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
