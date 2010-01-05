From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Tue, 5 Jan 2010 13:37:39 +0000
Message-ID: <20100105133739.28d11761@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<4B420871.2090309@garzik.org>
	<20100104154212.GA18335@flint.arm.linux.org.uk>
	<4B429EC3.9090305@gmail.com>
	<20100105112537.48ae5800@lxorguk.ukuu.org.uk>
	<4B4337EA.1000504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40881 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119Ab0AENeQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 08:34:16 -0500
In-Reply-To: <4B4337EA.1000504@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

> To which old-IDE do you refer?  :)  This specific area of functionality 
> varies from 2.4.x to 2.6.x.  Old-Old-IDE even picks and chooses whether 
> or not to wait depending on protocol (PIO or not), something that has 
> changed in the more recent old-IDE code.

Which is irrelevant to the discussion.

> It's not muddy, the rules for MMIO are quite clear, as is kernel 
> practice for drivers driving MMIO-based hardware.

The IDE layer shows the SI3112 doesn't have this problem so we shouldn't
cripple it with Jeff paranoia.

> Any PATA MMIO controller on a PCI card -- pata_pdc2027x comes to mind -- 
> must handle this situation, because the PCI posting situation varies 
> depending on where you slot in your PCI card.  That's not something a 
> controller can really handle internally.

Of course it can. The controller can implement a 400nS delay internally
if it gets a back to back command write and a read of a tf register state.
Nobody implementing an MMIO controller is going to not do that because
avoiding an artificial posting stall is a big performance win. Compared
to the big chunk of logic they all have for fifo draining interlocks its
nothing. Without that its going to be cheaper to operate PIO cycles not
MMIO cycles !

My SI controllers at least don't seem to need any kind of posting
protection in MMIO mode. They seem to be handling it all internally
somehow - Try rdtsc/write to cmd/rdtsc/read status/rdtsc

Alan


