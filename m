From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstraem-fixes] ata_piix: detect and clear spurious
 IRQs
Date: Tue, 25 Nov 2008 17:15:59 +0000
Message-ID: <20081125171559.222e499f@lxorguk.ukuu.org.uk>
References: <49263552.8090602@kernel.org>
	<492C30FC.2090200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48534 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbYKYRP4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 12:15:56 -0500
In-Reply-To: <492C30FC.2090200@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, 25 Nov 2008 12:08:12 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Tejun Heo wrote:
> > The DMA_IRQ bit in the bmdma status register is always set when IDEIRQ
> > is asserted allowing spurious IRQ detection.  Detect spurious IRQs and
> > clear them.  This protects ata_piix against nobody-cared which gets
> > reported not so rarely.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  drivers/ata/ata_piix.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> It's tough to call this #upstream-fixes material, unfortunately...  For 
> this late into -rc, I am very nervous about changing the ATA interrupt 
> path for millions of machines.

I would like to go through the PIIX errata first. There are some rules
about what registers may not be touched during a transfer on some of the
devices and breaking them is *bad*. I don't think this is a problem but
it makes me nervous.

Now the DF draining on the other hand ;)

Alan
