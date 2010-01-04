From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 17:38:35 +0000
Message-ID: <20100104173835.3c5d3ea5@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<4B420871.2090309@garzik.org>
	<20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>
	<4B421827.6050308@garzik.org>
	<20100104170236.5d85959f@lxorguk.ukuu.org.uk>
	<4B42251A.9030106@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44886 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753609Ab0ADRfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:35:06 -0500
In-Reply-To: <4B42251A.9030106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

> Early SATA controllers are just PATA controllers in disguise.  All SFF 
> controllers want that 400ns delay.  The 400ns delay should -not- be avoided.

Its a signalling protocol requirement for PATA or a PATA controller with
a PATA/SATA bridge. What makes you think a SATA controller cares one
iota ?

> Because several SATA controllers are SFF and use the code in question, 
> the MMIO issue is relevant for the code change, even if it is irrelevant 
> to drivers/ata/pata_*.c.

and to SATA. It's simply not relevant at a protocol level to SATA which
is message passing anyway.
