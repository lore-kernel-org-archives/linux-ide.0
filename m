From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 15:46:07 +0000
Message-ID: <20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<4B420871.2090309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47127 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752909Ab0ADPmo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 10:42:44 -0500
In-Reply-To: <4B420871.2090309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

> Without AltStatus, you would not be able to check and see if a command 
> is complete...  pretty much by definition you should able to access that 

Correct - and you may not make that check for 400nS after the command is
issued. The old IDE code enforces this (I know because I added it to fix
real problems as PC's got fast enough to go from write to IRQ in 400nS)

> It is certainly conceivable that this is a problem on a rare controller 
> or two, but in general, AltStatus is how you poll for DMA completion. 
> You are allowed to hit it during a DMA transfer.

But not for 400nS after a command is issued, or on certain old
controllers during a DMA transfer before you halt it.

> HOWEVER, accessing AltStatus prior to the 400ns post-exec-command period 
> is potentially an area of undefined behavior.  Changing this code is 
> only a problem for MMIO-based controllers, which use the AltStatus read 
> to guarantee that the 400ns delay occurs outside any posted writes.

Certainly for pio interfaces we should use ndelay(400). All our MMIO
controllers are SATA and that's a different world anyway, including the
fact that an altstatus read isn't going to produce a timing delay !
Basically we know ndelay(400) works.

SIL680 is MMIO in the old IDE stack but the hardware appears to be doing
the required magic itself. In fact as it can stack two commands in non
LBA48 mode (a feature we don't use) it would seem to have a fairly
complete internal state machine.

Alan
