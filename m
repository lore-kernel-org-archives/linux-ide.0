From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: waits up to 10 microseconds for early irq problem
Date: Tue, 28 Nov 2006 09:42:20 -0500
Message-ID: <456C4ACC.1050806@rtr.ca>
References: <200611180759.34622.t.powa@gmx.de> <20061118002357.564dbb9d.akpm@osdl.org> <455F790C.2030509@garzik.org> <456BDCAC.4060609@tw.ibm.com> <456C4514.9090107@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:61967 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S935330AbWK1OmX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 09:42:23 -0500
In-Reply-To: <456C4514.9090107@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, matthieu castet <castet.matthieu@free.fr>, Tobias Powalowski <t.powa@gmx.de>

Albert Lee wrote:
> It's worthwhile to poll alt_status and wait for BSY to clear in this case. 

Polling the ATA ALT_STATUS register can take up to 600ns,
or the equivalent of several thousand wasted instructions
on a modern CPU.

It's only worthwhile if the poll was actually necessary.
My question is, do we really want this overhead in the hot path
on every single ATA interrupt, or should we instead simply blacklist
those devices with the problem?

Or perhaps be more clever in handling it:  If the device driver interrupt
routine see's BUSY still set after the normal ATA STATUS read,
*then* we could do the poll.  That way it never adds unnecessary overhead.

This is more than "just a single instruction" here.. it's the equivalent
of thousands of them, each time we read an ATA register.

Cheers
