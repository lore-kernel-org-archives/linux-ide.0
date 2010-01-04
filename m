From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 17:02:36 +0000
Message-ID: <20100104170236.5d85959f@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<4B420871.2090309@garzik.org>
	<20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>
	<4B421827.6050308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58426 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752235Ab0ADQ7M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 11:59:12 -0500
In-Reply-To: <4B421827.6050308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

> (1b)  The solution for MMIO controllers is a bit more complex:  replace 
> the dummy AltStatus register read with something else.

If we had any SFF PATA controllers using MMIO. I can't find any. SATA is
different anyway. In fact we probably want to avoid such delays on a pure
SATA controller.

> > SIL680 is MMIO in the old IDE stack but the hardware appears to be doing
> > the required magic itself.
> 
> You cannot draw such a conclusion from looking only at the SIL680 chip. 
>    SIL680 might easily be behind a PCI bridge.

Not the one I have, nor it appears have there ever been any reports of
the problem on any system in years. That problem would show up if it
exists. It's also necessary that the chip can do its own timings in some
of its fancier modes.

The person who has the problem to worry about is Ben, but the older PMAC
stuff has its own implementation of all the DMA/IRQ/Command stuff as far
as I can see so its not relevant there.

Several years and zillions of users say there isn't a problem. The fact
we only enable the SIL680 mmio on libata also means its a rather
irrelevant discussion in the first place.

