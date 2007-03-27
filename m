From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Tue, 27 Mar 2007 17:24:21 +0100
Message-ID: <20070327172421.5838c99f@the-village.bc.nu>
References: <20070324064814.38720.qmail@web802.biz.mail.mud.yahoo.com>
	<4604D564.9010806@gmail.com>
	<4608A42D.6080403@garzik.org>
	<460928EB.8010605@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35826 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753897AbXC0PU4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 11:20:56 -0400
In-Reply-To: <460928EB.8010605@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Bob Stewart <bob@evoria.net>, linux-ide@vger.kernel.org

> > Alan, Mark, surely some ancient controller simply can't do LBA48 at all, 
> > even in PIO mode?
> 
> Mmm.. Alan has more docs in his possession than I do for those,
> but I'd expect such beasts to be somewhat rare.

The dumb controllers are generally ok. It's the "almost smart" ones and
the "I had some space left on my fpga and .." type controllers that tend
to break horribly.

Older promise needs ugly hacks to do LBA48 at all  (basically we lie to
the controller and set up for ATAPI), the Inic I suspect from the docs
does get it right in ADMAish mode as it has LBA48 sized command blocks.

One or two embedded devices just don't get the HOB stuff and the double
register feed right at all. LBA48 commands work but you get only half the
reply etc.

Older ALi just can't cope with LBA48 DMA as its own intelligence is just
the right level of half-smart (or half-dumb) to break. 

Also on the related TODO list is to add an "I'm too dumb to do DMA except
in sector size chunks" check_atapi_dma helper which should fix up old
promise a bit and perhaps ALi (whose FIFO engine also from playing
seems to need all the registers writing each command)
