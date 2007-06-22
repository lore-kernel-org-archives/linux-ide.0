From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add pata_dma option so users can disable
 pata_dma as they can with old-ide
Date: Fri, 22 Jun 2007 16:52:21 +0100
Message-ID: <20070622165221.2ce648f6@the-village.bc.nu>
References: <20070622144939.026ed6ac@the-village.bc.nu>
	<467BE435.5000001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58106 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757578AbXFVPqs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 11:46:48 -0400
In-Reply-To: <467BE435.5000001@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, davej@redhat.com, linux-ide@vger.kernel.org

On Fri, 22 Jun 2007 11:01:09 -0400
Mark Lord <liml@rtr.ca> wrote:

> Alan Cox wrote:
> > Allow
> > 
> > 	libata.pata_dma=0
> > 
> > to disable DMA (default is 1)
> > 
> > SATA is unaffected as disabling DMA for SATA makes no sense at all.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Alan,
> 
> Should we really be piling up like this on global boot/module options
> rather than run-time flags on individual channels/devices ?
> 
> I can imagine systems with internal notebook drives that want dma=1,
> plus Cardbus CF devices that require dma=0.
> 
> With a single global flag, how does one do that?

We need proper tuning as well but there is huge value (with distro hat
on especially) in a single "try this to get it installed and then we can
debug it" button. Same with the old IDE. Trying to guide users through
selecting specific channels/devices is going to be painful. I want
something that I can tell people to get them 'off the ground' and work
with them to sort the rest.

One possibility I did consider was it being a set of bit flags

Default 0x7

0x01		- Disk DMA
0x02		- CF DMA
0x04		- ATAPI DMA

then you'd tell folks "try 0" and "try 1" to get them up and going and
most would be blissfully unaware of the details of bitflags but still
happy

Jeff - any preference.
