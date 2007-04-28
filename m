From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sun, 29 Apr 2007 00:56:55 +0100
Message-ID: <20070429005655.2e876829@the-village.bc.nu>
References: <4633AB75.7070107@rtr.ca>
	<4633B0A6.6090705@garzik.org>
	<20070428222502.26fc9bbc@the-village.bc.nu>
	<4633BEE7.8020005@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43065 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754437AbXD1Xxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 19:53:30 -0400
In-Reply-To: <4633BEE7.8020005@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> > This one does need dealing with. It happens in the real world and the old
> > IDE paths for this do get triggered and used now and then (we know this
> > because bugs in them were found). All it takes is a device and a
> > controller disagreeing about the length of a data transfer to get in a
> 
> How would they disagree (excluding human error)?

Human error with SG_IO is quite sufficient, or controller bugs. It
happens: we see it happen and stuff gets stuck that way sometimes when you
get a timeout. For some controllers a failure gets stuck because of the
FIFO magic they do.

> It's not really a good idea for SATA.  The "FIFO" often co-emulated by 
> the SATA controller and SATA phy.  You just want to kick SATA really 
> hard (i.e. bus reset and friends).

Possibly we need a per controller ->drain_fifo method if available. It's
precisely because the FIFO is "magic" that some of the PATA controllers
get stuck in a mess (eg they hold off IRQ until the FIFO is drained)

Alan
