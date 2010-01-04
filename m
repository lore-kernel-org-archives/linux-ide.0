From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 15:16:37 +0000
Message-ID: <20100104151637.559c4780@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43740 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526Ab0ADPNQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 10:13:16 -0500
In-Reply-To: <20100104133024.GA10521@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org

> If the drive immediately starts the UDMA protocol after a write to the
> command register (as it probably will for the DMA WRITE command), then
> we'll be accessing the taskfile in the middle of the UDMA setup, which
> can't be good.  It's certainly a violation of the ATA specs.

I concur entirely - that wants pushing into the upstream kernel ASAP and
if its ok backporting. May also be worth seeing if that fixes the funny
in the ALi setup.
