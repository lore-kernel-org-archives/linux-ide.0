From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 15:55:44 +0000
Message-ID: <20100104155544.0c7dbfaa@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<20100104151637.559c4780@lxorguk.ukuu.org.uk>
	<4B420A27.9060407@garzik.org>
	<20100104154406.GB18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40972 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752965Ab0ADPwT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 10:52:19 -0500
In-Reply-To: <20100104154406.GB18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> That's not the problem here - with the printk's I've added, there's no
> way for the IO read/writes to come that fast.  Slowing down the IO
> accesses made no difference what so ever.

Doing it within 400nS of command setup is suspect at the ATA level and
can trivially fixed.

Sane PCI controllers (and quite a few less than sane ones) all implement
an AltStatus which can be checked for busy bits with DMA running or stall
that access until the DMA completes (wrongly in some CMD64x cases).

The 20246 implements its own magic 'am I busy' flag which old IDE
supports and libata doesn't. So as well as the ndelay(400) fix for PIO
controllers it needs pdc202xx_test_irq porting over to complete the fix.

Alan
