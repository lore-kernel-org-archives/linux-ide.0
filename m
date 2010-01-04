From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 11:32:39 -0500
Message-ID: <4B421827.6050308@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>	<20091224215451.GA2476@flint.arm.linux.org.uk>	<20100103002314.GA16528@flint.arm.linux.org.uk>	<20100103234655.GB24920@flint.arm.linux.org.uk>	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>	<20100104133024.GA10521@flint.arm.linux.org.uk>	<4B420871.2090309@garzik.org> <20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:34093 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab0ADQcn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 11:32:43 -0500
Received: by gxk3 with SMTP id 3so2876065gxk.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 08:32:41 -0800 (PST)
In-Reply-To: <20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 10:46 AM, Alan Cox wrote:
>> Without AltStatus, you would not be able to check and see if a command
>> is complete...  pretty much by definition you should able to access that
>
> Correct - and you may not make that check for 400nS after the command is
> issued. The old IDE code enforces this (I know because I added it to fix
> real problems as PC's got fast enough to go from write to IRQ in 400nS)
>
>> It is certainly conceivable that this is a problem on a rare controller
>> or two, but in general, AltStatus is how you poll for DMA completion.
>> You are allowed to hit it during a DMA transfer.
>
> But not for 400nS after a command is issued, or on certain old
> controllers during a DMA transfer before you halt it.
>
>> HOWEVER, accessing AltStatus prior to the 400ns post-exec-command period
>> is potentially an area of undefined behavior.  Changing this code is
>> only a problem for MMIO-based controllers, which use the AltStatus read
>> to guarantee that the 400ns delay occurs outside any posted writes.
>
> Certainly for pio interfaces we should use ndelay(400). All our MMIO
> controllers are SATA and that's a different world anyway, including the
> fact that an altstatus read isn't going to produce a timing delay !
> Basically we know ndelay(400) works.

I think you misunderstood the "Changing this code..." sentence.  I make 
no claim, nor is there code, that says AltStatus produces the necessary 
400ns delay.

To rephrase/repeat, the AltStatus read in ata_sff_pause() exists to 
ensure that any previous posted MMIO writes -- most notably the taskfile 
registers we just wrote -- are flushed from CPU and PCI bridges etc. to 
the ATA host controller chip.

After the AltStatus read is executed, the delay is executed.  Here is 
the libata implementation, in its entirety:

	void ata_sff_pause(struct ata_port *ap)
	{
	        ata_sff_sync(ap); /* dummy AltStatus register read */
	        ndelay(400);
	}

On MMIO, you cannot guarantee that ndelay(400) occurs after the ATA 
Command register is written, without some method of ensuring that all 
posted writes are flushed.  Typically, this is done by a dummy register 
read of some worthless register -- AltStatus was used in this case.

Absent that, ndelay(400) could occur in _parallel_ with the posted 
taskfile writes, essentially eliminating the spec-required delay.

Thus,

(1a)  The solution for non-MMIO controllers is obvious and easy: remove 
the dummy AltStatus register read, as Russell has done in his test patch.

(1b)  The solution for MMIO controllers is a bit more complex:  replace 
the dummy AltStatus register read with something else.


> SIL680 is MMIO in the old IDE stack but the hardware appears to be doing
> the required magic itself.

You cannot draw such a conclusion from looking only at the SIL680 chip. 
   SIL680 might easily be behind a PCI bridge.

	Jeff


