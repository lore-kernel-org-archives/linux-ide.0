From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 15:42:13 +0000
Message-ID: <20100104154212.GA18335@flint.arm.linux.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B420871.2090309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44343 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0ADPm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 10:42:27 -0500
Content-Disposition: inline
In-Reply-To: <4B420871.2090309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 10:25:37AM -0500, Jeff Garzik wrote:
> On 01/04/2010 08:30 AM, Russell King wrote:
>> This rather makes sense.  The PDC20247 handles the UDMA part of the
>> protocol.  It has no way to tell the PDC20246 to wait while it suspends
>> UDMA, so that a normal register access can take place - the 246 ploughs
>> on with the register access without any regard to the state of the 247.
>>
>> If the drive immediately starts the UDMA protocol after a write to the
>> command register (as it probably will for the DMA WRITE command), then
>> we'll be accessing the taskfile in the middle of the UDMA setup, which
>> can't be good.  It's certainly a violation of the ATA specs.
>
> Well...
>
> Without AltStatus, you would not be able to check and see if a command  
> is complete...

I wasn't inferring that reading altstatus was a bad idea.  I was saying
that causing altstatus to be read in the middle of an active UDMA
transfer (in other words, while the hosts DMACK is active) is a
violation of the spec.

There's no way for the 20247 (UDMA add-on) to know that the IO access
is coming; the first the 247 knows about it is when the CS/address lines
to the drive have been activated - in violation of the ATA specification
(which calls for the CS lines to be inactive and address lines to be zero
while UDMA is occuring.)

That means there's absolutely no way for the 20247 to stop the UDMA
protocol to allow a read of any registers on the drive until UDMA has
completed.

Yes, technically a buggy host design...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
