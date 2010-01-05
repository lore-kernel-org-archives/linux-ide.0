From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Tue, 5 Jan 2010 11:25:37 +0000
Message-ID: <20100105112537.48ae5800@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<4B420871.2090309@garzik.org>
	<20100104154212.GA18335@flint.arm.linux.org.uk>
	<4B429EC3.9090305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38553 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752395Ab0AELWN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 06:22:13 -0500
In-Reply-To: <4B429EC3.9090305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> Indeed, which is why I suspect that a global change to handle this 
> controller may not be a good idea. Overriding sff_exec_command for this 
> driver to not do the altstatus read (just wait 600ns, maybe) might be 
> the best solution for now.

Old IDE does 400nS and no read. We know that works. At least for all the
standard PATA controllers. Thats an incredibly strong argument for doing
command issue that way for non MMIO controllers.

The MMIO case is muddy and probably simply does not matter because no
sane hardware implementation is not going to handle it internally.

Alan
