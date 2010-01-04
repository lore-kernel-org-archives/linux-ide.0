From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 15:48:29 +0000
Message-ID: <20100104154829.08a7c54c@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<20100104151637.559c4780@lxorguk.ukuu.org.uk>
	<4B420A27.9060407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54730 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107Ab0ADPpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 10:45:04 -0500
In-Reply-To: <4B420A27.9060407@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

> How do you think one tests for command completion?  :)  There does not 
> seem to be a general problem reading AltStatus(BSY) during a DMA 
> transfer.  IDE driver and other well known codebases have been doing 
> that for decades.

You use altstatus if available but you can't do so for 400nS after
command issue.

> I think the undefined behavior is only where the AltStatus read occurs 
> before the 400ns period specified by ATA...  excising the AltStatus read 
> there (ata_sff_pause) should be fine for PIO, but problematic for MMIO 
> chipsets that need posted writes flushed prior to the 400ns delay.

Old IDE says no such chipsets exist. Probably because their own designers
would have been lynched by the in house software team ;)

